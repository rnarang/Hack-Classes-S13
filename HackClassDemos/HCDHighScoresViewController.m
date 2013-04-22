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
#import "HCDAppDelegate.h"
#import "HCDScore.h"

@interface HCDHighScoresViewController ()

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

// Fetch new scores data from the server
- (void)fetchData;

// Simple helper method to return a number from what is either an NSNumber or NSString
// This is necessary since, depending on how the server sends the data, the JSON dictionary
// that we get might give us a string (like "24") instead of a number.
+ (NSNumber *)forceNumberFromObject:(id)stringOrNumber;

@end

@implementation HCDHighScoresViewController

@synthesize fetchedResultsController = _fetchedResultsController;

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
  UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
  [refreshControl addTarget:self action:@selector(fetchData) forControlEvents:UIControlEventValueChanged];
  self.refreshControl = refreshControl;
  
  /* Use a fetched results controller to display the list of scores */
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
  NSString *urlString = @"http://hackios.herokuapp.com/get_scores";
  NSURL *url = [NSURL URLWithString:urlString];
  NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
  
  HCDNetworkConnection *networkConnection = [[HCDNetworkConnection alloc] initWithRequest:urlRequest convertResponseToJSON:YES];
  
  // Will be called by the networkConnection instance when the connection finishes loading
  hcd_request_completion_block_t finishedBlock =
  ^(id data, NSURLResponse *response, NSError *error) {
    if (error) {
      [self.refreshControl endRefreshing];
      return;
    }
    
    assert([data isKindOfClass:[NSArray class]]);
    
    HCDAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    // Delete all the scores currently in core data in order to update it with the new scores.
    // This is a simple brute-force way of doing it, but its sufficient for our goals.
    [HCDHighScoresViewController deleteAllScores:context];
    
    for (NSDictionary *scoreNamePair in data) {
      HCDScore *score = [NSEntityDescription insertNewObjectForEntityForName:@"HCDScore"
                                                      inManagedObjectContext:context];
      score.name = [scoreNamePair objectForKey:@"name"];
      score.scoreValue = [HCDHighScoresViewController forceNumberFromObject:[scoreNamePair objectForKey:@"score"]];
    }
    
    // We really should do some error checking here, but let's just trust that it works.
    // (why we're passing in NULL instead of some error object pointer).
    [context save:NULL]; // Save the updated changes to update on disk
    [self.fetchedResultsController performFetch:NULL]; // Have the fetched results controller update
    [self.tableView reloadData]; // Make the table reload data by calling the delegate/data source methods again.
    
    [self.refreshControl endRefreshing];
  };
  
  [networkConnection begin:finishedBlock];
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

+ (void)deleteAllScores:(NSManagedObjectContext *)context
{
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
  NSEntityDescription *entity = [NSEntityDescription entityForName:@"HCDScore" inManagedObjectContext:context];
  [fetchRequest setEntity:entity];
  
  NSError *error = nil;
  NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
  if (fetchedObjects == nil) {
    NSLog(@"Core data fetch failure: %@", error);
  }
  
  for (HCDScore *score in fetchedObjects) {
    [context deleteObject:score];
  }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Add code here
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Add code here
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
  
  // Cells are reused once they go off the screen. In other words, if you have a friends table
  // with 1000 friends, but you can only see about 10 friends on the screen at once, chances are
  // there are 11 or 12 cells allocated in memory.
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
  }
  
  // Customize the cell
#warning Add code here
  
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
