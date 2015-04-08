//
//  LTableViewCellItem.h
//  LBase
//
//  Created by 刘廷勇 on 15/4/7.
//  Copyright (c) 2015年 liuty. All rights reserved.
//

#import "JSONModel.h"

@class LTableViewCell;

typedef void(^ActionBlock)(UITableView *tableView, NSIndexPath *indexPath);

@interface LTableViewCellItem : JSONModel

@property (nonatomic, copy) ActionBlock actionBlock;

@property (nonatomic, weak) LTableViewCell<Ignore> *cell;

- (Class)cellClass;

- (void)applyActionBlock:(ActionBlock)actionBlock;

- (CGFloat)heightForTableView:(UITableView *)tableView;

@end
