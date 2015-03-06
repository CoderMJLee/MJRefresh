//
//  MJRefreshLegendFooter.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/5.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "MJRefreshLegendFooter.h"
#import "MJRefreshConst.h"
#import "UIView+MJExtension.h"
#import "UIScrollView+MJExtension.h"

@interface MJRefreshLegendFooter()
@property (nonatomic, weak) UIActivityIndicatorView *activityView;
@end

@implementation MJRefreshLegendFooter
#pragma mark - 懒加载
- (UIActivityIndicatorView *)activityView
{
    if (!_activityView) {
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:_activityView = activityView];
    }
    return _activityView;
}

#pragma mark - 初始化方法
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 指示器
    if (self.stateHidden) {
        self.activityView.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5);
    } else {
        self.activityView.center = CGPointMake(self.mj_w * 0.5 - 100, self.mj_h * 0.5);
    }
}

#pragma mark - 公共方法
- (void)setState:(MJRefreshFooterState)state
{
    if (self.state == state) return;
    
    [super setState:state];
    
    switch (state) {
        case MJRefreshFooterStateIdle:
            [self.activityView stopAnimating];
            break;
            
        case MJRefreshFooterStateRefreshing:
            [self.activityView startAnimating];
            break;
            
        case MJRefreshFooterStateNoMoreData:
            [self.activityView stopAnimating];
            break;
            
        default:
            break;
    }
}
@end
