//
//  HCDViewController.m
//  HackClassDemos
//
//  Created by Rishi on 3/25/13.
//  Copyright (c) 2013 RishiNarang. All rights reserved.
//

#import "HCDViewController.h"

@interface HCDViewController ()

// Internal (i.e. non-public, or else we would put this in the .h) property
// declaration of the user's score
@property (nonatomic, assign) int score;

// Moves the mole to a random location on the screen
- (void)moveMole;

@end

@implementation HCDViewController

// The "@property" declarations are just that - only declarations that
// they exist. We need to synthesize the properties, which will actually
// create the getters and setters.
@synthesize scoreLabel = _scoreLabel;
@synthesize moleButton = _moleButton;
@synthesize score = _score; // Obj-C specific advantage: automatically defaults to 0
// For the more curious: the reason we do 'variable = _variable' is twofold. For
// one, it differentiates between the public method declarations and the actual
// reference to the instance field. To be precise, the getter and setter will be
// variable and setVariable, but to access the instance field directly, you would
// simply use _variable. For example, each pair of lines of code here do the same thing:
//
// > int a = [self score]; // in Java, you're probably more used to getScore
// > int a = _score;
//
// > [self setScore:1];
// > _score = 1;
//
// There's usually not too much of a difference between the two reads, but often
// setters have special memory management code, or just case-specific code, which
// makes calling setScore: different from just setting _score. This will make
// more sense later on.

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  
  // Every 1 second, call [self moveMole].
  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(moveMole) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)moleHit:(id)sender
{
  // Increment the score
  _score++;
  
  // Change the score label to reflect that the mole has been hit
  NSString *newScoreString = [NSString stringWithFormat:@"Score: %d", _score];
  [_scoreLabel setText:newScoreString];
}

- (void)moveMole
{
  // Generate a random x and y
  int x = rand() % 200 + 20;
  int y = rand() % 275 + 60;
  
  // Get the old frame, and change its x and y coordinates without modifying the size
  CGRect frame = [_moleButton frame];
  frame.origin.x = x;
  frame.origin.y = y;
  
  // Set the new frame
  [_moleButton setFrame:frame];
}


@end

