//
//  ff.h
//  ColourLovers
//
//  Created by Sosnovshchenko Alexander on 2/11/15.
//  Copyright (c) 2015 Sosnovshchenko Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLSColor.h"

@interface CLSColor (Mapping)

- (void)populateWithDictionary:(NSDictionary *)dictionary;

@end
