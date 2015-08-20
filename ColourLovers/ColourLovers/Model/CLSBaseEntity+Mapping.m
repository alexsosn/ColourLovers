//
//
//  ColourLovers
//
//  Created by Sosnovshchenko Alexander on 2/11/15.
//  Copyright (c) 2015 Sosnovshchenko Alexander. All rights reserved.
//

#import "CLSBaseEntity+Mapping.h"
#import "NSDate+Format.h"

@implementation CLSBaseEntity (Mapping)

- (void)populateWithDictionary:(NSDictionary *)dictionary {
    self.apiUrl = dictionary[@"apiUrl"];
    self.badge = dictionary[@"badge"];
    self.badgeUrl = dictionary[@"badgeUrl"];
    self.entityDescription = dictionary[@"entityDescription"];
    self.entityID = dictionary[@"entityID"];
    self.dateCreated = [NSDate dateWithAPIformattedString:dictionary[@"dateCreated"]];
    self.imageUrl = dictionary[@"imageUrl"];
    self.numComments = dictionary[@"numComments"];
    self.numHearts = dictionary[@"numHearts"];
    self.numViews = dictionary[@"numViews"];
    self.numVotes = dictionary[@"numVotes"];
    self.rank = dictionary[@"rank"];
    self.title = dictionary[@"title"];
    self.url = dictionary[@"url"];
}

@end