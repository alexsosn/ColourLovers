//
//  ff.h
//  ColourLovers
//
//  Created by Sosnovshchenko Alexander on 2/11/15.
//  Copyright (c) 2015 Sosnovshchenko Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLSPalette.h"

@interface CLSPalette (Mapping)

- (void)populateWithDictionary:(NSDictionary *)dictionary;

@end
