//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  UIScrollView+MJRefresh.h
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/4.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//  给ScrollView增加下拉刷新、上拉刷新、 左滑刷新的功能

#import <UIKit/UIKit.h>
#import "MJRefreshConst.h"

@class MJRefreshHeader, MJRefreshFooter, MJRefreshTrailer;

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (MJRefresh)
/** 下拉刷新控件 */
@property (strong, nonatomic, nullable) MJRefreshHeader *mj_header;
@property (strong, nonatomic, nullable) MJRefreshHeader *header MJRefreshDeprecated("使用mj_header");
/** 上拉刷新控件 */
@property (strong, nonatomic, nullable) MJRefreshFooter *mj_footer;
@property (strong, nonatomic, nullable) MJRefreshFooter *footer MJRefreshDeprecated("使用mj_footer");

/** 左滑刷新控件 */
@property (strong, nonatomic, nullable) MJRefreshTrailer *mj_trailer;

#pragma mark - other
- (NSInteger)mj_totalDataCount;

@end

NS_ASSUME_NONNULL_END
