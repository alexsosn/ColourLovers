//
//
//  ColourLovers
//
//  Created by Sosnovshchenko Alexander on 2/11/15.
//  Copyright (c) 2015 Sosnovshchenko Alexander. All rights reserved.
//

#import "CLSPalette+Mapping.h"
#import "CLSBaseEntity+Mapping.h"

@implementation CLSPalette (Mapping)

- (void)populateWithDictionary:(NSDictionary *)dictionary {
    [super populateWithDictionary:dictionary];
    self.colors = dictionary[@"colors"];
    self.type = @"Palettes";
}

@end