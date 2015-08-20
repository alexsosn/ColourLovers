//
//  CLSUserInfoTableViewCell.m
//  ColourLovers
//
//  Created by Sosnovshchenko Alexander on 2/18/15.
//  Copyright (c) 2015 Sosnovshchenko Alexander. All rights reserved.
//

#import "CLSUserInfoTableViewCell.h"

@implementation CLSUserInfoTableViewCell

-(void)prepareForReuse {
    [super prepareForReuse];
    self.iconImage.image = nil;
}

-(void)layoutSubviews {
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    self.iconImage.backgroundColor = color;
}

@end
