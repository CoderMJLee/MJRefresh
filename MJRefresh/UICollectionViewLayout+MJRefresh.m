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
    [self mj_finalizeCollectionViewUpdates];
    
    __kindof MJRefreshFooter *footer = self.collectionView.mj_footer;
    CGSize newSize = self.collectionViewContentSize;
    CGSize oldSize = self.collectionView.contentSize;
    if (footer != nil && !CGSizeEqualToSize(newSize, oldSize)) {
        NSDictionary *changed = @{
            NSKeyValueChangeNewKey: [NSValue valueWithCGSize:newSize],
            NSKeyValueChangeOldKey: [NSValue valueWithCGSize:oldSize],
        };
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        [footer scrollViewContentSizeDidChange:changed];
        [CATransaction commit];
    }
}

@end
