//
//  ViewController.h
//  assignment1_matchismo
//
//  Created by Omer Plotnik on 03/08/2020.
//  Copyright © 2020 lightricks. All rights reserved.


// abstract class

#import "CardMatchingGame.h"
#import <UIKit/UIKit.h>
#import "CardView.h"
#import "Grid.h"


@interface CardGameViewController : UIViewController

// protected for subclasses
- (Deck *)createDeck; // abstract
- (void)updateUI;
- (void)tap:(UITapGestureRecognizer *)gesture;
- (void)addThreeCards;  // extended by subclasses
- (CardView *)createNewCardViewWithFrameWithFrame:(CGRect)frame // extended by subclasses
                                          andCard:(Card *)card;



@property (strong, nonatomic) CardMatchingGame *game;

@property (strong, nonatomic) NSMutableArray *cardViews;

@property (weak, nonatomic) IBOutlet UIView *gridView;

@property (strong, nonatomic) Grid *grid;

@property (weak, nonatomic) IBOutlet UIButton *addThreeCardsButton;
@end
