//
//
//  ColourLovers
//
//  Created by Sosnovshchenko Alexander on 2/11/15.
//  Copyright (c) 2015 Sosnovshchenko Alexander. All rights reserved.
//

#import "CLSLover+Mapping.h"
#import "NSDate+Format.h"

@implementation CLSLover (Mapping)

- (void)populateWithDictionary:(NSDictionary *)dictionary {
    self.userName = dictionary[@"userName"];
    self.dateRegistered = [NSDate dateWithAPIformattedString:dictionary[@"dateRegistered"]];
    self.dateLastActive = [NSDate dateWithAPIformattedString:dictionary[@"dateLastActive"]];
    self.rating = dictionary[@"rating"];
    self.location = dictionary[@"location"];
    self.numColors = dictionary[@"numColors"];
    self.numPalettes = dictionary[@"numPalettes"];
    self.numPatterns = dictionary[@"numPatterns"];
    self.numCommentsMade = dictionary[@"numCommentsMade"];
    self.numLovers = dictionary[@"numLovers"];
    self.numCommentsOnProfile = dictionary[@"numCommentsOnProfile"];
    self.comments = dictionary[@"comments"];
    self.url = dictionary[@"url"];
    self.apiUrl = dictionary[@"apiUrl"];
//    self.patterns = dictionary[@"patterns"];
//    self.palettes = dictionary[@"palettes"];
//    self.colors = dictionary[@"colors"];
}

@end