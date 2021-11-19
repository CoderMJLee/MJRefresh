//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  MJRefreshFooter.h
//  MJRefresh
//
//  Created by MJ Lee on 15/3/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//  上拉刷新控件

#if __has_include(<MJRefresh/MJRefreshComponent.h>)
#import <MJRefresh/MJRefreshComponent.h>
#else
#import "MJRefreshComponent.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface MJRefreshFooter : MJRefreshComponent
/** 创建footer */
+ (instancetype)footerWithRefreshingBlock:(MJRefreshComponentAction)refreshingBlock;
/** 创建footer */
+ (instancetype)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

/** 提示没有更多的数据 */
- (void)endRefreshingWithNoMoreData;
- (void)noticeNoMoreData MJRefreshDeprecated("使用endRefreshingWithNoMoreData");

/** 重置没有更多的数据（消除没有更多数据的状态） */
- (void)resetNoMoreData;

/** 忽略多少scrollView的contentInset的bottom */
@property (assign, nonatomic) CGFloat ignoredScrollViewContentInsetBottom;

/** 自动根据有无数据来显示和隐藏（有数据就显示，没有数据隐藏。默认是NO） */
@property (assign, nonatomic, getter=isAutomaticallyHidden) BOOL automaticallyHidden MJRefreshDeprecated("已废弃此属性，开发者请自行控制footer的显示和隐藏");
@end

NS_ASSUME_NONNULL_END
