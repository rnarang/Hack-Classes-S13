//
//  HCDScore.h
//  HackClassDemos
//
//  Created by Rishi on 4/22/13.
//  Copyright (c) 2013 RishiNarang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface HCDScore : NSManagedObject

@property (nonatomic, retain) NSNumber * scoreValue;
@property (nonatomic, retain) NSString * name;

@end
