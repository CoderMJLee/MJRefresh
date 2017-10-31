//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  MJRefreshHeader.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/4.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJRefreshHeader.h"

@interface MJRefreshHeader()
@property (assign, nonatomic) CGFloat insetTDelta;
@property (assign, nonatomic) CGFloat insetLDelta;

@end

@implementation MJRefreshHeader
#pragma mark - 构造方法
+ (instancetype)headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock
{
    MJRefreshHeader *cmp = [[self alloc] init];
    cmp.refreshingBlock = refreshingBlock;
    return cmp;
}
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    MJRefreshHeader *cmp = [[self alloc] init];
    [cmp setRefreshingTarget:target refreshingAction:action];
    return cmp;
}

#pragma mark - 覆盖父类的方法
- (void)prepare
{
    [super prepare];
    
    // 设置key
    self.lastUpdatedTimeKey = MJRefreshHeaderLastUpdatedTimeKey;
    
    switch (self.scrollView.mj_refreshDirection) {
        case MJRefreshDirectionHorizontal:
            // 设置宽度
            self.mj_w = MJRefreshHeaderHeight;
            break;
        case MJRefreshDirectionVertical:
        default:
            // 设置高度
            self.mj_h = MJRefreshHeaderHeight;
            break;
    }
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    switch (self.scrollView.mj_refreshDirection) {
        case MJRefreshDirectionHorizontal:
            // 设置x值(当自己的高度发生改变了，肯定要重新调整X值，所以放到placeSubviews方法中设置x值)
            self.mj_x = - self.mj_w - self.ignoredScrollViewContentInsetLeft;
            break;
        case MJRefreshDirectionVertical:
        default:
            // 设置y值(当自己的高度发生改变了，肯定要重新调整Y值，所以放到placeSubviews方法中设置y值)
            self.mj_y = - self.mj_h - self.ignoredScrollViewContentInsetTop;
            break;
    }
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
    
    switch (self.scrollView.mj_refreshDirection) {
        case MJRefreshDirectionHorizontal:{
            // 在刷新的refreshing状态
            if (self.state == MJRefreshStateRefreshing) {
                if (self.window == nil) return;
                
                // sectionheader停留解决
                CGFloat insetL = - self.scrollView.mj_offsetX > _scrollViewOriginalInset.left ? - self.scrollView.mj_offsetX : _scrollViewOriginalInset.left;
                insetL = insetL > self.mj_w + _scrollViewOriginalInset.left ? self.mj_w + _scrollViewOriginalInset.left : insetL;
                self.scrollView.mj_insetL = insetL;
                self.insetLDelta = _scrollViewOriginalInset.left - insetL;
                return;
            }
            
            // 跳转到下一个控制器时，contentInset可能会变
            _scrollViewOriginalInset = self.scrollView.mj_inset;
            
            // 当前的contentOffset
            CGFloat offsetX = self.scrollView.mj_offsetX;
            // 头部控件刚好出现的offsetX
            CGFloat happenOffsetX = - self.scrollViewOriginalInset.left;
            
            // 如果是向上滚动到看不见头部控件，直接返回
            // >= -> >
            if (offsetX > happenOffsetX) return;
            
            // 普通 和 即将刷新 的临界点
            CGFloat normal2pullingOffsetX = happenOffsetX - self.mj_w;
            CGFloat pullingPercent = (happenOffsetX - offsetX) / self.mj_w;
            
            if (self.scrollView.isDragging) { // 如果正在拖拽
                self.pullingPercent = pullingPercent;
                if (self.state == MJRefreshStateIdle && offsetX < normal2pullingOffsetX) {
                    // 转为即将刷新状态
                    self.state = MJRefreshStatePulling;
                } else if (self.state == MJRefreshStatePulling && offsetX >= normal2pullingOffsetX) {
                    // 转为普通状态
                    self.state = MJRefreshStateIdle;
                }
            } else if (self.state == MJRefreshStatePulling) {// 即将刷新 && 手松开
                // 开始刷新
                [self beginRefreshing];
            } else if (pullingPercent < 1) {
                self.pullingPercent = pullingPercent;
            }
        }
            break;
        case MJRefreshDirectionVertical:
        default:{
            // 在刷新的refreshing状态
            if (self.state == MJRefreshStateRefreshing) {
                if (self.window == nil) return;
                
                // sectionheader停留解决
                CGFloat insetT = - self.scrollView.mj_offsetY > _scrollViewOriginalInset.top ? - self.scrollView.mj_offsetY : _scrollViewOriginalInset.top;
                insetT = insetT > self.mj_h + _scrollViewOriginalInset.top ? self.mj_h + _scrollViewOriginalInset.top : insetT;
                self.scrollView.mj_insetT = insetT;
                
                self.insetTDelta = _scrollViewOriginalInset.top - insetT;
                return;
            }
            
            // 跳转到下一个控制器时，contentInset可能会变
            _scrollViewOriginalInset = self.scrollView.mj_inset;
            
            // 当前的contentOffset
            CGFloat offsetY = self.scrollView.mj_offsetY;
            // 头部控件刚好出现的offsetY
            CGFloat happenOffsetY = - self.scrollViewOriginalInset.top;
            
            // 如果是向上滚动到看不见头部控件，直接返回
            // >= -> >
            if (offsetY > happenOffsetY) return;

            // 普通 和 即将刷新 的临界点
            CGFloat normal2pullingOffsetY = happenOffsetY - self.mj_h;
            CGFloat pullingPercent = (happenOffsetY - offsetY) / self.mj_h;

            if (self.scrollView.isDragging) { // 如果正在拖拽
                self.pullingPercent = pullingPercent;
                if (self.state == MJRefreshStateIdle && offsetY < normal2pullingOffsetY) {
                    // 转为即将刷新状态
                    self.state = MJRefreshStatePulling;
                } else if (self.state == MJRefreshStatePulling && offsetY >= normal2pullingOffsetY) {
                    // 转为普通状态
                    self.state = MJRefreshStateIdle;
                }
            } else if (self.state == MJRefreshStatePulling) {// 即将刷新 && 手松开
                // 开始刷新
                [self beginRefreshing];
            } else if (pullingPercent < 1) {
                self.pullingPercent = pullingPercent;
            }
        }
            break;
    }

}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    switch (self.scrollView.mj_refreshDirection) {
        case MJRefreshDirectionHorizontal:{
            // 根据状态做事情
            if (state == MJRefreshStateIdle) {
                if (oldState != MJRefreshStateRefreshing) return;
                
                // 保存刷新时间
                [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:self.lastUpdatedTimeKey];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                // 恢复inset和offset
                [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                    self.scrollView.mj_insetL += self.insetLDelta;
                    
                    // 自动调整透明度
                    if (self.isAutomaticallyChangeAlpha) self.alpha = 0.0;
                } completion:^(BOOL finished) {
                    self.pullingPercent = 0.0;
                    
                    if (self.endRefreshingCompletionBlock) {
                        self.endRefreshingCompletionBlock();
                    }
                }];
            } else if (state == MJRefreshStateRefreshing) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                        CGFloat left = self.scrollViewOriginalInset.left + self.mj_w;
                        // 增加滚动区域left
                        self.scrollView.mj_insetL = left;
                        // 设置滚动位置
                        CGPoint offset = self.scrollView.contentOffset;
                        offset.x = -left;
                        [self.scrollView setContentOffset:offset animated:NO];
                    } completion:^(BOOL finished) {
                        [self executeRefreshingCallback];
                    }];
                });
            }

            break;
        }
        case MJRefreshDirectionVertical:
        default:{
            // 根据状态做事情
            if (state == MJRefreshStateIdle) {
                if (oldState != MJRefreshStateRefreshing) return;
                
                // 保存刷新时间
                [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:self.lastUpdatedTimeKey];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                // 恢复inset和offset
                [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                    self.scrollView.mj_insetT += self.insetTDelta;
                    
                    // 自动调整透明度
                    if (self.isAutomaticallyChangeAlpha) self.alpha = 0.0;
                } completion:^(BOOL finished) {
                    self.pullingPercent = 0.0;
                    
                    if (self.endRefreshingCompletionBlock) {
                        self.endRefreshingCompletionBlock();
                    }
                }];
            } else if (state == MJRefreshStateRefreshing) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                        CGFloat top = self.scrollViewOriginalInset.top + self.mj_h;
                        // 增加滚动区域top
                        self.scrollView.mj_insetT = top;
                        // 设置滚动位置
                        CGPoint offset = self.scrollView.contentOffset;
                        offset.y = -top;
                        [self.scrollView setContentOffset:offset animated:NO];
                    } completion:^(BOOL finished) {
                        [self executeRefreshingCallback];
                    }];
                });
            }

            break;
        }
    }
    
}

#pragma mark - 公共方法
- (NSDate *)lastUpdatedTime
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:self.lastUpdatedTimeKey];
}
@end
