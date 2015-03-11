//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
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
- (MJRefreshLegendHeader *)addLegendHeaderWithRefreshingBlock:(void (^)())block dateKey:(NSString *)dateKey
{
    MJRefreshLegendHeader *header = [self addLegendHeader];
    header.refreshingBlock = block;
    header.dateKey = dateKey;
    return header;
}

- (MJRefreshLegendHeader *)addLegendHeaderWithRefreshingTarget:(id)target refreshingAction:(SEL)action dateKey:(NSString *)dateKey
{
    MJRefreshLegendHeader *header = [self addLegendHeader];
    header.refreshingTarget = target;
    header.refreshingAction = action;
    header.dateKey = dateKey;
    return header;
}

- (MJRefreshLegendHeader *)addLegendHeaderWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    return [self addLegendHeaderWithRefreshingTarget:target refreshingAction:action dateKey:nil];
}

- (MJRefreshLegendHeader *)addLegendHeaderWithRefreshingBlock:(void (^)())block
{
    return [self addLegendHeaderWithRefreshingBlock:block dateKey:nil];
}

- (MJRefreshLegendHeader *)addLegendHeader
{
    MJRefreshLegendHeader *header = [[MJRefreshLegendHeader alloc] init];
    self.header = header;
    
    return header;
}

- (MJRefreshGifHeader *)addGifHeaderWithRefreshingBlock:(void (^)())block dateKey:(NSString *)dateKey
{
    MJRefreshGifHeader *header = [self addGifHeader];
    header.refreshingBlock = block;
    header.dateKey = dateKey;
    return header;
}

- (MJRefreshGifHeader *)addGifHeaderWithRefreshingTarget:(id)target refreshingAction:(SEL)action dateKey:(NSString *)dateKey
{
    MJRefreshGifHeader *header = [self addGifHeader];
    header.refreshingTarget = target;
    header.refreshingAction = action;
    header.dateKey = dateKey;
    return header;
}

- (MJRefreshGifHeader *)addGifHeaderWithRefreshingBlock:(void (^)())block
{
    return [self addGifHeaderWithRefreshingBlock:block dateKey:nil];
}

- (MJRefreshGifHeader *)addGifHeaderWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    return [self addGifHeaderWithRefreshingTarget:target refreshingAction:action dateKey:nil];
}

- (MJRefreshGifHeader *)addGifHeader
{
    MJRefreshGifHeader *header = [[MJRefreshGifHeader alloc] init];
    self.header = header;
    
    return header;
}

- (void)removeHeader
{
    self.header = nil;
}

#pragma mark - Property Methods
#pragma mark gifHeader
- (MJRefreshGifHeader *)gifHeader
{
    if ([self.header isKindOfClass:[MJRefreshGifHeader class]]) {
        return (MJRefreshGifHeader *)self.header;
    }
    
    return nil;
}

#pragma mark legendHeader
- (MJRefreshLegendHeader *)legendHeader
{
    if ([self.header isKindOfClass:[MJRefreshLegendHeader class]]) {
        return (MJRefreshLegendHeader *)self.header;
    }
    
    return nil;
}

#pragma mark header
static char MJRefreshHeaderKey;
- (void)setHeader:(MJRefreshHeader *)header
{
    if (header != self.header) {
        [self.header removeFromSuperview];
        
        [self willChangeValueForKey:@"header"];
        objc_setAssociatedObject(self, &MJRefreshHeaderKey,
                                 header,
                                 OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"header"];
        
        [self addSubview:header];
    }
}

- (MJRefreshHeader *)header
{
    return objc_getAssociatedObject(self, &MJRefreshHeaderKey);
}

#pragma mark - 上拉刷新
- (MJRefreshLegendFooter *)addLegendFooterWithRefreshingBlock:(void (^)())block
{
    MJRefreshLegendFooter *footer = [self addLegendFooter];
    footer.refreshingBlock = block;
    return footer;
}

- (MJRefreshLegendFooter *)addLegendFooterWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    MJRefreshLegendFooter *footer = [self addLegendFooter];
    footer.refreshingTarget = target;
    footer.refreshingAction = action;
    return footer;
}

- (MJRefreshLegendFooter *)addLegendFooter
{
    MJRefreshLegendFooter *footer = [[MJRefreshLegendFooter alloc] init];
    self.footer = footer;
    
    return footer;
}

- (MJRefreshGifFooter *)addGifFooterWithRefreshingBlock:(void (^)())block
{
    MJRefreshGifFooter *footer = [self addGifFooter];
    footer.refreshingBlock = block;
    return footer;
}

- (MJRefreshGifFooter *)addGifFooterWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    MJRefreshGifFooter *footer = [self addGifFooter];
    footer.refreshingTarget = target;
    footer.refreshingAction = action;
    return footer;
}

- (MJRefreshGifFooter *)addGifFooter
{
    MJRefreshGifFooter *footer = [[MJRefreshGifFooter alloc] init];
    self.footer = footer;
    
    return footer;
}

- (void)removeFooter
{
    self.footer = nil;
}

static char MJRefreshFooterKey;
- (void)setFooter:(MJRefreshFooter *)footer
{
    if (footer != self.footer) {
        [self.footer removeFromSuperview];
        
        [self willChangeValueForKey:@"footer"];
        objc_setAssociatedObject(self, &MJRefreshFooterKey,
                                 footer,
                                 OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"footer"];
        
        [self addSubview:footer];
    }
}

- (MJRefreshGifFooter *)gifFooter
{
    if ([self.footer isKindOfClass:[MJRefreshGifFooter class]]) {
        return (MJRefreshGifFooter *)self.footer;
    }
    return nil;
}

- (MJRefreshLegendFooter *)legendFooter
{
    if ([self.footer isKindOfClass:[MJRefreshLegendFooter class]]) {
        return (MJRefreshLegendFooter *)self.footer;
    }
    return nil;
}


- (MJRefreshFooter *)footer
{
    return objc_getAssociatedObject(self, &MJRefreshFooterKey);
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
