//
//  CLSPattern.h
//  ColourLovers
//
//  Created by Sosnovshchenko Alexander on 2/19/15.
//  Copyright (c) 2015 Sosnovshchenko Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CLSBaseEntity.h"


@interface CLSPattern : CLSBaseEntity

@property (nonatomic, retain) id colors;
@property (nonatomic, retain) id template;

@end
