//
//  CLSDetailsViewController.h
//  ColourLovers
//
//  Created by Sosnovshchenko Alexander on 2/18/15.
//  Copyright (c) 2015 Sosnovshchenko Alexander. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLSDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextView *textField;
@property (nonatomic, strong) NSDictionary *data;
@end
