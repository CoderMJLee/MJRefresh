//
//  UICollectionViewLayout+MJRefresh.m
//  MJRefreshExample
//
//  Created by jiasong on 2021/11/15.
//  Copyright © 2021 小码哥. All rights reserved.
//

#import "UICollectionViewLayout+MJRefresh.h"
#import "MJRefreshConst.h"
#import "MJRefreshFooter.h"

@implementation UICollectionViewLayout (MJRefresh)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        MJRefreshExchangeImplementationsInTwoClasses([self class], @selector(finalizeCollectionViewUpdates), [self class], @selector(mj_finalizeCollectionViewUpdates));
    });
}

- (void)mj_finalizeCollectionViewUpdates {
    __kindof MJRefreshFooter *footer = self.collectionView.mj_footer;
    if (footer != nil && footer.isRefreshing) {
        NSDictionary *changed = @{
            NSKeyValueChangeNewKey: [NSValue valueWithCGSize:self.collectionViewContentSize],
            NSKeyValueChangeOldKey: [NSValue valueWithCGSize:self.collectionView.contentSize],
        };
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        [footer scrollViewContentSizeDidChange:changed];
        [CATransaction commit];
    }
}

@end
