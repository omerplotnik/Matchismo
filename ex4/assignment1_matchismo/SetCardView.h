//
//  SetCardView.h
//  assignment1_matchismo
//
//  Created by Omer Plotnik on 17/08/2020.
//  Copyright © 2020 lightricks. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "CardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCardView : CardView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@property (strong, nonatomic) NSString *color;
@property (nonatomic) CGFloat shading;

@end

NS_ASSUME_NONNULL_END
