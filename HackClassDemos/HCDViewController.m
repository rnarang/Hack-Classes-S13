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

// Number of seconds left before game over
@property (nonatomic, assign) int secondsLeft;

// Reference to the timer that handles moving the mole
@property (nonatomic, strong) NSTimer *moleTimer;

// Reference to the timer that handles changing the label for the number of seconds left
@property (nonatomic, strong) NSTimer *clockTimer;

// Moves the mole to a random location on the screen
- (void)moveMole;

// Decrements the number of seconds left and updates the label
- (void)decrementTimer;

// Reset the score, timers, labels, etc.
- (void)initializeGameState;

// Update the timer label
- (void)updateTimerLabel:(int)secondsLeft;

// Update the score label
- (void)updateScoreLabel:(int)score;

@end

@implementation HCDViewController

// The "@property" declarations are just that - only declarations that
// they exist. We need to synthesize the properties, which will actually
// create the getters and setters.
@synthesize scoreLabel = _scoreLabel;
@synthesize timeLabel = _timeLabel;
@synthesize moleButton = _moleButton;
@synthesize secondsLeft = _secondsLeft;
@synthesize moleTimer = _moleTimer;
@synthesize clockTimer = _clockTimer;
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
  
  [self initializeGameState];
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
  [self updateScoreLabel:_score];
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

- (void)decrementTimer
{
  // Decrement the number of seconds left
  _secondsLeft--;
  
  // Update the timer label
  [self updateTimerLabel:_secondsLeft];
  
  // If the game is over, invalidate the timers to stop the calls to decrementTimer
  // and moveMole, and hide the button.
  if (_secondsLeft == 0) {
    [_moleTimer invalidate];
    [_clockTimer invalidate];
    [_moleButton setHidden:YES];
  }
}

- (void)initializeGameState
{
  [_moleTimer invalidate];
  [_clockTimer invalidate];
  
  // Every 0.6 seconds, call [self moveMole].
  _moleTimer = [NSTimer scheduledTimerWithTimeInterval:0.6 target:self selector:@selector(moveMole) userInfo:nil repeats:YES];
  
  // Every 1 second, call [self decrementTimer].
  _clockTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(decrementTimer) userInfo:nil repeats:YES];
  
  _secondsLeft = 10;
  _score = 0;
  
  [_moleButton setHidden:NO];
  
  [self updateScoreLabel:_score];
  [self updateTimerLabel:_secondsLeft];
}

- (void)updateTimerLabel:(int)secondsLeft
{
  NSString *timeLeftText = [NSString stringWithFormat:@"Time left: %d", secondsLeft];
  [_timeLabel setText:timeLeftText];
}

- (void)updateScoreLabel:(int)score
{
  NSString *newScoreString = [NSString stringWithFormat:@"Score: %d", score];
  [_scoreLabel setText:newScoreString];
}

- (IBAction)resetTapped:(id)sender
{
  [self initializeGameState];
}

@end








