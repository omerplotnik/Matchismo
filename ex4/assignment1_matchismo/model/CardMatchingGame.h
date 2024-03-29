//
//  CardMatchingGame.h
//  assignment1_matchismo
//
//  Created by Omer Plotnik on 05/08/2020.
//  Copyright © 2020 lightricks. All rights reserved.
//

#ifndef CardMatchingGame_h
#define CardMatchingGame_h

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

//designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (Card *)drawRandomCard;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSUInteger currentNumOfCards;
@property (nonatomic) BOOL matchTwo;
@property (nonatomic) BOOL cardsInDeck;


@end

#endif /* CardMatchingGame_h */
