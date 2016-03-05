//
//  MJRefreshBackStateFooter.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/13.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "MJRefreshBackStateFooter.h"

@interface MJRefreshBackStateFooter()
{
    /** 显示刷新状态的label */
    __unsafe_unretained UILabel *_stateLabel;
}
/** 所有状态对应的文字 */
@property (strong, nonatomic) NSMutableDictionary *stateTitles;
@end

@implementation MJRefreshBackStateFooter
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
        [self addSubview:_stateLabel = [UILabel label]];
    }
    return _stateLabel;
}

#pragma mark - 公共方法
- (void)setTitle:(NSString *)title forState:(MJRefreshState)state
{
    if (title == nil) return;
    self.stateTitles[@(state)] = title;
    self.stateLabel.text = self.stateTitles[@(self.state)];
}

- (NSString *)titleForState:(MJRefreshState)state {
  return self.stateTitles[@(state)];
}

#pragma mark - 重写父类的方法
- (void)prepare
{
    [super prepare];
    
    // 初始化文字
    [self setTitle:MJRefreshBackFooterIdleText forState:MJRefreshStateIdle];
    [self setTitle:MJRefreshBackFooterPullingText forState:MJRefreshStatePulling];
    [self setTitle:MJRefreshBackFooterRefreshingText forState:MJRefreshStateRefreshing];
    [self setTitle:MJRefreshBackFooterNoMoreDataText forState:MJRefreshStateNoMoreData];
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    if (self.stateLabel.constraints.count) return;
    
    // 状态标签
    self.stateLabel.frame = self.bounds;
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 设置状态文字
    self.stateLabel.text = self.stateTitles[@(state)];
}
@end
