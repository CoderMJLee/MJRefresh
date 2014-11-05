//
//  MJRefreshConst.h
//  MJRefresh
//
//  Created by mj on 14-1-3.
//  Copyright (c) 2014年 itcast. All rights reserved.
//
#import <UIKit/UIKit.h>

#ifdef DEBUG
#define MJLog(...) NSLog(__VA_ARGS__)
#else
#define MJLog(...)
#endif

// objc_msgSend
#define msgSend(...) ((void (*)(void *, SEL, UIView *))objc_msgSend)(__VA_ARGS__)
#define msgTarget(target) (__bridge void *)(target)

#define MJColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 文字颜色
#define MJRefreshLabelTextColor MJColor(150, 150, 150)

// 图片路径
#define MJRefreshSrcName(file) [@"MJRefresh.bundle" stringByAppendingPathComponent:file]

UIKIT_EXTERN const CGFloat MJRefreshViewHeight;
UIKIT_EXTERN const CGFloat MJRefreshFastAnimationDuration;
UIKIT_EXTERN const CGFloat MJRefreshSlowAnimationDuration;

UIKIT_EXTERN NSString *const MJRefreshFooterPullToRefresh;
UIKIT_EXTERN NSString *const MJRefreshFooterReleaseToRefresh;
UIKIT_EXTERN NSString *const MJRefreshFooterRefreshing;

UIKIT_EXTERN NSString *const MJRefreshHeaderPullToRefresh;
UIKIT_EXTERN NSString *const MJRefreshHeaderReleaseToRefresh;
UIKIT_EXTERN NSString *const MJRefreshHeaderRefreshing;
UIKIT_EXTERN NSString *const MJRefreshHeaderTimeKey;

UIKIT_EXTERN NSString *const MJRefreshContentOffset;
extern NSString *const MJRefreshContentSize;