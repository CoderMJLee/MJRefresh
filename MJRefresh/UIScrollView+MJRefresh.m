//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  UIScrollView+MJRefresh.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/4.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "UIScrollView+MJRefresh.h"
#import "MJRefreshHeader.h"
#import "MJRefreshFooter.h"
#import "MJRefreshTrailer.h"
#import <objc/runtime.h>

@implementation UIScrollView (MJRefresh)

#pragma mark - header
static const char MJRefreshHeaderKey = '\0';
- (void)setMj_header:(MJRefreshHeader *)mj_header
{
    if (mj_header != self.mj_header) {
        // 删除旧的，添加新的
        [self.mj_header removeFromSuperview];
        
        if (mj_header) {
            [self insertSubview:mj_header atIndex:0];
        }
        // 存储新的
        objc_setAssociatedObject(self, &MJRefreshHeaderKey,
                                 mj_header, OBJC_ASSOCIATION_RETAIN);
    }
}

- (MJRefreshHeader *)mj_header
{
    return objc_getAssociatedObject(self, &MJRefreshHeaderKey);
}

#pragma mark - footer
static const char MJRefreshFooterKey = '\0';
- (void)setMj_footer:(MJRefreshFooter *)mj_footer
{
    if (mj_footer != self.mj_footer) {
        // 删除旧的，添加新的
        [self.mj_footer removeFromSuperview];
        if (mj_footer) {
            [self insertSubview:mj_footer atIndex:0];
        }
        // 存储新的
        objc_setAssociatedObject(self, &MJRefreshFooterKey,
                                 mj_footer, OBJC_ASSOCIATION_RETAIN);
    }
}

- (MJRefreshFooter *)mj_footer
{
    return objc_getAssociatedObject(self, &MJRefreshFooterKey);
}

#pragma mark - footer
static const char MJRefreshTrailerKey = '\0';
- (void)setMj_trailer:(MJRefreshTrailer *)mj_trailer {
    if (mj_trailer != self.mj_trailer) {
        // 删除旧的，添加新的
        [self.mj_trailer removeFromSuperview];
        if (mj_trailer) {
            [self insertSubview:mj_trailer atIndex:0];
        }
        // 存储新的
        objc_setAssociatedObject(self, &MJRefreshTrailerKey,
                                 mj_trailer, OBJC_ASSOCIATION_RETAIN);
    }
}

- (MJRefreshTrailer *)mj_trailer {
    return objc_getAssociatedObject(self, &MJRefreshTrailerKey);
}

#pragma mark - 过期
- (void)setFooter:(MJRefreshFooter *)footer
{
    self.mj_footer = footer;
}

- (MJRefreshFooter *)footer
{
    return self.mj_footer;
}

- (void)setHeader:(MJRefreshHeader *)header
{
    self.mj_header = header;
}

- (MJRefreshHeader *)header
{
    return self.mj_header;
}

#pragma mark - other
- (NSInteger)mj_totalDataCount
{
    NSInteger totalCount = 0;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;

        for (NSInteger section = 0; section < tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;

        for (NSInteger section = 0; section < collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
}

@end
