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
- (void)updateActiveCardsAtTheEndOfATurn;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) BOOL matchTwo;
@property (strong, nonatomic) NSString* gameHistory;
@property (strong, nonatomic) NSMutableArray *activeCards;


@end

#endif /* CardMatchingGame_h */
