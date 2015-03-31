//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
#import <UIKit/UIKit.h>

const CGFloat MJRefreshHeaderHeight = 54.0;
const CGFloat MJRefreshFooterHeight = 44.0;
const CGFloat MJRefreshFastAnimationDuration = 0.25;
const CGFloat MJRefreshSlowAnimationDuration = 0.4;

NSString *const MJRefreshHeaderUpdatedTimeKey = @"MJRefreshHeaderUpdatedTimeKey";
NSString *const MJRefreshContentOffset = @"contentOffset";
NSString *const MJRefreshContentSize = @"contentSize";
NSString *const MJRefreshPanState = @"pan.state";

NSString *const MJRefreshHeaderStateIdleText = @"下拉可以刷新";
NSString *const MJRefreshHeaderStatePullingText = @"松开立即刷新";
NSString *const MJRefreshHeaderStateRefreshingText = @"正在刷新数据中...";

NSString *const MJRefreshFooterStateIdleText = @"点击加载更多";
NSString *const MJRefreshFooterStateRefreshingText = @"正在加载更多的数据...";
NSString *const MJRefreshFooterStateNoMoreDataText = @"已经全部加载完毕";