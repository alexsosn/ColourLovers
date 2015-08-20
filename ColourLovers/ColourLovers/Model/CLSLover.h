//
//  CLSLover.h
//  ColourLovers
//
//  Created by Sosnovshchenko Alexander on 2/19/15.
//  Copyright (c) 2015 Sosnovshchenko Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CLSBaseEntity;

@interface CLSLover : NSManagedObject

@property (nonatomic, retain) NSString * apiUrl;
@property (nonatomic, retain) id comments;
@property (nonatomic, retain) NSDate * dateLastActive;
@property (nonatomic, retain) NSDate * dateRegistered;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSNumber * numColors;
@property (nonatomic, retain) NSNumber * numCommentsMade;
@property (nonatomic, retain) NSNumber * numCommentsOnProfile;
@property (nonatomic, retain) NSNumber * numLovers;
@property (nonatomic, retain) NSNumber * numPalettes;
@property (nonatomic, retain) NSNumber * numPatterns;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSSet *details;
@end

@interface CLSLover (CoreDataGeneratedAccessors)

- (void)addDetailsObject:(CLSBaseEntity *)value;
- (void)removeDetailsObject:(CLSBaseEntity *)value;
- (void)addDetails:(NSSet *)values;
- (void)removeDetails:(NSSet *)values;

@end
