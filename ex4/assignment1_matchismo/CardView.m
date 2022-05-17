//
//  CardView.m
//  assignment1_matchismo
//
//  Created by Omer Plotnik on 18/08/2020.
//  Copyright © 2020 lightricks. All rights reserved.
//

#import "CardView.h"

@implementation CardView


- (void)setIsChosen:(BOOL)isChosen
{
    _isChosen = isChosen;
    [self setNeedsDisplay];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
