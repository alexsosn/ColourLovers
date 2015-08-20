//
//  DataFlowManager.h
//  ColourLovers
//
//  Created by Sosnovshchenko Alexander on 2/13/15.
//  Copyright (c) 2015 Sosnovshchenko Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSManagedObjectContext;

@interface CLSDataFlowManager : NSDate

+ (instancetype)sharedManager;
- (void)updateLoversWithOffset:(NSNumber *)offset;
- (void)updateDataForUserName:(NSString *)userName withOffset:(NSNumber *)offset;

@end
