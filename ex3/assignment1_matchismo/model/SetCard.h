//
//  SetCard.h
//  assignment1_matchismo
//
//  Created by Omer Plotnik on 11/08/2020.
//  Copyright © 2020 lightricks. All rights reserved.
//

#import "Card.h"
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface SetCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *color;
@property (nonatomic) CGFloat shading;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;
+ (NSArray *)validColors;
+ (NSArray *)validShadings;



@end

NS_ASSUME_NONNULL_END
