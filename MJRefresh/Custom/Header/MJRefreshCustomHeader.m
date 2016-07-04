//
//  MJRefreshCustomHeader.m
//  MJRefreshExample
//
//  Created by king on 16/7/4.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "MJRefreshCustomHeader.h"

@interface MJRefreshCustomHeader ()
@property (nonatomic, weak) UIView *IdleView;
@property (nonatomic, weak) UIView *PullingView;
@property (nonatomic, weak) UIView *RefreshingView;
@end

@implementation MJRefreshCustomHeader

- (void)setView:(UIView *)view forState:(MJRefreshState)state {
    
    switch (state) {
        case MJRefreshStateIdle:
        {
            [self addSubview:view];
            self.IdleView = view;
            break;
        }
        case MJRefreshStatePulling:
        {
            [self addSubview:view];
            self.PullingView = view;
            break;
        }
        case MJRefreshStateRefreshing:
        {
            [self addSubview:view];
            self.RefreshingView = view;
            break;
        }
        default:
            break;
    }
}

- (void)prepare {
    [super prepare];
    self.mj_h = 50;
    
    self.IdleView.hidden        = NO;
    self.PullingView.hidden     = YES;
    self.RefreshingView.hidden  = YES;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    self.IdleView.frame         = self.bounds;
    self.PullingView.frame      = self.bounds;
    self.RefreshingView.frame   = self.bounds;
}
#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            self.IdleView.hidden        = NO;
            self.PullingView.hidden     = YES;
            self.RefreshingView.hidden  = YES;
            break;
        case MJRefreshStatePulling:
            self.IdleView.hidden        = YES;
            self.PullingView.hidden     = NO;
            self.RefreshingView.hidden  = YES;
            break;
        case MJRefreshStateRefreshing:
            self.IdleView.hidden        = YES;
            self.PullingView.hidden     = YES;
            self.RefreshingView.hidden  = NO;
            break;
        default:
            break;
    }
}
@end
