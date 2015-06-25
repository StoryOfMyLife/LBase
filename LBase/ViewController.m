//
//  ViewController.m
//  LBase
//
//  Created by 刘廷勇 on 15/4/7.
//  Copyright (c) 2015年 liuty. All rights reserved.
//

#import "ViewController.h"
#import "TestCellItem.h"
#import "ReactiveCocoa.h"
#import <objc/runtime.h>

@interface ViewA : UIView

@end

@implementation ViewA

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"hit A");
    NSLog(@"A point (%@)", NSStringFromCGPoint(point));
    UIView *view = [super hitTest:point withEvent:event];
    if (view == self) {
//        NSLog(@"self A");
////        [UIView animateWithDuration:.3 animations:^{
////            self.alpha = 0;
////        } completion:^(BOOL finished) {
//            [self removeFromSuperview];
////        }];
        
//        return nil;
    }
    return view;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inside = CGRectContainsPoint(self.bounds, point);

    return inside;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"A touch");
    [super touchesBegan:touches withEvent:event];
}

@end

@interface ViewB : UIButton

@end

@implementation ViewB

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
//    NSLog(@"hit B");
//    NSLog(@"B point (%@)", NSStringFromCGPoint(point));
    UIView *view = [super hitTest:point withEvent:event];
    
    return view;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inside = CGRectContainsPoint(self.bounds, point);
//    NSLog(@"B point (%@) inside : %@", NSStringFromCGPoint(point), inside?@"YES":@"NO");
    
    return inside;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"B touch");
    self.highlighted = YES;
//    [super touchesBegan:touches withEvent:event];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.superview];
    BOOL inside = [self pointInside:point withEvent:event];
    if (!inside) {
        self.highlighted = NO;
//        [self touchesCancelled:touches withEvent:event];
    } else {
        self.highlighted = YES;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.highlighted = NO;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.highlighted) {
        [self sendActionsForControlEvents:[self allControlEvents]];
    }
    self.highlighted = NO;
}


- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
//    NSLog(@"B highlighted");
}

@end

@interface UIView(HitTest)
@end

@implementation UIView(HitTest)

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if ([self pointInside:point withEvent:event]) {
        for (NSInteger index = self.subviews.count - 1; index >= 0; index--) {
            UIView *subview = self.subviews[index];
            CGPoint pointInSubview = [self convertPoint:point toView:subview];
            UIView *hitView = [subview hitTest:pointInSubview withEvent:event];
            if (hitView) {
                return hitView;
            }
        }
        return self;
    }
    return nil;
}

@end

@interface MYScrollView : UIScrollView

@end

@implementation MYScrollView

//- (BOOL)touchesShouldCancelInContentView:(UIView *)view
//{
//    NSLog(@"%@", view);
//    return YES;
//}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"ScrollView point (%@)", NSStringFromCGPoint(point));
    UIView *view = [super hitTest:point withEvent:event];
    if (view == self) {
        return nil;
    }
    return view;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inside = CGRectContainsPoint(self.bounds, point);
    NSLog(@"scrollView point (%@) inside : %@", NSStringFromCGPoint(point), inside?@"YES":@"NO");
    return inside;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [super touchesBegan:touches withEvent:event];
}

@end

@interface ViewController ()

@property (nonatomic) BOOL shouldShow;

@end

@implementation ViewController

//- (void)loadView
//{
//    UIScrollView *scrollView = [[MYScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    [scrollView setContentSize:CGSizeMake(1000, 10000)];
//    [scrollView setBackgroundColor:[UIColor whiteColor]];
////    scrollView.delaysContentTouches = NO;
//    self.view = scrollView;
//}

- (void)viewDidLoad {
    [super viewDidLoad];

//    TestCellItem *item = [[TestCellItem alloc] initWithDictionary:@{@"title" : @"lty"} error:nil];
//    self.items = @[@[item, item], @[item]];
//    
//    [item applyActionBlock:^(UITableView *tableView, NSIndexPath *indexPath) {
//        NSLog(@"cell %ld in section %ld tapped", (long)indexPath.row, (long)indexPath.section);
//    }];
    
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectInset(self.view.bounds, 100, 100)];
    textField.backgroundColor = [UIColor blackColor];
    [self.view addSubview:textField];
    
    RACObserve(textField, backgroundColor);
    
    RAC(textField, backgroundColor) = [[textField.rac_textSignal map:^id(NSString *text) {
        return @(text.length);
    }] map:^id(NSNumber *len) {
        return len.intValue > 3 ? [UIColor redColor] : [UIColor blueColor];
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 100, 100);
    [btn setTitle:@"btttttt" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    
//    btn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//        NSLog(@"button tapped");
//        return [RACSignal empty];
//    }];
    
    [[[RACSignal return:@"1"] delay:1] subscribeNext:^(id x) {
        
    } completed:^{
        
    }];
    
    [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"1"];
            
            [subscriber sendCompleted];
        });
        
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"%s", __PRETTY_FUNCTION__);
            
        }];
    }] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    } completed:^{
        NSLog(@"complete");
    }];
    
    [RACObserve(self, shouldShow) subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    [[RACSignal merge:@[textField.rac_textSignal, RACObserve(btn, enabled)]] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    
//    RAC(self, shouldShow) = [RACSignal combineLatest:@[textField.rac_textSignal, RACObserve(btn, enabled)] reduce:^(NSString *text, NSNumber *enable){
//        NSLog(@"%@, %@", text, enable);
//        return @([text isEqualToString:@"123"] && enable.boolValue);
//    }];
    
}

//- (BOOL)shouldAutorotate
//{
//    return YES;
//}


@end
