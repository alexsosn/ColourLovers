//
//  CLSBaseEntity.h
//  ColourLovers
//
//  Created by Sosnovshchenko Alexander on 2/19/15.
//  Copyright (c) 2015 Sosnovshchenko Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CLSLover;

@interface CLSBaseEntity : NSManagedObject

@property (nonatomic, retain) NSString * apiUrl;
@property (nonatomic, retain) NSData * badge;
@property (nonatomic, retain) NSString * badgeUrl;
@property (nonatomic, retain) NSDate * dateCreated;
@property (nonatomic, retain) NSString * entityDescription;
@property (nonatomic, retain) NSNumber * entityID;
@property (nonatomic, retain) NSString * imageUrl;
@property (nonatomic, retain) NSNumber * numComments;
@property (nonatomic, retain) NSNumber * numHearts;
@property (nonatomic, retain) NSNumber * numViews;
@property (nonatomic, retain) NSNumber * numVotes;
@property (nonatomic, retain) NSNumber * rank;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) CLSLover *lover;

@end
