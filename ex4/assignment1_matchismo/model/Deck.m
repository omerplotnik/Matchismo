//
//  Deck.m
//  assignment1_matchismo
//
//  Created by Omer Plotnik on 03/08/2020.
//  Copyright © 2020 lightricks. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation Deck
- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
}

-(void)addCard:(Card *)card
{
    [self addCard:card atTop:NO];
}

-(Card *)drawRandomCard
{
    Card *randomCard = nil;
    
    if ([self.cards count]) {
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    self.cardsInDeck--;
    return randomCard;
}

@end
