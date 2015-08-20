//
//  CLSFetchedResultsViewController.h
//  ColourLovers
//
//  Created by Sosnovshchenko Alexander on 2/18/15.
//  Copyright (c) 2015 Sosnovshchenko Alexander. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface CLSFetchedResultsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>

@property (nonatomic, readonly) NSFetchedResultsController *fetchedResultsController;

- (NSFetchRequest *)fetchRequest;
- (NSString *)sectionNameKeyPath;

@end
