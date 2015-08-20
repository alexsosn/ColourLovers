//
//  NSDate+Format.m
//  ColourLovers
//
//  Created by Sosnovshchenko Alexander on 2/13/15.
//  Copyright (c) 2015 Sosnovshchenko Alexander. All rights reserved.
//

#import "NSDate+Format.h"

@implementation NSDate (Format)
+ (NSDate *)dateWithAPIformattedString:(NSString *)string {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateFromString = [NSDate new];
    dateFromString = [dateFormatter dateFromString:string];
    return dateFromString;
}
@end
