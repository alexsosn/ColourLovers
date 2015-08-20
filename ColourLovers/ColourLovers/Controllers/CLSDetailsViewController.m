//
//  CLSDetailsViewController.m
//  ColourLovers
//
//  Created by Sosnovshchenko Alexander on 2/18/15.
//  Copyright (c) 2015 Sosnovshchenko Alexander. All rights reserved.
//

#import "CLSDetailsViewController.h"
@interface CLSDetailsViewController ()<UIWebViewDelegate>

@end
@implementation CLSDetailsViewController

-(void)viewDidLoad {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    self.title = self.data[@"title"];
    self.textField.text = self.data.description;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.data[@"url"]]];
    [self.webView loadRequest:request];
    self.webView.scalesPageToFit = YES;
}

#pragma mark - UIWebViewDelegate methods

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

-(void)dealloc {
    self.webView.delegate = nil;
}

@end
