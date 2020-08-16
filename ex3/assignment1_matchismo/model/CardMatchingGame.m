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
@property (nonatomic, strong) NSMutableArray *cards; //of cards

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
    
    self.matchTwo = YES;
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

- (NSMutableArray *)activeCards
{
  if (!_activeCards)
  {
    _activeCards = [[NSMutableArray alloc] init];
  }
  return _activeCards;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index<[self.cards count]) ? self.cards[index] : nil;
}


- (void)chooseCardAtIndex:(NSUInteger)index
{
  
  Card *card = [self cardAtIndex:index];
  [self updateActiveCardsWithCurrentCard:card];
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
        } else {
            self.score -= MISMATCH_PENALTY;
            secondCard.chosen = NO;
            thirdCard.chosen = NO;
        }
    }
}

- (void)updateActiveCardsWithCurrentCard:(Card *)card
{
  if ([self.activeCards containsObject:card]) {
    [self.activeCards removeObject:card];
  } else {
    [self.activeCards addObject:card];
  }
}

- (void)updateActiveCardsAtTheEndOfATurn
{
  NSUInteger numOfActiveCards = [self.activeCards count];
  while (numOfActiveCards > 0) {
    numOfActiveCards--;
    Card *firstCard = [self.activeCards firstObject];
    if (!firstCard.isChosen || firstCard.matched){
      [self.activeCards removeObjectAtIndex:0];
    }
  }
}

@end
