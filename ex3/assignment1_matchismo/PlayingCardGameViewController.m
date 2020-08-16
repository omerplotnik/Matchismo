//
//  PlayingCardGameViewController.m
//  assignment1_matchismo
//
//  Created by Omer Plotnik on 11/08/2020.
//  Copyright © 2020 lightricks. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import <Foundation/Foundation.h>
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"


@interface PlayingCardGameViewController()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UILabel *activityLabel;

@end

@implementation PlayingCardGameViewController

-(Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}


- (void)updateUI
{
  [super updateUI];
  for (UIButton *cardButton in self.cardButtons) {
    NSInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
    Card *card = [self.game cardAtIndex:cardButtonIndex];
    [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
    [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
    cardButton.enabled = !card.isMatched;
  }
}

// Used to get card's title to be presented on card button.
- (NSAttributedString *)titleForCard:(Card *)card
{
  if (card.isChosen) {
    return [[NSAttributedString alloc] initWithString:card.contents];
  } else {
    return [[NSAttributedString alloc] initWithString:@""];
  }
}

// Used to get card's title to be presented on current activity label.
- (NSAttributedString *)cardTitleForLabel:(Card *)card
{
  return [[NSAttributedString alloc] initWithString:card.contents];
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
