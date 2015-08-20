//
//
//  ColourLovers
//
//  Created by Sosnovshchenko Alexander on 2/11/15.
//  Copyright (c) 2015 Sosnovshchenko Alexander. All rights reserved.
//

#import "CLSColor+Mapping.h"
#import "CLSBaseEntity+Mapping.h"

@implementation CLSColor (Mapping)

- (void)populateWithDictionary:(NSDictionary *)dictionary {
    [super populateWithDictionary:dictionary];
    self.hex = dictionary[@"hex"];
    self.rgb = dictionary[@"rgb"];
    self.hsv = dictionary[@"hsv"];
    self.type = @"Colors";
}

@end