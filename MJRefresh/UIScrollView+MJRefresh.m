//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  UIScrollView+MJRefresh.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/4.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "UIScrollView+MJRefresh.h"
#import "MJRefreshHeader.h"
#import "MJRefreshFooter.h"
#import <objc/runtime.h>

@implementation NSObject (MJRefresh)

+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}

+ (void)exchangeClassMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getClassMethod(self, method1), class_getClassMethod(self, method2));
}

@end

@implementation UIScrollView (MJRefresh)

#pragma mark - header
static const char MJRefreshHeaderKey = '\0';
- (void)setHeader:(MJRefreshHeader *)header
{
    if (header != self.header) {
        // 删除旧的，添加新的
        [self.header removeFromSuperview];
        [self addSubview:header];
        
        // 存储新的
        [self willChangeValueForKey:@"header"]; // KVO
        objc_setAssociatedObject(self, &MJRefreshHeaderKey,
                                 header, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"header"]; // KVO
    }
}

- (MJRefreshHeader *)header
{
    return objc_getAssociatedObject(self, &MJRefreshHeaderKey);
}

#pragma mark - footer
static const char MJRefreshFooterKey = '\0';
- (void)setFooter:(MJRefreshFooter *)footer
{
    if (footer != self.footer) {
        // 删除旧的，添加新的
        [self.footer removeFromSuperview];
        [self addSubview:footer];
        
        // 存储新的
        [self willChangeValueForKey:@"footer"]; // KVO
        objc_setAssociatedObject(self, &MJRefreshFooterKey,
                                 footer, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"footer"]; // KVO
    }
}

- (MJRefreshFooter *)footer
{
    return objc_getAssociatedObject(self, &MJRefreshFooterKey);
}

#pragma mark - other
- (NSInteger)totalDataCount
{
    NSInteger totalCount = 0;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        
        for (NSInteger section = 0; section<tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        
        for (NSInteger section = 0; section<collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
}

static const char MJRefreshReloadDataBlockKey = '\0';
- (void)setReloadDataBlock:(void (^)(NSInteger))reloadDataBlock
{
    [self willChangeValueForKey:@"reloadDataBlock"]; // KVO
    objc_setAssociatedObject(self, &MJRefreshReloadDataBlockKey, reloadDataBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"reloadDataBlock"]; // KVO
}

- (void (^)(NSInteger))reloadDataBlock
{
    return objc_getAssociatedObject(self, &MJRefreshReloadDataBlockKey);
}

- (void)executeReloadDataBlock
{
    !self.reloadDataBlock ? : self.reloadDataBlock(self.totalDataCount);
}
@end

@implementation UITableView (MJRefresh)

+ (void)load
{
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(mj_reloadData)];
    [self exchangeInstanceMethod1:@selector(reloadRowsAtIndexPaths:withRowAnimation:) method2:@selector(mj_reloadRowsAtIndexPaths:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(deleteRowsAtIndexPaths:withRowAnimation:) method2:@selector(mj_deleteRowsAtIndexPaths:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(insertRowsAtIndexPaths:withRowAnimation:) method2:@selector(mj_insertRowsAtIndexPaths:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(reloadSections:withRowAnimation:) method2:@selector(mj_reloadSections:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(deleteSections:withRowAnimation:) method2:@selector(mj_deleteSections:withRowAnimation:)];
    [self exchangeInstanceMethod1:@selector(insertSections:withRowAnimation:) method2:@selector(mj_insertSections:withRowAnimation:)];
}

- (void)mj_reloadData
{
    [self mj_reloadData];
    
    [self executeReloadDataBlock];
}

- (void)mj_insertRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    [self mj_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    
    [self executeReloadDataBlock];
}

- (void)mj_deleteRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    [self mj_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    
    [self executeReloadDataBlock];
}

- (void)mj_reloadRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    [self mj_reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    
    [self executeReloadDataBlock];
}

- (void)mj_insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation
{
    [self mj_insertSections:sections withRowAnimation:animation];
    
    [self executeReloadDataBlock];
}

- (void)mj_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation
{
    [self mj_deleteSections:sections withRowAnimation:animation];
    
    [self executeReloadDataBlock];
}

- (void)mj_reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation
{
    [self mj_reloadSections:sections withRowAnimation:animation];
    
    [self executeReloadDataBlock];
}
@end

@implementation UICollectionView (MJRefresh)

+ (void)load
{
    [self exchangeInstanceMethod1:@selector(reloadData) method2:@selector(mj_reloadData)];
    [self exchangeInstanceMethod1:@selector(reloadItemsAtIndexPaths:) method2:@selector(mj_reloadItemsAtIndexPaths:)];
    [self exchangeInstanceMethod1:@selector(insertItemsAtIndexPaths:) method2:@selector(mj_insertItemsAtIndexPaths:)];
    [self exchangeInstanceMethod1:@selector(deleteItemsAtIndexPaths:) method2:@selector(mj_deleteItemsAtIndexPaths:)];
    [self exchangeInstanceMethod1:@selector(reloadSections:) method2:@selector(mj_reloadSections:)];
    [self exchangeInstanceMethod1:@selector(insertSections:) method2:@selector(mj_insertSections:)];
    [self exchangeInstanceMethod1:@selector(deleteSections:) method2:@selector(mj_deleteSections:)];
}

- (void)mj_reloadData
{
    [self mj_reloadData];
    
    [self executeReloadDataBlock];
}

- (void)mj_insertSections:(NSIndexSet *)sections
{
    [self mj_insertSections:sections];
    
    [self executeReloadDataBlock];
}

- (void)mj_deleteSections:(NSIndexSet *)sections
{
    [self mj_deleteSections:sections];
    
    [self executeReloadDataBlock];
}

- (void)mj_reloadSections:(NSIndexSet *)sections
{
    [self mj_reloadSections:sections];
    
    [self executeReloadDataBlock];
}

- (void)mj_insertItemsAtIndexPaths:(NSArray *)indexPaths
{
    [self mj_insertItemsAtIndexPaths:indexPaths];
    
    [self executeReloadDataBlock];
}

- (void)mj_deleteItemsAtIndexPaths:(NSArray *)indexPaths
{
    [self mj_deleteItemsAtIndexPaths:indexPaths];
    
    [self executeReloadDataBlock];
}

- (void)mj_reloadItemsAtIndexPaths:(NSArray *)indexPaths
{
    [self mj_reloadItemsAtIndexPaths:indexPaths];
    
    [self executeReloadDataBlock];
}
@end
