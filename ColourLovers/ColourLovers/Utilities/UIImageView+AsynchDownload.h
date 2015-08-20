//
//  UIImageView+AsynchDownload.h
//  ColourLovers
//
//  Created by Sosnovshchenko Alexander on 2/13/15.
//  Copyright (c) 2015 Sosnovshchenko Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImageView (AsynchDownload)

- (void)setImageWithUrl:(NSURL *)url andPlaceholder:(UIImage *)placeholder;
- (void)setUrlString:(NSString *)urlString;
- (NSString *)urlString;

@end

