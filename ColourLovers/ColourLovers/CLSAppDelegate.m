//
//  AppDelegate.m
//  ColourLovers
//
//  Created by Sosnovshchenko Alexander on 2/9/15.
//  Copyright (c) 2015 Sosnovshchenko Alexander. All rights reserved.
//

#import "CLSAppDelegate.h"
#import "CLSDataBaseManager.h"

@interface CLSAppDelegate ()

@end

@implementation CLSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[CLSDataBaseManager sharedManager] saveContext];
}

@end
