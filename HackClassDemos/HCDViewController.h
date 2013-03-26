//
//  HCDViewController.h
//  HackClassDemos
//
//  Created by Rishi on 3/25/13.
//  Copyright (c) 2013 RishiNarang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCDViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *scoreLabel;

@property (nonatomic, weak) IBOutlet UIButton *moleButton;

- (IBAction)moleHit:(id)sender;

@end
