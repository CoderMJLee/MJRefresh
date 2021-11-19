//  代码地址: https://github.com/CoderMJLee/MJRefresh

#import <Foundation/Foundation.h>

#if __has_include(<MJRefresh/MJRefresh.h>)
FOUNDATION_EXPORT double MJRefreshVersionNumber;
FOUNDATION_EXPORT const unsigned char MJRefreshVersionString[];

#import <MJRefresh/UIScrollView+MJRefresh.h>
#import <MJRefresh/UIScrollView+MJExtension.h>
#import <MJRefresh/UIView+MJExtension.h>

#import <MJRefresh/MJRefreshNormalHeader.h>
#import <MJRefresh/MJRefreshGifHeader.h>

#import <MJRefresh/MJRefreshBackNormalFooter.h>
#import <MJRefresh/MJRefreshBackGifFooter.h>
#import <MJRefresh/MJRefreshAutoNormalFooter.h>
#import <MJRefresh/MJRefreshAutoGifFooter.h>

#import <MJRefresh/MJRefreshNormalTrailer.h>
#import <MJRefresh/MJRefreshConfig.h>
#import <MJRefresh/NSBundle+MJRefresh.h>
#import <MJRefresh/MJRefreshConst.h>
#else
#import "UIScrollView+MJRefresh.h"
#import "UIScrollView+MJExtension.h"
#import "UIView+MJExtension.h"

#import "MJRefreshNormalHeader.h"
#import "MJRefreshGifHeader.h"

#import "MJRefreshBackNormalFooter.h"
#import "MJRefreshBackGifFooter.h"
#import "MJRefreshAutoNormalFooter.h"
#import "MJRefreshAutoGifFooter.h"

#import "MJRefreshNormalTrailer.h"
#import "MJRefreshConfig.h"
#import "NSBundle+MJRefresh.h"
#import "MJRefreshConst.h"
#endif
