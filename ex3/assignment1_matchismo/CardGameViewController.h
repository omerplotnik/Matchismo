//
//  ViewController.h
//  assignment1_matchismo
//
//  Created by Omer Plotnik on 03/08/2020.
//  Copyright © 2020 lightricks. All rights reserved.


// abstract class

#import "CardMatchingGame.h"
#import <UIKit/UIKit.h>
#import "Deck.h"


@interface CardGameViewController : UIViewController

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic, readonly) IBOutletCollection(UIButton) NSArray *cardButtons;


// protected for subclasses
- (Deck *)createDeck; // abstract
- (void)updateUI;  // extended by subclasses
- (NSAttributedString *)cardTitleForLabel:(Card *)card; //abstract

@end
