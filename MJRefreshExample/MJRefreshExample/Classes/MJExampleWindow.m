//
//  MJExampleWindow.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/8/17.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJExampleWindow.h"

@implementation MJExampleWindow

static UIWindow *window_;
+ (void)show
{
    window_ = [[UIWindow alloc] init];
    CGFloat width = 150;
    CGFloat x = [UIScreen mainScreen].bounds.size.width - width - 10;
    window_.frame = CGRectMake(x, 0, width, 25);
    window_.windowLevel = UIWindowLevelAlert;
    window_.hidden = NO;
    window_.alpha = 0.5;
    
    UISegmentedControl *control = [[UISegmentedControl alloc] initWithItems:@[@"示例1", @"示例2", @"示例3"]];
    control.tintColor = [UIColor orangeColor];
    control.frame = window_.bounds;
    control.selectedSegmentIndex = 0;
    [control addTarget:self action:@selector(contorlSelect:) forControlEvents:UIControlEventValueChanged];
    [window_ addSubview:control];
}

+ (void)contorlSelect:(UISegmentedControl *)control
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    keyWindow.rootViewController = [keyWindow.rootViewController.storyboard instantiateViewControllerWithIdentifier:[NSString stringWithFormat:@"%zd", control.selectedSegmentIndex]];
}
@end
