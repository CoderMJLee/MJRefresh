//
//  UIScrollView+MJRefresh.h
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/4.
//  Copyright (c) 2015年 itcast. All rights reserved.
//  给ScrollView增加下拉刷新、上拉刷新的功能

#import <UIKit/UIKit.h>
#import "MJRefreshConst.h"

@class MJRefreshGifHeader, MJRefreshLegendHeader, MJRefreshHeader;
@class MJRefreshGifFooter, MJRefreshLegendFooter, MJRefreshFooter;

@interface UIScrollView (MJRefresh)
#pragma mark - 访问下拉刷新控件
/** 下拉刷新控件 */
@property (weak, nonatomic, readonly) MJRefreshHeader *header;
/** gif功能的下拉刷新控件 */
@property (weak, nonatomic, readonly) MJRefreshGifHeader *gifHeader;
/** 传统的下拉刷新控件 */
@property (weak, nonatomic, readonly) MJRefreshLegendHeader *legendHeader;

#pragma mark - 添加下拉刷新控件
/**
 * 添加一个传统的下拉刷新控件
 */
- (void)addLegendHeader;
/**
 * 添加一个gif图片的下拉刷新控件
 */
- (void)addGifHeader;

#pragma mark - 移除下拉刷新控件
- (void)removeHeader;

#pragma mark - 访问上拉刷新控件
/** 上拉刷新控件 */
@property (weak, nonatomic, readonly) MJRefreshFooter *footer;
/** gif功能的上拉刷新控件 */
@property (weak, nonatomic, readonly) MJRefreshGifFooter *gifFooter;
/** 传统的上拉刷新控件 */
@property (weak, nonatomic, readonly) MJRefreshLegendFooter *legendFooter;

#pragma mark - 添加上拉刷新控件
/**
 * 添加一个传统的上拉刷新控件
 */
- (void)addLegendFooter;
/**
 * 添加一个gif图片的上拉刷新控件
 */
- (void)addGifFooter;

#pragma mark - 移除上拉刷新控件
- (void)removeFooter;
@end

#pragma mark - 1.0.0版本以前的接口
@interface UIScrollView(MJRefreshDeprecated)
#pragma mark - 下拉刷新
/**
 *  添加一个下拉刷新头部控件
 *
 *  @param callback 回调
 */
- (void)addHeaderWithCallback:(void (^)())callback MJDeprecated("建议直接使用addLegendHeader");

/**
 *  添加一个下拉刷新头部控件
 *
 *  @param callback 回调
 *  @param dateKey 刷新时间保存的key值
 */
- (void)addHeaderWithCallback:(void (^)())callback dateKey:(NSString*)dateKey MJDeprecated("建议直接使用addLegendHeader");

/**
 *  添加一个下拉刷新头部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)addHeaderWithTarget:(id)target action:(SEL)action MJDeprecated("建议直接使用addLegendHeader");

/**
 *  添加一个下拉刷新头部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 *  @param dateKey 刷新时间保存的key值
 */
- (void)addHeaderWithTarget:(id)target action:(SEL)action dateKey:(NSString*)dateKey MJDeprecated("建议直接使用addLegendHeader");

/**
 *  主动让下拉刷新头部控件进入刷新状态
 */
- (void)headerBeginRefreshing MJDeprecated("建议直接使用[self.header beginRefreshing]");

/**
 *  让下拉刷新头部控件停止刷新状态
 */
- (void)headerEndRefreshing MJDeprecated("建议直接使用[self.header endRefreshing]");

/**
 *  下拉刷新头部控件的可见性
 */
@property (nonatomic, assign, getter = isHeaderHidden) BOOL headerHidden MJDeprecated("建议直接使用self.header.hidden");

/**
 *  是否正在下拉刷新
 */
@property (nonatomic, assign, readonly, getter = isHeaderRefreshing) BOOL headerRefreshing MJDeprecated("建议直接使用self.header.isRefreshing");

#pragma mark - 上拉刷新
/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param callback 回调
 */
- (void)addFooterWithCallback:(void (^)())callback MJDeprecated("建议直接使用addLegendFooter");

/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)addFooterWithTarget:(id)target action:(SEL)action MJDeprecated("建议直接使用addLegendFooter");

/**
 *  主动让上拉刷新尾部控件进入刷新状态
 */
- (void)footerBeginRefreshing MJDeprecated("建议直接使用[self.footer beginRefreshing]");

/**
 *  让上拉刷新尾部控件停止刷新状态
 */
- (void)footerEndRefreshing MJDeprecated("建议直接使用[self.footer endRefreshing]");

/**
 *  上拉刷新头部控件的可见性
 */
@property (nonatomic, assign, getter = isFooterHidden) BOOL footerHidden MJDeprecated("建议直接使用self.footer.hidden");

/**
 *  是否正在上拉刷新
 */
@property (nonatomic, assign, readonly, getter = isFooterRefreshing) BOOL footerRefreshing MJDeprecated("建议直接使用self.footer.isRefreshing");
@end
