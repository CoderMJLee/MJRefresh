//
//  MJRefreshHeaderView.h
//  MJRefresh
//
//  Created by mj on 13-2-26.
//  Copyright (c) 2013年 itcast. All rights reserved.
//  下拉刷新

#import "MJRefreshBaseView.h"
@class MJRefreshHeaderView;

/**
 代理的协议定义
 */
@protocol MJRefreshHeaderViewDelegate <NSObject>
@optional
/**
 *  开始进入刷新状态就会调用
 *
 *  @param refreshHeaderView 刷新控件
 */
- (void)refreshHeaderViewBeginRefreshing:(MJRefreshHeaderView *)refreshHeaderView;
@end

@interface MJRefreshHeaderView : MJRefreshBaseView
+ (instancetype)header;
/**
 *  代理
 */
@property (weak, nonatomic) id<MJRefreshHeaderViewDelegate> delegate;

/**
 *  开始进入刷新状态就会调用
 */
@property (nonatomic, copy) void (^beginRefreshingCallback)(MJRefreshHeaderView *refreshHeaderView);
@end