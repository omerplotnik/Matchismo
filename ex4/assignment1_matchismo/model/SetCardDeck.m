//
//  SetCardDeck.m
//  assignment1_matchismo
//
//  Created by Omer Plotnik on 11/08/2020.
//  Copyright © 2020 lightricks. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

static const NSUInteger kCardsInDeck = 81;

-(instancetype) init
{
    self = [super init];
    
    if(self) {
        for (NSString *suit in [SetCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [SetCard maxRank]; rank++) {
                for (NSString *color in [SetCard validColors]){
                    for (NSString *shading in [SetCard validShadings]) {
                        SetCard *card = [[SetCard alloc] init];
                        card.rank = rank;
                        card.suit = suit;
                        card.color = color;
                        card.shading = [shading doubleValue];
                        [self addCard:card];
                    }
                }
            }
        }
    }
    self.cardsInDeck = kCardsInDeck;
    return self;
}


@end
