//
//  MJRefreshStateTrailer.h
//  MJRefreshExample
//
//  Created by kinarobin on 2020/5/3.
//  Copyright © 2020 小码哥. All rights reserved.
//

#import "MJRefreshTrailer.h"

NS_ASSUME_NONNULL_BEGIN


@interface MJRefreshStateTrailer : MJRefreshTrailer

#pragma mark - 状态相关
/** 显示刷新状态的label */
@property (weak, nonatomic, readonly) UILabel *stateLabel;
/** 设置state状态下的文字 */
- (instancetype)setTitle:(NSString *)title forState:(MJRefreshState)state;

@end

NS_ASSUME_NONNULL_END
