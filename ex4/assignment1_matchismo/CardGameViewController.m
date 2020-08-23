//
//  ViewController.m
//  assignment1_matchismo
//
//  Created by Omer Plotnik on 03/08/2020.
//  Copyright © 2020 lightricks. All rights reserved.
//

#import "CardGameViewController.h"


@interface CardGameViewController ()


@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (strong, nonatomic) UIDynamicAnimator *stackAnimator;
@property (strong, nonatomic) NSMutableArray *stackAttachmentArray;
@property (nonatomic) BOOL stackMode;

@end

@implementation CardGameViewController

static const CGFloat kInitialGridSize = 52;
static const CGFloat kCardBatchSize = 3;
static const CGFloat kInitialNumberOfCardBatches = 4;

#pragma mark - Getters

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    return _game;
}


- (Deck *)createDeck
{
    return nil; //abstract
}

- (NSMutableArray *)cardViews {
  if (!_cardViews) {
    _cardViews = [[NSMutableArray alloc] init];
  }
  return _cardViews;
}

- (Grid *)grid {
  if (!_grid) {
    _grid = [[Grid alloc] init];
    _grid.cellAspectRatio = 2.0 / 3.0;
    _grid.size = self.gridView.bounds.size;
    _grid.minimumNumberOfCells = kInitialGridSize;
  }
  return _grid;
}

- (UIDynamicAnimator *)stackAnimator {
  if (!_stackAnimator) {
    _stackAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.gridView];
  }
  return _stackAnimator;
}

- (NSMutableArray *)stackAttachmentArray {
  if (!_stackAttachmentArray) {
    _stackAttachmentArray = [[NSMutableArray alloc] init];
  }
  return _stackAttachmentArray;
}


#pragma mark - Life cycle

- (void)viewDidLoad {
  [super viewDidLoad];
  [self initiateCardsOnGrid];
}


- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  if (self.grid.size.height != self.gridView.bounds.size.height) {
    self.grid.size = self.gridView.bounds.size;
    [self updateUI];
  }
}


#pragma mark - Adding cards

- (IBAction)touchNewGameButton:(id)sender
{
  _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
  for (CardView *cardView in self.cardViews) {
    [self takeOut:cardView];
  }
  [_cardViews removeAllObjects];
  [self initiateCardsOnGrid];
  self.addThreeCardsButton.enabled = YES;
}


- (void)initiateCardsOnGrid {

  for (NSUInteger i = 0; i < kInitialNumberOfCardBatches; i++) {
    [self addThreeCards];
  }
  [self updateUI];
}


- (IBAction)addThreeCards:(id)sender {
  [self addThreeCards];
}


- (void)addThreeCards{
  for (NSUInteger i = 0; i < kCardBatchSize; i++) {
    if(self.game.cardsInDeck) {
      Card *card = [self.game drawRandomCard];
      CardView *cardView = [self createNewCardViewWithFrameWithFrame:self.addThreeCardsButton.frame andCard:card];

      [self.gridView addSubview:cardView];
      [self.cardViews addObject:cardView];
    } else {
      self.addThreeCardsButton.enabled = NO;
    }
  }
  if(!self.game.cardsInDeck) {
    self.addThreeCardsButton.enabled = NO;
  }
  [self updateUI];
}

//to be extended by sub classes
- (CardView *)createNewCardViewWithFrameWithFrame:(CGRect)frame
                                          andCard:(Card *)card {
  CardView *cardView = [[CardView alloc] init];
  return cardView;
}


#pragma mark - Update UI

- (void)updateUI
{
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
  self.grid.minimumNumberOfCells = self.game.currentNumOfCards;
  [self updateCardsStatus];
  [self updateCardPositions];
}


- (void) updateCardsStatus {
  for (CardView *cardView in self.cardViews) {
    NSInteger cardViewIndex = [self.cardViews indexOfObject:cardView];
    Card *card = [self.game cardAtIndex:cardViewIndex];
    [self animateViewFlip:(CardView *)cardView toFaceUP:(BOOL)card.isChosen];
    cardView.matched = card.matched;
  }
}


- (void)updateCardPositions {
  NSUInteger row = 0;
  NSUInteger column = 0;
  
  for (CardView *cardView in self.cardViews) {
    if (!cardView.matched) {
      CGRect cardFrameRect = [self.grid frameOfCellAtRow:row inColumn:column];
      
      [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        cardView.frame = cardFrameRect;
      } completion:^(BOOL finished) {
        
      }];
      cardView.frame = cardFrameRect;
      
      column++;
      if (column >= self.grid.columnCount) {
        column = 0;
        row++;
      }
    } else {
      [self takeOut:cardView];
    }
  }
}


- (void)takeOut:(CardView *)cardView {
  CGRect cardExitRect = CGRectMake(-self.addThreeCardsButton.frame.origin.x, -self.addThreeCardsButton.frame.origin.x, self.addThreeCardsButton.frame.size.width, self.addThreeCardsButton.frame.size.width);
  [UIView animateWithDuration:3
                        delay:0.0
                      options:UIViewAnimationOptionCurveEaseOut animations:^{
    cardView.alpha = 0.0;
    cardView.frame = cardExitRect;
  }
                   completion:^(BOOL finished) {
    if (finished) {
      [cardView removeFromSuperview];
    }
  }];
}


#pragma mark - Gestures


- (IBAction)stackByPinch:(id)sender {
  self.stackMode = YES;
  CGPoint gesturePoint = [sender locationInView:self.gridView];
  [self stackCardsTo:gesturePoint];
}


- (void)stackCardsTo:(CGPoint)anchorPoint {
  for (CardView *cardView in self.cardViews) {
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
      cardView.frame = CGRectMake(anchorPoint.x, anchorPoint.y, cardView.frame.size.width, cardView.frame.size.height);
    } completion:^(BOOL finished) {
      
    }];
    UIAttachmentBehavior* cardAttachment = [[UIAttachmentBehavior alloc] initWithItem:cardView attachedToAnchor:anchorPoint];
    [self.stackAnimator addBehavior:cardAttachment];
    [self.stackAttachmentArray addObject:cardAttachment];
  }
}


- (IBAction)moveStack:(id)sender {
  CGPoint gesturePoint = [sender locationInView:self.gridView];
  for (UIAttachmentBehavior *cardAttachment in self.stackAttachmentArray) {
    cardAttachment.anchorPoint = gesturePoint;
  }
}


- (void)tap:(UITapGestureRecognizer *)gesture;
{
  if ([gesture.view isKindOfClass:[CardView class]]){
    if (self.stackMode) {
      [self unStackCards];
      
    } else {
      CardView *cardView = (CardView *)gesture.view;
      [self flipCard:cardView];
    }
  }
}


- (void)unStackCards {
  self.stackMode = NO;
  for (UIAttachmentBehavior *cardAttachment in self.stackAttachmentArray) {
    [self.stackAnimator removeBehavior:cardAttachment];
  }
  [self.stackAttachmentArray removeAllObjects];
  [self updateUI];
}


- (void)flipCard:(CardView *)cardView {
  NSUInteger chosenViewIndex = [self.cardViews indexOfObject:cardView];
  [self.game chooseCardAtIndex:chosenViewIndex];
  [self updateUI];
}

- (void)animateViewFlip:(CardView *)cardView toFaceUP:(BOOL)up
{
  //abstract
}


@end
