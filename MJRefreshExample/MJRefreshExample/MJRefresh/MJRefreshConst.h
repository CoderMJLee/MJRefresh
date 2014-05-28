//
//  MJRefreshConst.h
//  MJRefresh
//
//  Created by mj on 14-1-3.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#ifdef DEBUG
#define MJLog(...) NSLog(__VA_ARGS__)
#else
#define MJLog(...)
#endif

#define MJColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 文字颜色
#define MJRefreshLabelTextColor MJColor(150, 150, 150)

extern const CGFloat MJRefreshViewHeight;
extern const CGFloat MJRefreshFastAnimationDuration;
extern const CGFloat MJRefreshSlowAnimationDuration;

extern NSString *const MJRefreshBundleName;
#define MJRefreshSrcName(file) [MJRefreshBundleName stringByAppendingPathComponent:file]

extern NSString *const MJRefreshFooterPullToRefresh;
extern NSString *const MJRefreshFooterReleaseToRefresh;
extern NSString *const MJRefreshFooterRefreshing;

extern NSString *const MJRefreshHeaderPullToRefresh;
extern NSString *const MJRefreshHeaderReleaseToRefresh;
extern NSString *const MJRefreshHeaderRefreshing;
extern NSString *const MJRefreshHeaderTimeKey;

extern NSString *const MJRefreshContentOffset;
extern NSString *const MJRefreshContentSize;