//
//  CLSColor.h
//  ColourLovers
//
//  Created by Sosnovshchenko Alexander on 2/19/15.
//  Copyright (c) 2015 Sosnovshchenko Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CLSBaseEntity.h"


@interface CLSColor : CLSBaseEntity

@property (nonatomic, retain) NSString * hex;
@property (nonatomic, retain) id hsv;
@property (nonatomic, retain) id rgb;

@end
