//
//  HCDViewController.h
//  HackClassDemos
//
//  Created by Rishi on 3/25/13.
//  Copyright (c) 2013 RishiNarang. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kHCDHighScoresArrayKey;

@interface HCDViewController : UIViewController

// Connection to the score label in HCDViewController.xib
@property (nonatomic, weak) IBOutlet UILabel *scoreLabel;

// Connection to the mole button in HCDViewController.xib
@property (nonatomic, weak) IBOutlet UIButton *moleButton;

// Connection to the time remaining button in the xib file
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;

// Method called when the mole button is tapped
- (IBAction)moleHit:(id)sender;

// Method called when the reset button is tapped
- (IBAction)resetTapped:(id)sender;

@end
