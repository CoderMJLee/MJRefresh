//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  MJRefreshHeader.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/4.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "MJRefreshHeader.h"
#import "MJRefreshConst.h"
#import "UIView+MJExtension.h"
#import <objc/message.h>
#import "UIScrollView+MJExtension.h"

@interface MJRefreshHeader()
/** 显示上次刷新时间的标签 */
@property (weak, nonatomic) UILabel *updatedTimeLabel;
/** 上次刷新时间 */
@property (strong, nonatomic) NSDate *updatedTime;
/** 显示状态文字的标签 */
@property (weak, nonatomic) UILabel *stateLabel;
/** 所有状态对应的文字 */
@property (strong, nonatomic) NSMutableDictionary *stateTitles;
@end

@implementation MJRefreshHeader
#pragma mark - 懒加载
- (NSMutableDictionary *)stateTitles
{
    if (!_stateTitles) {
        self.stateTitles = [NSMutableDictionary dictionary];
    }
    return _stateTitles;
}

- (UILabel *)stateLabel
{
    if (!_stateLabel) {
        UILabel *stateLabel = [[UILabel alloc] init];
        stateLabel.backgroundColor = [UIColor clearColor];
        stateLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_stateLabel = stateLabel];
    }
    return _stateLabel;
}

- (UILabel *)updatedTimeLabel
{
    if (!_updatedTimeLabel) {
        UILabel *updatedTimeLabel = [[UILabel alloc] init];
        updatedTimeLabel.backgroundColor = [UIColor clearColor];
        updatedTimeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_updatedTimeLabel = updatedTimeLabel];
    }
    return _updatedTimeLabel;
}

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 设置默认的dateKey
        self.dateKey = MJRefreshHeaderUpdatedTimeKey;
        
        // 设置为默认状态
        self.state = MJRefreshHeaderStateIdle;
        
        // 初始化文字
        [self setTitle:MJRefreshHeaderStateIdleText forState:MJRefreshHeaderStateIdle];
        [self setTitle:MJRefreshHeaderStatePullingText forState:MJRefreshHeaderStatePulling];
        [self setTitle:MJRefreshHeaderStateRefreshingText forState:MJRefreshHeaderStateRefreshing];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) {
        self.mj_h = MJRefreshHeaderHeight;
    }
}

- (void)drawRect:(CGRect)rect
{
    if (self.state == MJRefreshHeaderStateWillRefresh) {
        self.state = MJRefreshHeaderStateRefreshing;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置自己的位置
    self.mj_y = - self.mj_h;
    
    // 2个标签都隐藏
    if (self.stateHidden && self.updatedTimeHidden) return;
    
    if (self.updatedTimeHidden) { // 显示状态
        _stateLabel.frame = self.bounds;
    } else if (self.stateHidden) { // 显示时间
        self.updatedTimeLabel.frame = self.bounds;
    } else { // 都显示
        CGFloat stateH = self.mj_h * 0.55;
        CGFloat stateW = self.mj_w;
        // 1.状态标签
        _stateLabel.frame = CGRectMake(0, 0, stateW, stateH);
        
        // 2.时间标签
        CGFloat updatedTimeY = stateH;
        CGFloat updatedTimeH = self.mj_h - stateH;
        CGFloat updatedTimeW = stateW;
        self.updatedTimeLabel.frame = CGRectMake(0, updatedTimeY, updatedTimeW, updatedTimeH);
    }
}

#pragma mark - 私有方法
- (void)setDateKey:(NSString *)dateKey
{
    _dateKey = dateKey ? dateKey : MJRefreshHeaderUpdatedTimeKey;
    
    self.updatedTime = [[NSUserDefaults standardUserDefaults] objectForKey:_dateKey];
}

#pragma mark 设置最后的更新时间
- (void)setUpdatedTime:(NSDate *)updatedTime
{
    _updatedTime = updatedTime;
    
    if (updatedTime) {
        [[NSUserDefaults standardUserDefaults] setObject:updatedTime forKey:self.dateKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    if (self.updatedTimeTitle) {
        self.updatedTimeLabel.text = self.updatedTimeTitle(updatedTime);
        return;
    }
    
    if (updatedTime) {
        // 1.获得年月日
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute;
        NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:updatedTime];
        NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
        
        // 2.格式化日期
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        if ([cmp1 day] == [cmp2 day]) { // 今天
            formatter.dateFormat = @"今天 HH:mm";
        } else if ([cmp1 year] == [cmp2 year]) { // 今年
            formatter.dateFormat = @"MM-dd HH:mm";
        } else {
            formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        }
        NSString *time = [formatter stringFromDate:updatedTime];
        
        // 3.显示日期
        self.updatedTimeLabel.text = [NSString stringWithFormat:@"最后更新：%@", time];
    } else {
        self.updatedTimeLabel.text = @"最后更新：无记录";
    }
}

#pragma mark KVO属性监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 遇到这些情况就直接返回
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden || self.state == MJRefreshHeaderStateRefreshing) return;
    
    // 根据contentOffset调整state
    if ([keyPath isEqualToString:MJRefreshContentOffset]) {
        [self adjustStateWithContentOffset];
    }
}

