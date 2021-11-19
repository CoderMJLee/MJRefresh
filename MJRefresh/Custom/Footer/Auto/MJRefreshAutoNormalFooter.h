//
//  MJRefreshAutoNormalFooter.h
//  MJRefresh
//
//  Created by MJ Lee on 15/4/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#if __has_include(<MJRefresh/MJRefreshAutoStateFooter.h>)
#import <MJRefresh/MJRefreshAutoStateFooter.h>
#else
#import "MJRefreshAutoStateFooter.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface MJRefreshAutoNormalFooter : MJRefreshAutoStateFooter
@property (weak, nonatomic, readonly) UIActivityIndicatorView *loadingView;

/** 菊花的样式 */
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle MJRefreshDeprecated("first deprecated in 3.2.2 - Use `loadingView` property");
@end


NS_ASSUME_NONNULL_END
