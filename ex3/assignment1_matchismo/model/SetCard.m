//
//  SetCard.m
//  assignment1_matchismo
//
//  Created by Omer Plotnik on 11/08/2020.
//  Copyright © 2020 lightricks. All rights reserved.
//

#import "SetCard.h"

static const int NO_POINTS = 0;
static const int GREAT_AMOUNT_OF_POINTS = 16;

@implementation SetCard

@synthesize suit = _suit;
+ (NSArray *)validSuits
{
    return @[@"▲",@"●",@"◼︎"];
}

- (void)setSuit:(NSString *)suit
{
    if([[SetCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}
-(NSString *)suit
{
    return _suit ? _suit : @"?";
}

@synthesize color = _color;
+ (NSArray *)validColors
{
    return @[@"blue",@"red",@"green"];
}

- (void)setColor:(NSString *)color
{
    if([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}
-(NSString *)color
{
    return _color ? _color : @"?";
}

@synthesize shading = _shading;
+ (NSArray *)validShadings
{
    return @[[NSNumber numberWithFloat:1], [NSNumber numberWithFloat:0.5] , [NSNumber numberWithFloat:0.01]];
}

- (void)setShading:(CGFloat)shading
{
    if([[SetCard validShadings] containsObject:[NSNumber numberWithFloat:shading]]) {
        _shading = shading;
    }
}
-(CGFloat)shading
{
    return _shading ? _shading : CGFLOAT_MIN;
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"1",@"2",@"3"];
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count] -1;
}

-(void)setRank: (NSUInteger) rank
{
    if(rank <= [SetCard maxRank]) {
        _rank = rank;
    }
}

-(NSString *)contents
{
    NSString * cardContents = @"";
    for (NSUInteger i = 0; i < self.rank; i++)
    {
        cardContents = [cardContents stringByAppendingString:_suit];
    }
    return cardContents;
}

-(int)match:(NSArray *)otherCards
{
    int score = NO_POINTS;
    if([self matchRank:otherCards] && [self matchSuit:otherCards] && [self matchColor:otherCards] && [self matchShading:otherCards])
    {
        score = GREAT_AMOUNT_OF_POINTS;
    }
    
    return score;
}

-(BOOL)matchRank:(NSArray *)otherCards
{
    SetCard *secondCard = [otherCards firstObject];
    SetCard *thirdCard = [otherCards lastObject];
    if (self.rank == secondCard.rank && self.rank == thirdCard.rank)
    {
        return YES;
    }
    if (self.rank != secondCard.rank && self.rank != thirdCard.rank && secondCard.rank != thirdCard.rank)
    {
        return YES;
    }
    return NO;
}

-(BOOL)matchSuit:(NSArray *)otherCards
{
    SetCard *secondCard = [otherCards firstObject];
    SetCard *thirdCard = [otherCards lastObject];
    if ([self.suit isEqualToString:secondCard.suit] && [self.suit isEqualToString:thirdCard.suit])
    {
        return YES;
    }
    if (![self.suit isEqualToString:secondCard.suit] && ![self.suit isEqualToString:thirdCard.suit] && ![secondCard.suit isEqualToString:thirdCard.suit])
    {
        return YES;
    }
    return NO;
}

-(BOOL)matchColor:(NSArray *)otherCards
{
    SetCard *secondCard = [otherCards firstObject];
    SetCard *thirdCard = [otherCards lastObject];
    if ([self.color isEqualToString:secondCard.color] && [self.color isEqualToString:thirdCard.color])
    {
        return YES;
    }
    if (![self.color isEqualToString:secondCard.color] && ![self.color isEqualToString:thirdCard.color] && ![secondCard.color isEqualToString:thirdCard.color])
    {
        return YES;
    }
    return NO;
}

-(BOOL)matchShading:(NSArray *)otherCards
{
    SetCard *secondCard = [otherCards firstObject];
    SetCard *thirdCard = [otherCards lastObject];
    if (self.shading == secondCard.shading && self.shading == thirdCard.shading)
    {
        return YES;
    }
    if (self.shading != secondCard.shading && self.shading != thirdCard.shading && secondCard.shading != thirdCard.shading)
    {
        return YES;
    }
    return NO;
}

@end
