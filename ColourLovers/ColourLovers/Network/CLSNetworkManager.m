//
//  NetworkManager.m
//  ColourLovers
//
//  Created by Sosnovshchenko Alexander on 2/9/15.
//  Copyright (c) 2015 Sosnovshchenko Alexander. All rights reserved.
//

#import "CLSNetworkManager.h"
#import <UIKit/UIKit.h>

@interface NSData (JSON)

- (NSArray *)arrayWithError:(NSError **)error;
@end

@implementation NSData (JSON)

- (NSArray *)arrayWithError:(NSError **)error {
    NSArray *array = [NSJSONSerialization JSONObjectWithData:self
                                                     options:0
                                                       error:error];
    return array;
}


@end

@interface CLSNetworkManager ()

@end

@implementation CLSNetworkManager

+ (NSString *)basePath {
    return @"http://www.colourlovers.com/api/";
}

+ (void)sendRequestWithPath:(NSString *)path
             withParameters:(NSDictionary *)parameters
      withCompletionHandler:(void (^)(NSData *data,
                                      NSURLResponse *response,
                                      NSError *error))completionHandler {
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *urlString = [NSString stringWithFormat:@"%@%@?format=json", self.basePath, path];
    
    for (id parameter in parameters.allKeys) {
        NSString *parameterString = [NSString stringWithFormat:@"&%@=%@", parameter,
                                     parameters[parameter]];
        urlString = [urlString stringByAppendingString:parameterString];
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:completionHandler];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [task resume];
    });
}

+ (void)getLoversNumber:(NSNumber *)number
              andOffset:(NSNumber *)offset
  withCompletionHandler:(void (^)(NSArray *resultArray,
                                  NSError *error)) completionHandler {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [self sendRequestWithPath:@"lovers"
               withParameters:@{@"numResults":number, @"resultOffset":offset}
        withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            
            NSError *jsonParsingError = nil;
            if (completionHandler) {
                completionHandler([data arrayWithError:&jsonParsingError], error?:jsonParsingError);
            }
        }];
}

+ (void)getColorsForLover:(NSString *)loverName
                   number:(NSNumber *)number
                andOffset:(NSNumber *)offset
    withCompletionHandler:(void (^)(NSArray *resultArray,
                                    NSError *error)) completionHandler {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [self sendRequestWithPath:@"colors"
               withParameters:@{@"lover":loverName, @"numResults":number, @"resultOffset":offset}
        withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

            NSError *jsonParsingError = nil;
            if (completionHandler) {
                completionHandler([data arrayWithError:&jsonParsingError], error?:jsonParsingError);
            }
        }];
}

+ (void)getPalettesForLover:(NSString *)loverName
                     number:(NSNumber *)number
                  andOffset:(NSNumber *)offset
      withCompletionHandler:(void (^)(NSArray *resultArray,
                                      NSError *error)) completionHandler {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    [self sendRequestWithPath:@"palettes"
               withParameters:@{@"lover":loverName, @"numResults":number, @"resultOffset":offset}
        withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

            NSError *jsonParsingError = nil;
            if (completionHandler) {
                completionHandler([data arrayWithError:&jsonParsingError], error?:jsonParsingError);
            }
        }];
}

+ (void)getPatternsForLover:(NSString *)loverName
                     number:(NSNumber *)number
                  andOffset:(NSNumber *)offset
      withCompletionHandler:(void (^)(NSArray *resultArray,
                                      NSError *error)) completionHandler {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    [self sendRequestWithPath:@"patterns"
               withParameters:@{@"lover":loverName, @"numResults":number, @"resultOffset":offset}
        withCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

            NSError *jsonParsingError = nil;
            if (completionHandler) {
                completionHandler([data arrayWithError:&jsonParsingError], error?:jsonParsingError);
            }
        }];
}


@end
