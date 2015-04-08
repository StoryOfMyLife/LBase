//
//  LTableViewController.m
//  LBase
//
//  Created by 刘廷勇 on 15/4/7.
//  Copyright (c) 2015年 liuty. All rights reserved.
//

#import "LTableViewController.h"
#import "LTableViewCell.h"
#import "LTableViewCellItem.h"

@implementation LTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[[self tableViewClass] alloc] initWithFrame:CGRectZero style:[self tableViewStyle]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (Class)tableViewClass
{
    return [UITableView class];
}

- (UITableViewStyle)tableViewStyle
{
    return UITableViewStylePlain;
}

- (void)setItems:(NSArray *)items
{
    _items = items;
    
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark Table View Delegate and Datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LTableViewCellItem *item = [self tableView:tableView itemAtIndexPath:indexPath];
    LTableViewCell *cell = [[item cellClass] dequeueCellForTableView:tableView];
    cell.tableView = tableView;
    cell.cellItem = item;
    item.cell = cell;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LTableViewCellItem *item = [self tableView:tableView itemAtIndexPath:indexPath];
    return [item heightForTableView:tableView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert([NSThread isMainThread], @"非主线程");
    
    LTableViewCellItem *item = [self tableView:tableView itemAtIndexPath:indexPath];
    
    [self tableView:tableView didSelectItem:item atIndexPath:indexPath];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items[section] count];
}

#pragma mark -
#pragma mark LTableViewDelegate

//When override, must call super
- (void)tableView:(UITableView *)tableView didSelectItem:(LTableViewCellItem *)item atIndexPath:(NSIndexPath *)indexPath
{
    if (item.actionBlock) {
        item.actionBlock(self.tableView, indexPath);
    }
}

- (id)tableView:(UITableView *)tableView itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.items[indexPath.section][indexPath.row];
}

@end
