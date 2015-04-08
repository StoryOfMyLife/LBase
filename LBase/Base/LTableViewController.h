//
//  LTableViewController.h
//  LBase
//
//  Created by 刘廷勇 on 15/4/7.
//  Copyright (c) 2015年 liuty. All rights reserved.
//

#import "LViewController.h"
#import "LTableViewDelegate.h"

@interface LTableViewController : LViewController <UITableViewDelegate, UITableViewDataSource, LTableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *items;

@end
