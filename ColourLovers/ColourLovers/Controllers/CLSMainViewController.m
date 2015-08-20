//
//  ViewController.m
//  ColourLovers
//
//  Created by Sosnovshchenko Alexander on 2/9/15.
//  Copyright (c) 2015 Sosnovshchenko Alexander. All rights reserved.
//

#import "CLSMainViewController.h"
#import "CLSMainTableViewCell.h"
#import "CLSLover.h"
#import "CLSDataFlowManager.h"

static NSString * const kMainScreenCell = @"MainTableViewCell";

@interface CLSMainViewController () <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation CLSMainViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ColourLovers";
    self.tableView.estimatedRowHeight = [CLSMainTableViewCell height];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (NSFetchRequest *)fetchRequest {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([CLSLover class])];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"rating" ascending:NO]];
    return request;
}

- (NSString *)sectionNameKeyPath {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CLSMainTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kMainScreenCell];
    CLSLover *lover = self.fetchedResultsController.fetchedObjects[indexPath.row];
    cell.textLabel.text = lover.userName;
    cell.ratingLabel.text = lover.rating.stringValue;
    cell.entitiesNumberLabel.text = @(lover.numColors.integerValue +
                                    lover.numPalettes.integerValue +
                                    lover.numPatterns.integerValue).stringValue;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd.MM.yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:lover.dateLastActive];
    cell.lastActiveLabel.text = stringFromDate;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat actualPosition = scrollView.contentOffset.y;
    CGFloat contentHeight = scrollView.contentSize.height - scrollView.frame.size.height;
    if (actualPosition >= contentHeight) {
        [[CLSDataFlowManager sharedManager] updateLoversWithOffset:
         @(self.fetchedResultsController.fetchedObjects.count)];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    CLSLover *lover = self.fetchedResultsController.fetchedObjects[path.row];
    [[CLSDataFlowManager sharedManager] updateDataForUserName:lover.userName withOffset:@0];
    [segue.destinationViewController setValue:lover.userName forKey:@"userName"];
}

-(void)dealloc {
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}

@end
