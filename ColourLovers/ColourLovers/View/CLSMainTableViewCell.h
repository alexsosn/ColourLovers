//
//  MainTableViewCell.h
//  ColourLovers
//
//  Created by Sosnovshchenko Alexander on 2/9/15.
//  Copyright (c) 2015 Sosnovshchenko Alexander. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLSMainTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *entitiesNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastActiveLabel;
+ (CGFloat)height;

@end
