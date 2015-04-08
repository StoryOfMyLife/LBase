//
//  ViewController.m
//  LBase
//
//  Created by 刘廷勇 on 15/4/7.
//  Copyright (c) 2015年 liuty. All rights reserved.
//

#import "ViewController.h"
#import "TestCellItem.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    TestCellItem *item = [[TestCellItem alloc] initWithDictionary:@{@"title" : @"lty"} error:nil];
    self.items = @[@[item, item], @[item]];
    
    [item applyActionBlock:^(UITableView *tableView, NSIndexPath *indexPath) {
        NSLog(@"cell %ld in section %ld tapped", (long)indexPath.row, (long)indexPath.section);
    }];
}

@end
