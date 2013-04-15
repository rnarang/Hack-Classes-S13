//
//  HCDHighScoresViewController.m
//  HackClassDemos
//
//  Created by Rishi on 4/1/13.
//  Copyright (c) 2013 RishiNarang. All rights reserved.
//

#import "HCDHighScoresViewController.h"
#import "HCDViewController.h"
#import "HCDNetworkConnection.h"

@interface HCDHighScoresViewController ()

@property (nonatomic, strong) NSArray *scoreNamePairs;

// Fetch new scores data from the server
- (void)fetchData;

// Simple helper method to return a number from what is either an NSNumber or NSString
// This is necessary since, depending on how the server sends the data, the JSON dictionary
// that we get might give us a string (like "24") instead of a number.
+ (NSNumber *)forceNumberFromObject:(id)stringOrNumber;

@end

@implementation HCDHighScoresViewController

@synthesize scoreNamePairs = _scoreNamePairs;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

  [super viewDidLoad];
  
  // iOS 6 added a native pull-to-refresh element for tables
#warning Add code here
  
  // Fetch data from the server
  [self fetchData];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchData
{
  // Fetch new data from the server, put it in self.scoreNamePairs, and reload the table
#warning Add code here
}

+ (NSNumber *)forceNumberFromObject:(id)stringOrNumber
{
  if ([stringOrNumber isKindOfClass:[NSNumber class]]) {
    return stringOrNumber;
  } else if ([stringOrNumber isKindOfClass:[NSString class]]) {
    return [[[NSNumberFormatter alloc] init] numberFromString:stringOrNumber];
  }
  
  return nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [_scoreNamePairs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
  }
    
  // The scores are in the array as NSNumbers, so we need to get the intValue from it.
  NSDictionary *scoreNamePair = [_scoreNamePairs objectAtIndex:indexPath.row];
  NSString *name = [scoreNamePair objectForKey:@"name"];
  NSNumber *score = [HCDHighScoresViewController forceNumberFromObject:[scoreNamePair objectForKey:@"score"]];
  
  // Set the text label of the cell
  NSString *cellText = [NSString stringWithFormat:@"%d", [score intValue]];
  [cell.textLabel setText:cellText];
  [cell.detailTextLabel setText:name];
  
  // Return the cell
  return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
