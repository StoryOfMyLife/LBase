//
//  UINavigationController+Rotation.m
//  LBase
//
//  Created by 刘廷勇 on 15/7/1.
//  Copyright (c) 2015年 liuty. All rights reserved.
//

#import "UINavigationController+Rotation.h"

@implementation UINavigationController (Rotation)

- (BOOL)shouldAutorotate
{
    return [self.topViewController shouldAutorotate];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return [self.topViewController supportedInterfaceOrientations];
}

@end
