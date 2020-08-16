//
//  SetCardGameViewController.m
//  assignment1_matchismo
//
//  Created by Omer Plotnik on 11/08/2020.
//  Copyright © 2020 lightricks. All rights reserved.
//

#import "SetCardGameViewController.h"
#import <UIKit/UIKit.h>

#import "CardGameViewController.h"
#import "SetCard.h"
#import "SetCardDeck.h"

@interface SetCardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *activityLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (strong, nonatomic) NSMutableAttributedString *currentActivityString;

@end

@implementation SetCardGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateUI];
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


- (void)updateUI
{
  [super updateUI];
  for (UIButton *cardButton in self.cardButtons) {
    NSInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
    Card *card = [self.game cardAtIndex:cardButtonIndex];
    [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
    [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
    cardButton.enabled = !card.isMatched;
  }
}

// Used to get card's title to be presented on card button.
- (NSAttributedString *)titleForCard:(Card *)card
{
    NSString* cardString = card.contents;
    NSMutableAttributedString* cardTitle = [[NSMutableAttributedString alloc] initWithString:cardString];
    if ([card isKindOfClass:SetCard.class]) {
        SetCard* setCard = (SetCard *)card;
        CGFloat shading = setCard.shading;
        UIColor* color = [[self cardColor:setCard] colorWithAlphaComponent:shading];
        UIColor* strokeColor = [self cardColor:setCard];
        [cardTitle addAttributes:@{NSForegroundColorAttributeName : color, NSStrokeWidthAttributeName : @-5, NSStrokeColorAttributeName : strokeColor} range:NSMakeRange(0, cardTitle.length)];
    }
    //
    
    return cardTitle;
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfrontchosen" : @"cardfront"];
}
         
- (UIColor *)cardColor:(SetCard *)card
{
    NSDictionary* colorDict = @{@"blue" : [UIColor blueColor], @"red" : [UIColor redColor], @"green" : [UIColor greenColor]};
    if([card.color isEqualToString:@"blue"])
    {
        return [UIColor blueColor];
    } else if([card.color isEqualToString:@"red"])
    {
        return [UIColor redColor];
    } else if([card.color isEqualToString:@"green"])
    {
        return [UIColor greenColor];
    }
    return colorDict[card.color];
}

// Used to get card's title to be presented on current activity label.
- (NSAttributedString *)cardTitleForLabel:(Card *)card
{
  return [self titleForCard:card];
}


@end
