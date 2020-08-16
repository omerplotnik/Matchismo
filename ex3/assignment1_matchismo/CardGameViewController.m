//
//  ViewController.m
//  assignment1_matchismo
//
//  Created by Omer Plotnik on 03/08/2020.
//  Copyright © 2020 lightricks. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "GameHistoryViewController.h"

@interface CardGameViewController ()


@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UILabel *activityLabel;

@property (strong, nonatomic) NSMutableAttributedString *currentActivityString;

@property (strong, nonatomic) NSMutableAttributedString *currentGameHistory;

@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    return _game;
}


- (Deck *)createDeck
{
    return nil; //abstract
}


- (IBAction)touchNewGameButton:(id)sender
{
    
  _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
  [self updateUI];
  self.activityLabel.text = @"";
  [self.currentActivityString setAttributedString:[[NSAttributedString alloc] initWithString:@""]];
  [self.currentGameHistory setAttributedString:[[NSAttributedString alloc] initWithString:@""]];
}

- (NSMutableAttributedString *)currentGameHistory
{
  if (!_currentGameHistory) {
    _currentGameHistory = [[NSMutableAttributedString alloc] initWithString:@""];
  }
  return _currentGameHistory;
}


- (IBAction)touchCardButton:(UIButton *)sender
{
  NSInteger preTouchScore = self.game.score;
  NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
  [self.game chooseCardAtIndex:chosenButtonIndex];
  [self writeHistoryWithPreviousRoundScore:preTouchScore];
  [self.game updateActiveCardsAtTheEndOfATurn];
  [self updateUI];
}


- (void)writeHistoryWithPreviousRoundScore:(NSInteger)prevScore
{
  if(!self.currentActivityString) {
    self.currentActivityString = [[NSMutableAttributedString alloc] initWithString:@""];
  }
  NSInteger deltaScore = self.game.score - prevScore;
  if (deltaScore == 0) {
    [self.currentActivityString setAttributedString:[[NSAttributedString alloc] initWithString:@""]];
  } else if (deltaScore == -1) {
    Card *currentCard = [self.game.activeCards lastObject];
    NSAttributedString *currentCardTitle = [self cardTitleForLabel:currentCard];
    [self.currentActivityString setAttributedString:currentCardTitle];
  } else if (deltaScore > 0) {
    [self.currentActivityString setAttributedString:[self writeMatchStringWithScore:deltaScore + 1]];
  } else {
    [self.currentActivityString setAttributedString:[self writeDismatchStringWithScore:deltaScore + 1]];
  }
  
  if ([self.currentGameHistory length] == 0) {
    [self.currentGameHistory setAttributedString:self.currentActivityString];
  } else {
    [self.currentGameHistory appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    [self.currentGameHistory appendAttributedString:self.currentActivityString];
  }
}


- (NSMutableAttributedString *)writeMatchStringWithScore:(NSInteger)score
{
  NSMutableAttributedString *matchString = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
  for (Card *card in self.game.activeCards) {
    [matchString appendAttributedString:[self cardTitleForLabel:card]];
    [matchString appendAttributedString:[[NSAttributedString alloc] initWithString:@","]];
  }
  NSString *restOfString = [NSString stringWithFormat:@" for %ld points!" ,(long)score];
  [matchString appendAttributedString:[[NSAttributedString alloc] initWithString:restOfString]];
  
  return matchString;
}


- (NSMutableAttributedString *)writeDismatchStringWithScore:(NSInteger)score
{
  NSMutableAttributedString *dismatchString = [[NSMutableAttributedString alloc] initWithString:@""];
  for (Card *card in self.game.activeCards) {
    [dismatchString appendAttributedString:[self cardTitleForLabel:card]];
    [dismatchString appendAttributedString:[[NSAttributedString alloc] initWithString:@","]];
  }
  NSString *restOfString = [NSString stringWithFormat:@" doesn't match! %ld points penalty!" ,(long)score];
  [dismatchString appendAttributedString:[[NSAttributedString alloc] initWithString:restOfString]];

  return dismatchString;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Card game history"]) {
        if([segue.destinationViewController isKindOfClass:[GameHistoryViewController class]]){
          GameHistoryViewController *historyController = (GameHistoryViewController *)segue.destinationViewController;
          historyController.history = [[NSAttributedString alloc] initWithAttributedString:self.currentGameHistory];
        }
    }
}


- (void)updateUI
{
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
  self.activityLabel.attributedText = self.currentActivityString;
}


- (NSAttributedString *)cardTitleForLabel:(Card *)card
{
  return nil; //abstract
}
@end
