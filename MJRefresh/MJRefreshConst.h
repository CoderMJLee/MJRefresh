//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
#import <UIKit/UIKit.h>
#import <objc/message.h>

// 日志输出
#ifdef DEBUG
#define MJLog(...) NSLog(__VA_ARGS__)
#else
#define MJLog(...)
#endif

#define iOS(version) ([[UIDevice currentDevice].systemVersion doubleValue] >= version)

// 过期提醒
#define MJDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

// 运行时objc_msgSend
#define msgSend(...) ((void (*)(void *, SEL, UIView *))objc_msgSend)(__VA_ARGS__)
#define msgTarget(target) (__bridge void *)(target)

// RGB颜色
#define MJColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 文字颜色
#define MJRefreshLabelTextColor MJColor(90, 90, 90)

// 字体大小
#define MJRefreshLabelFont [UIFont boldSystemFontOfSize:14]

// 图片路径
#define MJRefreshSrcName(file) [@"MJRefresh.bundle" stringByAppendingPathComponent:file]

// 常量
UIKIT_EXTERN const CGFloat MJRefreshHeaderHeight;
UIKIT_EXTERN const CGFloat MJRefreshFooterHeight;
UIKIT_EXTERN const CGFloat MJRefreshFastAnimationDuration;
UIKIT_EXTERN const CGFloat MJRefreshSlowAnimationDuration;

UIKIT_EXTERN NSString *const MJRefreshKeyPathContentOffset;
UIKIT_EXTERN NSString *const MJRefreshKeyPathContentSize;
UIKIT_EXTERN NSString *const MJRefreshKeyPathContentInset;
UIKIT_EXTERN NSString *const MJRefreshKeyPathPanState;

UIKIT_EXTERN NSString *const MJRefreshHeaderLastUpdatedTimeKey;

UIKIT_EXTERN NSString *const MJRefreshHeaderIdleText;
UIKIT_EXTERN NSString *const MJRefreshHeaderPullingText;
UIKIT_EXTERN NSString *const MJRefreshHeaderRefreshingText;

UIKIT_EXTERN NSString *const MJRefreshAutoFooterIdleText;
UIKIT_EXTERN NSString *const MJRefreshAutoFooterRefreshingText;
UIKIT_EXTERN NSString *const MJRefreshAutoFooterNoMoreDataText;

UIKIT_EXTERN NSString *const MJRefreshBackFooterIdleText;
UIKIT_EXTERN NSString *const MJRefreshBackFooterPullingText;
UIKIT_EXTERN NSString *const MJRefreshBackFooterRefreshingText;
UIKIT_EXTERN NSString *const MJRefreshBackFooterNoMoreDataText;

// 状态检查
#define MJRefreshCheckState \
MJRefreshState oldState = self.state; \
if (state == oldState) return; \
[super setState:state];
