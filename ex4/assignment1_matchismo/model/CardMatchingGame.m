//
//  CardMatchingGame.m
//  assignment1_matchismo
//
//  Created by Omer Plotnik on 05/08/2020.
//  Copyright © 2020 lightricks. All rights reserved.
//

#import "CardMatchingGame.h"

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSUInteger currentNumOfCards;
@property (nonatomic, strong) NSMutableArray *cards; //of cards
@property (strong, nonatomic) Deck *deck;

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    self = [super init];
    self.deck = deck;
    self.matchTwo = YES;
    self.currentNumOfCards = 0;
    if ( self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}


- (Card *)drawRandomCard{
  Card *card = self.deck.drawRandomCard;
  [self.cards addObject:card];
  self.currentNumOfCards++;
  return card;
}

- (BOOL)cardsInDeck {
  if (self.deck.cardsInDeck == 0) {
    return NO;
  }
  return YES;
}



- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index<[self.cards count]) ? self.cards[index] : nil;
}


- (void)chooseCardAtIndex:(NSUInteger)index
{
  
  Card *card = [self cardAtIndex:index];
  if (!card.isMatched) {
    if (card.isChosen) {
      card.chosen = NO;
    } else {
        if (self.matchTwo) {
          [self match2Mode:card];
                
        } else {
            [self match3Mode:card];
                
        }
        self.score -= COST_TO_CHOOSE;
        card.chosen = YES;
    }
  }
}

- (void)match2Mode:(Card *)card
{
    for (Card *otherCard in self.cards) {
      if (otherCard.isChosen && !otherCard.isMatched) {
        int matchScore = [card match:@[otherCard]];
          if (matchScore) {
            self.score += matchScore * MATCH_BONUS;
            otherCard.matched = YES;
            card.matched = YES;
            self.currentNumOfCards = self.currentNumOfCards - 2;
                                
        } else {
            self.score -= MISMATCH_PENALTY;
            otherCard.chosen = NO;
        }
      break; // can only choose 2 cards for now
    }
  }
}

- (void)match3Mode:(Card *)card
{

    // match against other chosen cards
    NSMutableArray *otherCards = [[NSMutableArray alloc] init];
    for (Card *otherCard in self.cards) {
        if (otherCard.isChosen && !otherCard.isMatched) {
                    [otherCards addObject:otherCard];
        }
    }
    if ([otherCards count] == 2) {
        int matchScore = [card match:otherCards];
        Card *secondCard = [otherCards firstObject];
        Card *thirdCard = [otherCards lastObject];
        if (matchScore) {
            self.score += matchScore * MATCH_BONUS;
                        
            secondCard.matched = YES;
            thirdCard.matched = YES;
            card.matched = YES;
            self.currentNumOfCards = self.currentNumOfCards - 3;
        } else {
            self.score -= MISMATCH_PENALTY;
            secondCard.chosen = NO;
            thirdCard.chosen = NO;
        }
    }
}



@end
