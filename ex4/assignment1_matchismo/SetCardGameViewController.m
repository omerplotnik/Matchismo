//
//  SetCardGameViewController.m
//  assignment1_matchismo
//
//  Created by Omer Plotnik on 11/08/2020.
//  Copyright © 2020 lightricks. All rights reserved.
//

#import "SetCardGameViewController.h"
#import <UIKit/UIKit.h>

#import "SetCard.h"
#import "SetCardDeck.h"
#import "SetCardView.h"

@interface SetCardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *activityLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (strong, nonatomic) NSMutableAttributedString *currentActivityString;

@property (weak, nonatomic) IBOutlet SetCardView *testCard;

@end

@implementation SetCardGameViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [self updateUI];
}


- (CardView *)createNewCardViewWithFrameWithFrame:(CGRect)frame
                                          andCard:(Card *)card {
  SetCardView *cardView  = [[SetCardView alloc] initWithFrame:frame];
  if ([card isKindOfClass:[SetCard class]]) {
    SetCard *setCard = (SetCard *)card;
    cardView.rank = setCard.rank;
    cardView.suit = setCard.suit;
    cardView.color = setCard.color;
    cardView.shading = setCard.shading;
  }
  [cardView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                  initWithTarget:self
                                  action:@selector(tap:)]];
  return cardView;
}


- (void)animateViewFlip:(CardView *)cardView toFaceUP:(BOOL)up {
  cardView.isChosen = up;
}

- (CardMatchingGame *)game
{
    CardMatchingGame* game = [super game];
    if(game) {
        game.matchTwo = NO;
    }
    return game;
}


-(Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}


@end
