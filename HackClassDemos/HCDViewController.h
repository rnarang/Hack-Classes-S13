//
//  HCDViewController.h
//  HackClassDemos
//
//  Created by Rishi on 3/25/13.
//  Copyright (c) 2013 RishiNarang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCDViewController : UIViewController

// Connection to the score label in HCDViewController.xib
@property (nonatomic, weak) IBOutlet UILabel *scoreLabel;

// Connection to the time remaining button in the xib file
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;

// Connection to the mole button in HCDViewController.xib
@property (nonatomic, weak) IBOutlet UIButton *moleButton;

// Method called when the mole button is tapped
- (IBAction)moleHit:(id)sender;

@end
