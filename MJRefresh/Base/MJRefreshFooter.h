//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  MJRefreshFooter.h
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//  上拉刷新控件

#import "MJRefreshComponent.h"

@interface MJRefreshFooter : MJRefreshComponent
/** 创建footer */
+ (instancetype)footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;
/** 创建footer */
+ (instancetype)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

/** 提示没有更多的数据 */
- (void)endRefreshingWithNoMoreData;
- (void)noticeNoMoreData MJRefreshDeprecated("使用endRefreshingWithNoMoreData");

/** 重置没有更多的数据（消除没有更多数据的状态） */
- (void)resetNoMoreData;

/** 忽略多少scrollView的contentInset的bottom */
@property (assign, nonatomic) CGFloat ignoredScrollViewContentInsetBottom;

/** 自动根据有无数据来显示和隐藏（有数据就显示，没有数据隐藏） */
@property (assign, nonatomic, getter=isAutomaticallyHidden) BOOL automaticallyHidden;
@end
