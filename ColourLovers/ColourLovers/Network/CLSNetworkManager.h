//
//  NetworkManager.h
//  ColourLovers
//
//  Created by Sosnovshchenko Alexander on 2/9/15.
//  Copyright (c) 2015 Sosnovshchenko Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLSNetworkManager : NSObject

+ (void)getLoversNumber:(NSNumber *)number
              andOffset:(NSNumber *)offset
  withCompletionHandler:(void (^)(NSArray *resultArray, NSError *error)) completionHandler;

+ (void)getColorsForLover:(NSString *)loverName
                   number:(NSNumber *)number
                andOffset:(NSNumber *)offset
    withCompletionHandler:(void (^)(NSArray *resultArray, NSError *error)) completionHandler;

+ (void)getPalettesForLover:(NSString *)loverName
                     number:(NSNumber *)number
                  andOffset:(NSNumber *)offset
      withCompletionHandler:(void (^)(NSArray *resultArray, NSError *error)) completionHandler;

+ (void)getPatternsForLover:(NSString *)loverName
                     number:(NSNumber *)number
                  andOffset:(NSNumber *)offset
      withCompletionHandler:(void (^)(NSArray *resultArray, NSError *error)) completionHandler;

@end

