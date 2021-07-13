//  代码地址: https://github.com/CoderMJLee/MJRefresh
#import <UIKit/UIKit.h>
#import <objc/message.h>

// 弱引用
#define MJWeakSelf __weak typeof(self) weakSelf = self;

// 日志输出
#ifdef DEBUG
#define MJRefreshLog(...) NSLog(__VA_ARGS__)
#else
#define MJRefreshLog(...)
#endif

// 过期提醒
#define MJRefreshDeprecated(DESCRIPTION) __attribute__((deprecated(DESCRIPTION)))

// 运行时objc_msgSend
#define MJRefreshMsgSend(...) ((void (*)(void *, SEL, UIView *))objc_msgSend)(__VA_ARGS__)
#define MJRefreshMsgTarget(target) (__bridge void *)(target)

// RGB颜色
#define MJRefreshColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 文字颜色
#define MJRefreshLabelTextColor MJRefreshColor(90, 90, 90)

// 字体大小
#define MJRefreshLabelFont [UIFont boldSystemFontOfSize:14]

// 常量
UIKIT_EXTERN const CGFloat MJRefreshLabelLeftInset;
UIKIT_EXTERN const CGFloat MJRefreshHeaderHeight;
UIKIT_EXTERN const CGFloat MJRefreshFooterHeight;
UIKIT_EXTERN const CGFloat MJRefreshTrailWidth;
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

UIKIT_EXTERN NSString *const MJRefreshTrailerIdleText;
UIKIT_EXTERN NSString *const MJRefreshTrailerPullingText;

UIKIT_EXTERN NSString *const MJRefreshAutoFooterIdleText;
UIKIT_EXTERN NSString *const MJRefreshAutoFooterRefreshingText;
UIKIT_EXTERN NSString *const MJRefreshAutoFooterNoMoreDataText;

UIKIT_EXTERN NSString *const MJRefreshBackFooterIdleText;
UIKIT_EXTERN NSString *const MJRefreshBackFooterPullingText;
UIKIT_EXTERN NSString *const MJRefreshBackFooterRefreshingText;
UIKIT_EXTERN NSString *const MJRefreshBackFooterNoMoreDataText;

UIKIT_EXTERN NSString *const MJRefreshHeaderLastTimeText;
UIKIT_EXTERN NSString *const MJRefreshHeaderDateTodayText;
UIKIT_EXTERN NSString *const MJRefreshHeaderNoneLastDateText;

UIKIT_EXTERN NSString *const MJRefreshDidChangeLanguageNotification;

// 状态检查
#define MJRefreshCheckState \
MJRefreshState oldState = self.state; \
if (state == oldState) return; \
[super setState:state];

// 异步主线程执行，不强持有Self
#define MJRefreshDispatchAsyncOnMainQueue(x) \
__weak typeof(self) weakSelf = self; \
dispatch_async(dispatch_get_main_queue(), ^{ \
typeof(weakSelf) self = weakSelf; \
{x} \
});
