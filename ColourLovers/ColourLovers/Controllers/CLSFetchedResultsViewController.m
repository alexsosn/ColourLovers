//
//  CLSFetchedResultsViewController.m
//  ColourLovers
//
//  Created by Sosnovshchenko Alexander on 2/18/15.
//  Copyright (c) 2015 Sosnovshchenko Alexander. All rights reserved.
//

#import "CLSFetchedResultsViewController.h"
#import "CLSDataFlowManager.h"
#import "CLSDataBaseManager.h"

@interface CLSFetchedResultsViewController ()

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation CLSFetchedResultsViewController
- (NSFetchRequest *)fetchRequest {
    return nil;
}

- (NSString *)sectionNameKeyPath {
    return nil;
}

- (NSFetchedResultsController *)fetchedResultsController {
    if (!_fetchedResultsController) {
        
        CLSDataBaseManager *dbManager = [CLSDataBaseManager sharedManager];
        
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:self.fetchRequest
                                                                        managedObjectContext:dbManager.mainContext
                                                                          sectionNameKeyPath:self.sectionNameKeyPath
                                                                                   cacheName:nil];
        _fetchedResultsController.delegate = self;
    }
    return _fetchedResultsController;
    
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type{
    NSIndexSet *sectionSet = [NSIndexSet indexSetWithIndex:sectionIndex];
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:sectionSet withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:sectionSet withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            [self.tableView reloadData];
            break;
            
    }
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeDelete: {
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeUpdate: {
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeMove: {
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSError *error = nil;
    [self.fetchedResultsController performFetch:&error];
    
    if (error) {
        NSLog(@"Unable to perform fetch.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController.sections objectAtIndex:section];
    count = [sectionInfo numberOfObjects];
    
    return count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSUInteger count = self.fetchedResultsController.sections.count;
    return count;
}

@end
