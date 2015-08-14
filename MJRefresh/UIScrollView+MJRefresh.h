//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  UIScrollView+MJRefresh.h
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/4.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//  给ScrollView增加下拉刷新、上拉刷新的功能

#import <UIKit/UIKit.h>

@class MJRefreshHeader, MJRefreshFooter;

@interface UIScrollView (MJRefresh)
/** 下拉刷新控件 */
@property (strong, nonatomic) MJRefreshHeader *header;
/** 上拉刷新控件 */
@property (strong, nonatomic) MJRefreshFooter *footer;

#pragma mark - other
- (NSInteger)totalDataCount;
@property (copy, nonatomic) void (^reloadDataBlock)(NSInteger totalDataCount);
@end
