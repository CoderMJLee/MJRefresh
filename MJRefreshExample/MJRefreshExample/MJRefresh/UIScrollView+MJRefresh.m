//
//  UIScrollView+MJRefresh.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/4.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UIScrollView+MJRefresh.h"
#import "MJRefreshGifHeader.h"
#import "MJRefreshLegendHeader.h"
#import "MJRefreshGifFooter.h"
#import "MJRefreshLegendFooter.h"
#import <objc/runtime.h>

@implementation UIScrollView (MJRefresh)
#pragma mark - 下拉刷新
- (void)addLegendHeader
{
    [self removeHeader];
    
    MJRefreshLegendHeader *header = [[MJRefreshLegendHeader alloc] init];
    [self addSubview:header];
    self.legendHeader = header;
}

- (void)addGifHeader
{
    [self removeHeader];
    
    MJRefreshGifHeader *header = [[MJRefreshGifHeader alloc] init];
    [self addSubview:header];
    self.gifHeader = header;
}

- (void)removeHeader
{
    [self.legendHeader removeFromSuperview];
    self.legendHeader = nil;
    
    [self.gifHeader removeFromSuperview];
    self.gifHeader = nil;
}

static char MJRefreshGifHeaderKey;
- (void)setGifHeader:(MJRefreshGifHeader *)gifHeader
{
    [self willChangeValueForKey:@"gifHeader"];
    objc_setAssociatedObject(self, &MJRefreshGifHeaderKey,
                             gifHeader,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"gifHeader"];
}

- (MJRefreshGifHeader *)gifHeader
{
    return objc_getAssociatedObject(self, &MJRefreshGifHeaderKey);
}

static char MJRefreshLegendHeaderKey;
- (void)setLegendHeader:(MJRefreshLegendHeader *)legendHeader
{
    [self willChangeValueForKey:@"legendHeader"];
    objc_setAssociatedObject(self, &MJRefreshLegendHeaderKey,
                             legendHeader,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"legendHeader"];
}

- (MJRefreshLegendHeader *)legendHeader
{
    return objc_getAssociatedObject(self, &MJRefreshLegendHeaderKey);
}

- (MJRefreshHeader *)header
{
    MJRefreshHeader *header = self.legendHeader;
    return header ? header : self.gifHeader;
}

#pragma mark - 上拉刷新
- (void)addLegendFooter
{
    [self removeFooter];
    
    MJRefreshLegendFooter *footer = [[MJRefreshLegendFooter alloc] init];
    [self addSubview:footer];
    self.legendFooter = footer;
}

- (void)addGifFooter
{
    [self removeFooter];
    
    MJRefreshGifFooter *footer = [[MJRefreshGifFooter alloc] init];
    [self addSubview:footer];
    self.gifFooter = footer;
}

- (void)removeFooter
{
    [self.legendFooter removeFromSuperview];
    self.legendFooter = nil;
    
    [self.gifFooter removeFromSuperview];
    self.gifFooter = nil;
}

static char MJRefreshGifFooterKey;
- (void)setGifFooter:(MJRefreshGifFooter *)gifFooter
{
    [self willChangeValueForKey:@"gifFooter"];
    objc_setAssociatedObject(self, &MJRefreshGifFooterKey,
                             gifFooter,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"gifFooter"];
}

- (MJRefreshGifFooter *)gifFooter
{
    return objc_getAssociatedObject(self, &MJRefreshGifFooterKey);
}

static char MJRefreshLegendFooterKey;
- (void)setLegendFooter:(MJRefreshLegendFooter *)legendFooter
{
    [self willChangeValueForKey:@"legendFooter"];
    objc_setAssociatedObject(self, &MJRefreshLegendFooterKey,
                             legendFooter,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"legendFooter"];
}

- (MJRefreshLegendFooter *)legendFooter
{
    return objc_getAssociatedObject(self, &MJRefreshLegendFooterKey);
}


- (MJRefreshFooter *)footer
{
    MJRefreshFooter *footer = self.legendFooter;
    return footer ? footer : self.gifFooter;
}

#pragma mark - swizzle
+ (void)load
{
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method method2 = class_getInstanceMethod([self class], @selector(deallocSwizzle));
    method_exchangeImplementations(method1, method2);
}

- (void)deallocSwizzle
{
    [self removeFooter];
    [self removeHeader];
    
    [self deallocSwizzle];
}

@end


#pragma mark - 1.0.0版本以前的接口
@implementation UIScrollView(MJRefreshDeprecated)
#pragma mark - 下拉刷新
/**
 *  添加一个下拉刷新头部控件
 *
 *  @param callback 回调
 */
- (void)addHeaderWithCallback:(void (^)())callback
{
    [self addHeaderWithCallback:callback dateKey:nil];
}

/**
 *  添加一个下拉刷新头部控件
 *
 *  @param callback 回调
 *  @param dateKey 刷新时间保存的key值
 */
- (void)addHeaderWithCallback:(void (^)())callback dateKey:(NSString*)dateKey
{
    [self addLegendHeader];
    self.header.dateKey = dateKey;
    self.header.refreshingBlock = callback;
}

/**
 *  添加一个下拉刷新头部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)addHeaderWithTarget:(id)target action:(SEL)action
{
    [self addHeaderWithTarget:target action:action dateKey:nil];
}

/**
 *  添加一个下拉刷新头部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 *  @param dateKey 刷新时间保存的key值
 */
- (void)addHeaderWithTarget:(id)target action:(SEL)action dateKey:(NSString*)dateKey
{
    [self addLegendHeader];
    self.header.dateKey = dateKey;
    [self.header setRefreshingTarget:target refreshingAction:action];
}

/**
 *  主动让下拉刷新头部控件进入刷新状态
 */
- (void)headerBeginRefreshing
{
    [self.header beginRefreshing];
}

/**
 *  让下拉刷新头部控件停止刷新状态
 */
- (void)headerEndRefreshing
{
    [self.header endRefreshing];
}

/**
 *  下拉刷新头部控件的可见性
 */
- (void)setHeaderHidden:(BOOL)headerHidden
{
    self.header.hidden = headerHidden;
}

- (BOOL)isHeaderHidden
{
    return self.header.isHidden;
}

/**
 *  是否正在下拉刷新
 */
- (BOOL)isHeaderRefreshing
{
    return self.header.isRefreshing;
}

#pragma mark - 上拉刷新
/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param callback 回调
 */
- (void)addFooterWithCallback:(void (^)())callback
{
    [self addLegendFooter];
    self.footer.refreshingBlock = callback;
}

/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)addFooterWithTarget:(id)target action:(SEL)action
{
    [self addLegendFooter];
    [self.footer setRefreshingTarget:target refreshingAction:action];
}

/**
 *  主动让上拉刷新尾部控件进入刷新状态
 */
- (void)footerBeginRefreshing
{
    [self.footer beginRefreshing];
}

/**
 *  让上拉刷新尾部控件停止刷新状态
 */
- (void)footerEndRefreshing
{
    [self.footer endRefreshing];
}

/**
 *  上拉刷新头部控件的可见性
 */
- (void)setFooterHidden:(BOOL)footerHidden
{
    self.footer.hidden = footerHidden;
}

- (BOOL)isFooterHidden
{
    return self.footer.isHidden;
}

/**
 *  是否正在上拉刷新
 */
- (BOOL)isFooterRefreshing
{
    return self.footer.isRefreshing;
}
@end
