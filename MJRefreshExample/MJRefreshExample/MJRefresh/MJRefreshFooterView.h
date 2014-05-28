//
//  MJRefreshTableFooterView.h
//  MJRefresh
//
//  Created by mj on 13-2-26.
//  Copyright (c) 2013年 itcast. All rights reserved.
//  上拉加载更多

#import "MJRefreshBaseView.h"
@class MJRefreshFooterView;

/**
 代理的协议定义
 */
@protocol MJRefreshFooterViewDelegate <NSObject>
@optional
/**
 *  开始进入刷新状态就会调用
 *
 *  @param refreshFooterView 刷新控件
 */
- (void)refreshFooterViewBeginRefreshing:(MJRefreshFooterView *)refreshFooterView;
@end

@interface MJRefreshFooterView : MJRefreshBaseView
+ (instancetype)footer;
/**
 *  代理
 */
@property (weak, nonatomic) id<MJRefreshFooterViewDelegate> delegate;

/**
 *  开始进入刷新状态就会调用
 */
@property (nonatomic, copy) void (^beginRefreshingCallback)(MJRefreshFooterView *refreshFooterView);
@end