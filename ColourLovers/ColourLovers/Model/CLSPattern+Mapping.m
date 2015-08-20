//
//
//  ColourLovers
//
//  Created by Sosnovshchenko Alexander on 2/11/15.
//  Copyright (c) 2015 Sosnovshchenko Alexander. All rights reserved.
//

#import "CLSPattern+Mapping.h"
#import "CLSBaseEntity+Mapping.h"

@implementation CLSPattern (Mapping)

- (void)populateWithDictionary:(NSDictionary *)dictionary {
    [super populateWithDictionary:dictionary];
    self.template = dictionary[@"template"];
    self.colors = dictionary[@"colors"];
    self.type = @"Patterns";
}

@end