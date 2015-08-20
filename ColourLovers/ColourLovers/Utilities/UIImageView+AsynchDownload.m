//
//  UIImageView+AsynchDownload.m
//  ColourLovers
//
//  Created by Sosnovshchenko Alexander on 2/13/15.
//  Copyright (c) 2015 Sosnovshchenko Alexander. All rights reserved.
//

#import "UIImageView+AsynchDownload.h"
#import <objc/runtime.h>

static NSCache * kCache = nil;
NSString *const kURLKey = @"kURLKey";

@implementation UIImageView (AsynchDownload)

- (void)setImageWithUrl:(NSURL *)url andPlaceholder:(UIImage *)placeholder {
    
    if (!kCache) {
        kCache =  [NSCache new];
    }
    UIImage *image = [kCache objectForKey:url.absoluteString];
    if (image) {
        self.image = image;
        return;
    } else if (placeholder) {
        self.image = placeholder;
    }
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    __block __weak typeof(self) weakSelf = self;
    dispatch_queue_t callerQueue = dispatch_get_main_queue();
    dispatch_queue_t downloadQueue = dispatch_queue_create("com.myapp.processimagequeue", NULL);
    dispatch_async(downloadQueue, ^{
        NSData * imageData = [NSData dataWithContentsOfURL:url];
        
        dispatch_async(callerQueue, ^{
            UIImage *image = [UIImage imageWithData:imageData];
            if ([weakSelf.urlString isEqualToString:url.absoluteString]) {
                weakSelf.image = image;
                [self setNeedsLayout];
            }
            [kCache setObject:image forKey:url.absoluteString];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        });
    });
}

- (void)setUrlString:(NSString *)urlString {
    objc_setAssociatedObject(self, (__bridge const void *)(kURLKey), urlString, OBJC_ASSOCIATION_COPY);
}

- (NSString *)urlString {
    return objc_getAssociatedObject(self, (__bridge const void *)(kURLKey));
}

@end
