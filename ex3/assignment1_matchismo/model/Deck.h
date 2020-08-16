//
//  Deck.h
//  assignment1_matchismo
//
//  Created by Omer Plotnik on 03/08/2020.
//  Copyright © 2020 lightricks. All rights reserved.
//

#ifndef Deck_h
#define Deck_h

#import "Card.h"
#import <Foundation/Foundation.h>


@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end

#endif /* Deck_h */
