//
//  CLSDataBaseManager.h
//  ColourLovers
//
//  Created by Sosnovshchenko Alexander on 2/18/15.
//  Copyright (c) 2015 Sosnovshchenko Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CLSDataBaseManager : NSObject

@property (strong, nonatomic, readonly) NSManagedObjectContext *mainContext;

+ (instancetype)sharedManager;
- (NSManagedObjectContext *)createTemporaryContext;
- (void)saveContext;

@end
