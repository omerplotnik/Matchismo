//
//  GameHistoryViewController.m
//  assignment1_matchismo
//
//  Created by Omer Plotnik on 12/08/2020.
//  Copyright © 2020 lightricks. All rights reserved.
//

#import "GameHistoryViewController.h"

@interface GameHistoryViewController ()

@property (weak, nonatomic) IBOutlet UITextView *historyTextView;

@end

@implementation GameHistoryViewController

-(void)setHistory:(NSAttributedString *)history
{
    _history = history;
    if (self.view.window)
    {
        [self updateUI];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

-(void)updateUI
{
    self.historyTextView.attributedText = self.history;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
