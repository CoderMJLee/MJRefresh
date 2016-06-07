//
//  MJRefreshBackStateFooter.h
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/13.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "MJRefreshBackFooter.h"

@interface MJRefreshBackStateFooter : MJRefreshBackFooter
/** 显示刷新状态的label */
@property (weak, nonatomic, readonly) UILabel *stateLabel;
/** 设置state状态下的文字 */
- (void)mj_setTitle:(NSString *)title forState:(MJRefreshState)state;

/** 获取state状态下的title */
- (NSString *)mj_titleForState:(MJRefreshState)state;


#pragma mark - 过期方法
/** 设置state状态下的文字 */
- (void)setTitle:(NSString *)title forState:(MJRefreshState)state MJRefreshDeprecated("使用mj_setTitle:forState:");

/** 获取state状态下的title */
- (NSString *)titleForState:(MJRefreshState)state MJRefreshDeprecated("使用mj_titleForState:");
@end
