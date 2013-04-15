//
//  HCDNetworkConnection.h
//  HackClassDemos
//
//  Created by Rishi on 4/8/13.
//  Copyright (c) 2013 RishiNarang. All rights reserved.
//

#import <Foundation/Foundation.h>

// When a request completes, the completion handler is given the data, the HTTP response, and
// an error (nil if there was no error).
//
// The "id" declaration indicates that it is any object type (data could be an NSArray,
// NSDictionary, etc.). The caller should know what to expect.
typedef void(^hcd_request_completion_block_t)(id data, NSURLResponse *response, NSError *error);

@interface HCDNetworkConnection : NSObject

/*!
    @method initWithRequest:convertResponseToJSON:
    @abstract Initalizes an HCDNetworkConnection with the given request
    @param request An NSURLRequest with the information needed to send the request
    @param json If YES, the data returned in the completion block will be converted to a JSON object
    @result An initialized HCDNetworkConnection
 */
- (id)initWithRequest:(NSURLRequest *)request convertResponseToJSON:(BOOL)json;

/*!
    @method beginRequest:
    @abstract Begins the network request
    @param finishedBlock A completion block to be called when the request has completed
 */
- (void)begin:(hcd_request_completion_block_t)finishedBlock;

@end
