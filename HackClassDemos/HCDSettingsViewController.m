//
//  HCDSettingsViewController.m
//  HackClassDemos
//
//  Created by Rishi on 4/8/13.
//  Copyright (c) 2013 RishiNarang. All rights reserved.
//

#import "HCDSettingsViewController.h"

NSString *const kHCDNameKey = @"kHCDNameKey";

@interface HCDSettingsViewController () <UITextFieldDelegate>

@end

@implementation HCDSettingsViewController

@synthesize nameTextField = _nameTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
  NSString *name = [standardDefaults objectForKey:kHCDNameKey];
  [_nameTextField setText:name];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  
  NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
  [standardDefaults setObject:_nameTextField.text forKey:kHCDNameKey];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [textField resignFirstResponder];
  return YES;
}

@end
