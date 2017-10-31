//
//  MJRefreshAutoFooter.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/4/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJRefreshAutoFooter.h"

@interface MJRefreshAutoFooter()
@end

@implementation MJRefreshAutoFooter

#pragma mark - 初始化
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    switch (self.scrollView.mj_refreshDirection) {
        case MJRefreshDirectionHorizontal:
            if (newSuperview) { // 新的父控件
                if (self.hidden == NO) {
                    self.scrollView.mj_insetR += self.mj_w;
                }
                
                // 设置位置
                self.mj_x = _scrollView.mj_contentW;
            } else { // 被移除了
                if (self.hidden == NO) {
                    self.scrollView.mj_insetR -= self.mj_w;
                }
            }
            break;
        case MJRefreshDirectionVertical:
        default:
            if (newSuperview) { // 新的父控件
                if (self.hidden == NO) {
                    self.scrollView.mj_insetB += self.mj_h;
                }
                
                // 设置位置
                self.mj_y = _scrollView.mj_contentH;
            } else { // 被移除了
                if (self.hidden == NO) {
                    self.scrollView.mj_insetB -= self.mj_h;
                }
            }
            break;
    }

}

#pragma mark - 过期方法
- (void)setAppearencePercentTriggerAutoRefresh:(CGFloat)appearencePercentTriggerAutoRefresh
{
    self.triggerAutomaticallyRefreshPercent = appearencePercentTriggerAutoRefresh;
}

- (CGFloat)appearencePercentTriggerAutoRefresh
{
    return self.triggerAutomaticallyRefreshPercent;
}

#pragma mark - 实现父类的方法
- (void)prepare
{
    [super prepare];
    
    // 默认底部控件100%出现时才会自动刷新
    self.triggerAutomaticallyRefreshPercent = 1.0;
    
    // 设置为默认状态
    self.automaticallyRefresh = YES;
}

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
    switch (self.scrollView.mj_refreshDirection) {
        case MJRefreshDirectionHorizontal:
            // 设置位置
            self.mj_x = self.scrollView.mj_contentW;
            break;
        case MJRefreshDirectionVertical:
        default:
            // 设置位置
            self.mj_y = self.scrollView.mj_contentH;
            break;
    }

}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
    switch (self.scrollView.mj_refreshDirection) {
        case MJRefreshDirectionHorizontal:
        {
            if (self.state != MJRefreshStateIdle || !self.automaticallyRefresh || self.mj_x == 0) return;
            
            if (_scrollView.mj_insetL + _scrollView.mj_contentW > _scrollView.mj_w) { // 内容超过一个屏幕
                // 这里的_scrollView.mj_contentW替换掉self.mj_x更为合理
                if (_scrollView.mj_offsetX >= _scrollView.mj_contentW - _scrollView.mj_w + self.mj_w * self.triggerAutomaticallyRefreshPercent + _scrollView.mj_insetR - self.mj_w) {
                    // 防止手松开时连续调用
                    CGPoint old = [change[@"old"] CGPointValue];
                    CGPoint new = [change[@"new"] CGPointValue];
                    if (new.x <= old.x) return;
                    
                    // 当底部刷新控件完全出现时，才刷新
                    [self beginRefreshing];
                }
            }
        }
            break;
        case MJRefreshDirectionVertical:
        default:
        {
            if (self.state != MJRefreshStateIdle || !self.automaticallyRefresh || self.mj_y == 0) return;
            
            if (_scrollView.mj_insetT + _scrollView.mj_contentH > _scrollView.mj_h) { // 内容超过一个屏幕
                // 这里的_scrollView.mj_contentH替换掉self.mj_y更为合理
                if (_scrollView.mj_offsetY >= _scrollView.mj_contentH - _scrollView.mj_h + self.mj_h * self.triggerAutomaticallyRefreshPercent + _scrollView.mj_insetB - self.mj_h) {
                    // 防止手松开时连续调用
                    CGPoint old = [change[@"old"] CGPointValue];
                    CGPoint new = [change[@"new"] CGPointValue];
                    if (new.y <= old.y) return;
                    
                    // 当底部刷新控件完全出现时，才刷新
                    [self beginRefreshing];
                }
            }
        }
            break;
    }

}

- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
    if (self.state != MJRefreshStateIdle) return;
    
    switch (self.scrollView.mj_refreshDirection) {
        case MJRefreshDirectionHorizontal:
            if (_scrollView.panGestureRecognizer.state == UIGestureRecognizerStateEnded) {// 手松开
                if (_scrollView.mj_insetL + _scrollView.mj_contentW <= _scrollView.mj_w) {  // 不够一个屏幕
                    if (_scrollView.mj_offsetX >= - _scrollView.mj_insetL) { // 向上拽
                        [self beginRefreshing];
                    }
                } else { // 超出一个屏幕
                    if (_scrollView.mj_offsetX >= _scrollView.mj_contentW + _scrollView.mj_insetR - _scrollView.mj_w) {
                        [self beginRefreshing];
                    }
                }
            }
            break;
        case MJRefreshDirectionVertical:
        default:
            if (_scrollView.panGestureRecognizer.state == UIGestureRecognizerStateEnded) {// 手松开
                if (_scrollView.mj_insetT + _scrollView.mj_contentH <= _scrollView.mj_h) {  // 不够一个屏幕
                    if (_scrollView.mj_offsetY >= - _scrollView.mj_insetT) { // 向上拽
                        [self beginRefreshing];
                    }
                } else { // 超出一个屏幕
                    if (_scrollView.mj_offsetY >= _scrollView.mj_contentH + _scrollView.mj_insetB - _scrollView.mj_h) {
                        [self beginRefreshing];
                    }
                }
            }
            break;
    }

}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    if (state == MJRefreshStateRefreshing) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self executeRefreshingCallback];
        });
    } else if (state == MJRefreshStateNoMoreData || state == MJRefreshStateIdle) {
        if (MJRefreshStateRefreshing == oldState) {
            if (self.endRefreshingCompletionBlock) {
                self.endRefreshingCompletionBlock();
            }
        }
    }
}

- (void)setHidden:(BOOL)hidden
{
    BOOL lastHidden = self.isHidden;
    
    [super setHidden:hidden];
    
    switch (self.scrollView.mj_refreshDirection) {
        case MJRefreshDirectionHorizontal:
        {
            if (!lastHidden && hidden) {
                self.state = MJRefreshStateIdle;
                
                self.scrollView.mj_insetR -= self.mj_w;
            } else if (lastHidden && !hidden) {
                self.scrollView.mj_insetR += self.mj_w;
                
                // 设置位置
                self.mj_x = _scrollView.mj_contentW;
            }
        }
            break;
        case MJRefreshDirectionVertical:
        default:
        {
            if (!lastHidden && hidden) {
                self.state = MJRefreshStateIdle;
                
                self.scrollView.mj_insetB -= self.mj_h;
            } else if (lastHidden && !hidden) {
                self.scrollView.mj_insetB += self.mj_h;
                
                // 设置位置
                self.mj_y = _scrollView.mj_contentH;
            }
        }
            break;
    }
    

}
@end
