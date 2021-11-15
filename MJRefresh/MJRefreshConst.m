//  代码地址: https://github.com/CoderMJLee/MJRefresh
#import <UIKit/UIKit.h>

const CGFloat MJRefreshLabelLeftInset = 25;
const CGFloat MJRefreshHeaderHeight = 54.0;
const CGFloat MJRefreshFooterHeight = 44.0;
const CGFloat MJRefreshTrailWidth = 60.0;
const CGFloat MJRefreshFastAnimationDuration = 0.25;
const CGFloat MJRefreshSlowAnimationDuration = 0.4;


NSString *const MJRefreshKeyPathContentOffset = @"contentOffset";
NSString *const MJRefreshKeyPathContentInset = @"contentInset";
NSString *const MJRefreshKeyPathContentSize = @"contentSize";
NSString *const MJRefreshKeyPathPanState = @"state";

NSString *const MJRefreshHeaderLastUpdatedTimeKey = @"MJRefreshHeaderLastUpdatedTimeKey";

NSString *const MJRefreshHeaderIdleText = @"MJRefreshHeaderIdleText";
NSString *const MJRefreshHeaderPullingText = @"MJRefreshHeaderPullingText";
NSString *const MJRefreshHeaderRefreshingText = @"MJRefreshHeaderRefreshingText";

NSString *const MJRefreshTrailerIdleText = @"MJRefreshTrailerIdleText";
NSString *const MJRefreshTrailerPullingText = @"MJRefreshTrailerPullingText";

NSString *const MJRefreshAutoFooterIdleText = @"MJRefreshAutoFooterIdleText";
NSString *const MJRefreshAutoFooterRefreshingText = @"MJRefreshAutoFooterRefreshingText";
NSString *const MJRefreshAutoFooterNoMoreDataText = @"MJRefreshAutoFooterNoMoreDataText";

NSString *const MJRefreshBackFooterIdleText = @"MJRefreshBackFooterIdleText";
NSString *const MJRefreshBackFooterPullingText = @"MJRefreshBackFooterPullingText";
NSString *const MJRefreshBackFooterRefreshingText = @"MJRefreshBackFooterRefreshingText";
NSString *const MJRefreshBackFooterNoMoreDataText = @"MJRefreshBackFooterNoMoreDataText";

NSString *const MJRefreshHeaderLastTimeText = @"MJRefreshHeaderLastTimeText";
NSString *const MJRefreshHeaderDateTodayText = @"MJRefreshHeaderDateTodayText";
NSString *const MJRefreshHeaderNoneLastDateText = @"MJRefreshHeaderNoneLastDateText";

NSString *const MJRefreshDidChangeLanguageNotification = @"MJRefreshDidChangeLanguageNotification";
