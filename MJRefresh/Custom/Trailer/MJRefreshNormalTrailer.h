//
//  MJRefreshNormalTrailer.h
//  MJRefresh
//
//  Created by kinarobin on 2020/5/3.
//  Copyright © 2020 小码哥. All rights reserved.
//

#if __has_include(<MJRefresh/MJRefreshStateTrailer.h>)
#import <MJRefresh/MJRefreshStateTrailer.h>
#else
#import "MJRefreshStateTrailer.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface MJRefreshNormalTrailer : MJRefreshStateTrailer

@property (weak, nonatomic, readonly) UIImageView *arrowView;

@end

NS_ASSUME_NONNULL_END