#pragma mark 根据contentOffset调整state
- (void)adjustStateWithContentOffset
{
    if (self.state != MJRefreshHeaderStateRefreshing) {
        // 在刷新过程中，跳转到下一个控制器时，contentInset可能会变
        _scrollViewOriginalInset = _scrollView.contentInset;
    }
    
    // 在刷新的 refreshing 状态，动态设置 content inset
    if (self.state == MJRefreshHeaderStateRefreshing ) {
        if(_scrollView.contentOffset.y >= -_scrollViewOriginalInset.top ) {
            _scrollView.mj_insetT = _scrollViewOriginalInset.top;
        } else {
            _scrollView.mj_insetT = MIN(_scrollViewOriginalInset.top + self.mj_h,
                                        _scrollViewOriginalInset.top - _scrollView.contentOffset.y);
        }
        return;
    }
    
    // 当前的contentOffset
    CGFloat offsetY = _scrollView.mj_offsetY;
    // 头部控件刚好出现的offsetY
    CGFloat happenOffsetY = - _scrollViewOriginalInset.top;
    
    // 如果是向上滚动到看不见头部控件，直接返回
    if (offsetY >= happenOffsetY) return;
    
    // 普通 和 即将刷新 的临界点
    CGFloat normal2pullingOffsetY = happenOffsetY - self.mj_h;
    if (_scrollView.isDragging) {
        self.pullingPercent = (happenOffsetY - offsetY) / self.mj_h;
        
        if (self.state == MJRefreshHeaderStateIdle && offsetY < normal2pullingOffsetY) {
            // 转为即将刷新状态
            self.state = MJRefreshHeaderStatePulling;
        } else if (self.state == MJRefreshHeaderStatePulling && offsetY >= normal2pullingOffsetY) {
            // 转为普通状态
            self.state = MJRefreshHeaderStateIdle;
        }
    } else if (self.state == MJRefreshHeaderStatePulling) {// 即将刷新 && 手松开
        self.pullingPercent = 1.0;
        // 开始刷新
        self.state = MJRefreshHeaderStateRefreshing;
    } else {
        self.pullingPercent = (happenOffsetY - offsetY) / self.mj_h;
    }
}

#pragma mark - 公共方法
- (void)setTitle:(NSString *)title forState:(MJRefreshHeaderState)state
{
    if (title == nil) return;
    self.stateTitles[@(state)] = title;
    
    // 刷新当前状态的文字
    self.stateLabel.text = self.stateTitles[@(self.state)];
}

- (void)beginRefreshing
{
    if (self.window) {
        self.state = MJRefreshHeaderStateRefreshing;
    } else {
        self.state = MJRefreshHeaderStateWillRefresh;
    }
}

- (void)endRefreshing
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.state = MJRefreshHeaderStateIdle;
    });
}

- (BOOL)isRefreshing
{
    return self.state == MJRefreshHeaderStateRefreshing;
}

- (void)setState:(MJRefreshHeaderState)state
{
    if (_state == state) return;
    
    // 旧状态
    MJRefreshHeaderState oldState = _state;
    
    // 赋值
    _state = state;
    
    // 设置状态文字
    _stateLabel.text = _stateTitles[@(state)];
    
    switch (state) {
        case MJRefreshHeaderStateIdle: {
            if (oldState == MJRefreshHeaderStateRefreshing) {
                // 保存刷新时间
                self.updatedTime = [NSDate date];
                
                // 恢复inset和offset
                [UIView animateWithDuration:MJRefreshSlowAnimationDuration delay:0.0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^{
                    // 修复top值不断累加
                    _scrollView.mj_insetT -= self.mj_h;
                } completion:nil];
            }
            break;
        }
            
        case MJRefreshHeaderStateRefreshing: {
            [UIView animateWithDuration:MJRefreshFastAnimationDuration delay:0.0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^{
                // 增加滚动区域
                CGFloat top = _scrollViewOriginalInset.top + self.mj_h;
                _scrollView.mj_insetT = top;
                
                // 设置滚动位置
                _scrollView.mj_offsetY = - top;
            } completion:^(BOOL finished) {
                // 回调
                if (self.refreshingBlock) {
                    self.refreshingBlock();
                }
                
                if ([self.refreshingTarget respondsToSelector:self.refreshingAction]) {
                    msgSend(msgTarget(self.refreshingTarget), self.refreshingAction, self);
                }
            }];
            break;
        }
            
        default:
            break;
    }
}

- (void)setTextColor:(UIColor *)textColor
{
    [super setTextColor:textColor];
    
    self.updatedTimeLabel.textColor = textColor;
    self.stateLabel.textColor = textColor;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.updatedTimeLabel.font = font;
    self.stateLabel.font = font;
}

- (void)setStateHidden:(BOOL)stateHidden
{
    _stateHidden = stateHidden;
    
    self.stateLabel.hidden = stateHidden;
    [self setNeedsLayout];
}

- (void)setUpdatedTimeHidden:(BOOL)updatedTimeHidden
{
    _updatedTimeHidden = updatedTimeHidden;
    
    self.updatedTimeLabel.hidden = updatedTimeHidden;
    [self setNeedsLayout];
}
@end
