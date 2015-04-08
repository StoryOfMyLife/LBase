//
//  TestCellItem.m
//  LBase
//
//  Created by 刘廷勇 on 15/4/7.
//  Copyright (c) 2015年 liuty. All rights reserved.
//

#import "TestCellItem.h"

@implementation TestCellItem

- (Class)cellClass
{
    return [TestCell class];
}

- (CGFloat)heightForTableView:(UITableView *)tableView
{
    return 100;
}

@end

@implementation TestCell
@synthesize cellItem = _cellItem;

- (void)setCellItem:(TestCellItem *)cellItem
{
    [super setCellItem:cellItem];
    self.textLabel.text = cellItem.title;
    
    [self setNeedsDisplay];
}

@end