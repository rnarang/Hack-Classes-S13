//
//  HCDViewController.m
//  HackClassDemos
//
//  Created by Rishi on 3/25/13.
//  Copyright (c) 2013 RishiNarang. All rights reserved.
//

#import "HCDViewController.h"

@interface HCDViewController ()

@property (nonatomic, assign) int score;

- (void)moveMole;

@end

@implementation HCDViewController

@synthesize scoreLabel = _scoreLabel;
@synthesize moleButton = _moleButton;
@synthesize score = _score;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(moveMole) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)moleHit:(id)sender
{
  _score++;
  NSString *newScoreString = [NSString stringWithFormat:@"Score: %d", _score];
  [_scoreLabel setText:newScoreString];
}

- (void)moveMole
{
  int x = rand() % 200 + 20;
  int y = rand() % 275 + 60;
  
  CGRect oldFrame = [_moleButton frame];
  oldFrame.origin.x = x;
  oldFrame.origin.y = y;
  
  [_moleButton setFrame:oldFrame];
}

@end





