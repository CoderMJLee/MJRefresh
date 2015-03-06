//
//  MJRefreshComponent.h
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/4.
//  Copyright (c) 2015年 itcast. All rights reserved.
//  刷新组件：基本的开始刷新和结束刷新行为

#import <UIKit/UIKit.h>

@interface MJRefreshComponent : UIView
{
    UIEdgeInsets _scrollViewOriginalInset;
    __weak UIScrollView *_scrollView;
}

#pragma mark - 文字处理
/** 文字颜色 */
@property (strong, nonatomic) UIColor *textColor;
/** 字体大小 */
@property (strong, nonatomic) UIFont *font;

#pragma mark - 刷新处理
/** 正在刷新的回调 */
@property (copy, nonatomic) void (^refreshingBlock)();
/** 设置回调对象和回调方法 */
- (void)setRefreshingTarget:(id)target refreshingAction:(SEL)action;
@property (weak, nonatomic) id refreshingTarget;
@property (assign, nonatomic) SEL refreshingAction;
/** 进入刷新状态 */
- (void)beginRefreshing;
/** 结束刷新状态 */
- (void)endRefreshing;
/** 是否正在刷新 */
- (BOOL)isRefreshing;
@end
