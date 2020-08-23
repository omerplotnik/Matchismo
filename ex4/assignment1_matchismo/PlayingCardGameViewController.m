//
//  PlayingCardGameViewController.m
//  assignment1_matchismo
//
//  Created by Omer Plotnik on 11/08/2020.
//  Copyright © 2020 lightricks. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import <Foundation/Foundation.h>
#import "PlayingCard.h"
#import "PlayingCardDeck.h"
#import "PlayingCardView.h"


@interface PlayingCardGameViewController()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UILabel *activityLabel;

@property (weak, nonatomic) IBOutlet PlayingCardView *testCard;
@end

@implementation PlayingCardGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}


-(Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}


- (CardView *)createNewCardViewWithFrameWithFrame:(CGRect)frame
                                          andCard:(Card *)card {
  PlayingCardView *cardView  = [[PlayingCardView alloc] initWithFrame:frame];
  if ([card isKindOfClass:[PlayingCard class]]) {
    PlayingCard *playingCard = (PlayingCard *)card;
    cardView.rank = playingCard.rank;
    cardView.suit = playingCard.suit;
  }
  [cardView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                  initWithTarget:self
                                  action:@selector(tap:)]];
  return cardView;
}


- (void)animateViewFlip:(CardView *)cardView toFaceUP:(BOOL)up
{
  if (cardView.isChosen != up) {
    [UIView transitionWithView:cardView duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
      cardView.isChosen = up;
    }
    completion:^(BOOL finished) {}];
  }
}


@end

