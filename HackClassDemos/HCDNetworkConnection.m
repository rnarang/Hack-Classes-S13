//
//  HCDNetworkConnection.m
//  HackClassDemos
//
//  Created by Rishi on 4/8/13.
//  Copyright (c) 2013 RishiNarang. All rights reserved.
//

#import "HCDNetworkConnection.h"

@interface HCDNetworkConnection ()

@property (nonatomic, assign) BOOL convertResponseToJSON;
@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, strong) NSURLRequest *request;
@property (nonatomic, strong) NSURLResponse *response;
@property (nonatomic, strong) hcd_request_completion_block_t finishedBlock;

// For keeping track of network activity to show the network activity indicator
+ (void)startingRequest;
+ (void)finishedRequest;

@end

@implementation HCDNetworkConnection

@synthesize convertResponseToJSON = _convertResponseToJSON;

#pragma mark -
#pragma mark Public Methods

- (id)initWithRequest:(NSURLRequest *)request convertResponseToJSON:(BOOL)json
{
    self = [super init];
    if (self) {
        self.convertResponseToJSON = json;
        self.request = request;
    }
    return self;
}

- (void)begin:(hcd_request_completion_block_t)finishedBlock
{
    // Set the finished block property so that we can call it when the connection is finished
    self.finishedBlock = finishedBlock;
    
    // Initialize the mutable data property so that we can keep track of the data we receive
    self.data = [[NSMutableData alloc] init];
    
    // Begin a connection with the stored request, and since we want to get the data, set self
    // as the delegate
    [NSURLConnection connectionWithRequest:_request delegate:self];
    
    [HCDNetworkConnection startingRequest]; // network activity indicator use
}

#pragma mark -
#pragma mark NSURLConnectionDownloadDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // Once we receive an HTTP response, we want to save it so we can give it to the completion handler
    self.response = response;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Whenever we receive a chunk of data, append it to our stored data
    [_data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [HCDNetworkConnection finishedRequest]; // network activity indicator use
    
    NSError *error = nil;
    
    id data;
    if (_convertResponseToJSON) {
        // If the original caller wanted a JSON response, convert the data to a JSON object
        data = [NSJSONSerialization JSONObjectWithData:_data options:0 error:&error];
    } else {
        // Otherwise, convert it to a string.
        data = [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
    }
    
    // We don't need the data anymore
    self.data = nil;
    
    // If there was an error, set the data we're passing to the completion handler to nil
    // (it could be anyway).
    if (error) {
        data = nil;
    }
    _finishedBlock(data, _response, error);
    self.finishedBlock = nil;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [HCDNetworkConnection finishedRequest];
    
    self.data = nil;
    _finishedBlock(nil, nil, error);
    self.finishedBlock = nil;
}

#pragma mark -
#pragma mark Network Activity Inidicator

static int liveRequestCount = 0;

+ (void)startingRequest
{
    // Increment the number of live network requests
    liveRequestCount++;
    if (liveRequestCount == 1) {
        // The network activity indicator wasn't showing before, so show it now.
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }
}

+ (void)finishedRequest
{
    // Decrement the number of live network requests
    liveRequestCount--;
    if (liveRequestCount == 0) {
        // There is no network activity (at least using this class), so hide the network activity indicator
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
}


@end
