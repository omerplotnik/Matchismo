//
//  PlayingCard.m
//  assignment1_matchismo
//
//  Created by Omer Plotnik on 03/08/2020.
//  Copyright © 2020 lightricks. All rights reserved.
//

#import "PlayingCard.h"

static const int NO_POINTS = 0;
static const int SMALL_AMOUNT_OF_POINTS = 1;
static const int MEDIUM_AMOUNT_OF_POINTS = 4;
static const int GREAT_AMOUNT_OF_POINTS = 16;

@implementation PlayingCard

- (int)match:(NSArray *)otherCards
{
    int score = NO_POINTS;
    //2 card match option
    if ([otherCards count] == 1) {
        score = [self matchTwoCards:otherCards];
    }
    //3 card match option
    if ([otherCards count] == 2) {
        score = [self matchThreeCards:otherCards];
    }
    return score;
}

- (int)matchTwoCards:(NSArray *)otherCards
{
    int score = NO_POINTS;
    PlayingCard *otherCard = [otherCards firstObject];
    if (otherCard.rank == self.rank) {
        score = MEDIUM_AMOUNT_OF_POINTS;
    } else if ([otherCard.suit isEqualToString:self.suit]) {
        score = SMALL_AMOUNT_OF_POINTS;
    }
    return score;
}

-(int)matchThreeCards:(NSArray *)otherCards
{
    int score = NO_POINTS;
    PlayingCard *secondCard = [otherCards firstObject];
    PlayingCard *thirdCard = [otherCards lastObject];
    if (self.rank == secondCard.rank) {
        if (self.rank == thirdCard.rank) {
            score = GREAT_AMOUNT_OF_POINTS;
        }
        else {
            score = MEDIUM_AMOUNT_OF_POINTS;
        }
    }
    else if (self.rank == thirdCard.rank || secondCard.rank == thirdCard.rank) {
        score = MEDIUM_AMOUNT_OF_POINTS;
    }
    else if ([self.suit isEqualToString:secondCard.suit]) {
        if ([self.suit isEqualToString:thirdCard.suit]) {
            score = MEDIUM_AMOUNT_OF_POINTS;
        }
        else {
            score = SMALL_AMOUNT_OF_POINTS;
        }
    } else if([self.suit isEqualToString:thirdCard.suit] || [secondCard.suit isEqualToString:thirdCard.suit]) {
        score = SMALL_AMOUNT_OF_POINTS;
    }
    return score;
}


- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;
+ (NSArray *)validSuits
{
    return @[@"♥︎",@"♦︎",@"♠︎",@"♣︎"];
}

- (void)setSuit:(NSString *)suit
{
    if([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}
-(NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count]-1;
}

-(void)setRank: (NSUInteger) rank
{
    if(rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
