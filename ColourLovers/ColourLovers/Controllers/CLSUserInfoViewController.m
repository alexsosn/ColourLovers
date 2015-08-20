//
//  CLSUserInfoViewController.m
//  ColourLovers
//
//  Created by Sosnovshchenko Alexander on 2/18/15.
//  Copyright (c) 2015 Sosnovshchenko Alexander. All rights reserved.
//

#import "CLSUserInfoViewController.h"
#import "UIImageView+AsynchDownload.h"
#import "CLSUserInfoTableViewCell.h"
#import "CLSBaseEntity.h"
#import "UIImageView+AsynchDownload.h"
#import "CLSDataFlowManager.h"

static NSString * const kUserInfoTableViewCell = @"CLSUserInfoTableViewCell";

@interface CLSUserInfoViewController ()<UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation CLSUserInfoViewController

- (NSFetchRequest *)fetchRequest {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([CLSBaseEntity class])];
    request.predicate = [NSPredicate predicateWithFormat:@"lover.userName == %@", self.userName];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"rank" ascending:NO]];
    return request;
}

- (NSString *)sectionNameKeyPath {
    return @"type";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CLSUserInfoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kUserInfoTableViewCell];
    CLSBaseEntity *model = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.nameLabel.text = model.title;
    [cell.iconImage setImageWithUrl:[NSURL URLWithString:model.imageUrl] andPlaceholder:nil];
    [cell.iconImage setUrlString:model.imageUrl];
    return cell;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.userName;
    self.tableView.estimatedRowHeight = 44.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(self.fetchedResultsController.sections.count == 0) return nil;
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController.sections objectAtIndex:section];
    return sectionInfo.name;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController.sections objectAtIndex:path.section];
    CLSBaseEntity *model = [sectionInfo objects][path.row];
    
    NSArray *keys = [[[model entity] attributesByName] allKeys];
    NSDictionary *dict = [model dictionaryWithValuesForKeys:keys];
    [segue.destinationViewController setValue:dict forKey:@"data"];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat actualPosition = scrollView.contentOffset.y;
    CGFloat contentHeight = scrollView.contentSize.height - scrollView.frame.size.height;
    if (actualPosition >= contentHeight) {
        [[CLSDataFlowManager sharedManager] updateDataForUserName:self.userName
                                                       withOffset:@(self.fetchedResultsController.fetchedObjects.count)];
    }
}

-(void)dealloc {
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}

@end
