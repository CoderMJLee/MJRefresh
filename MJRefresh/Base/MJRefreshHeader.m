//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  MJRefreshHeader.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/4.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJRefreshHeader.h"
#import "UIView+GHUIViewController.h"

@interface MJRefreshHeader()
@property (assign, nonatomic) CGFloat insetTDelta;
@end

@implementation MJRefreshHeader
// fix https://github.com/CoderMJLee/MJRefresh/issues/1267
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    /// 父控件的控制器
    if ([self.scrollView viewController] == nil) {
        return ;
    }
    
    /// 状态栏的高度
    CGFloat rectStatusHeight = 0;
    if ([[UIApplication sharedApplication] isStatusBarHidden]) {
        rectStatusHeight = 0;
    } else {
        rectStatusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    }
    
    /// 导航栏的高度
    CGFloat navigationBarHeight = 0;
    if (self.scrollView.viewController.navigationController.navigationBar.hidden) {
        navigationBarHeight = 0;
    } else {
        navigationBarHeight = [self.superview viewController].navigationController.navigationBar.frame.size.height;
    }
    
    /// 竖直方向的偏移量
    CGFloat scrollViewContentOffsetY = (rectStatusHeight + navigationBarHeight);
    // 对应使用继承UITableViewController或者UICollectionViewController并且没有重写lauoutSubview修改默认的tableView或collectionView的Frame的情况
    if (([[self.superview viewController] isKindOfClass: [UITableViewController class]] || [[self.superview viewController] isKindOfClass: [UICollectionViewController class]]) && self.scrollView.frame.origin.y == 0) {

        switch (self.state) {
            // 默认状态
            case MJRefreshStateIdle: {
                [UIView animateWithDuration: MJRefreshSlowAnimationDuration animations:^{
                    [self setScrollView:self.scrollView contentInset: UIEdgeInsetsMake(0, 0, 0, 0) contentOffset: CGPointMake(0, -scrollViewContentOffsetY)];
                }];
            }
                break;
            // 刷新中的状态
            case MJRefreshStateRefreshing: {
                [self setScrollView:self.scrollView contentInset: UIEdgeInsetsMake(MJRefreshHeaderHeight, 0, 0, 0) contentOffset: CGPointMake(0, -(MJRefreshHeaderHeight + scrollViewContentOffsetY))];
            }
                break;
            default:
                break;
        }
    } else {
        // 对应使用继承ViewController并且使用自定义的tableView并且使用Frame坐标
        // 如果Y大于等于导航栏加状态栏, MJ坐标计算正常
        if (!(self.scrollView.frame.origin.y < scrollViewContentOffsetY)) {
            return ;
        } else {
            // 使用自定义TableView, 如果TableView的Y值小于scrollViewContentOffsetY,系统需要保证UI正常显示,所以会改变TableView的初始contentOffSet,然后导致MJ坐标计算错误.
            // 当外界设置了错误的坐标,我们需要对Frame.origin.y的坐标进行修正(保证contentOffSet的正确),而不是使用contentOffSet修正
            CGRect temRect = CGRectMake(self.scrollView.frame.origin.x, scrollViewContentOffsetY, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
            self.scrollView.frame = temRect;
        }
    }
}

// MARK: - 设置父控件的contentInset和contentOffset
/**
 设置父控件的contentInset和contentOffset
 
 @param scrollView 父控件
 @param contentInset contentInset
 @param contentOffset contentOffset
 */
- (void)setScrollView:(UIScrollView *)scrollView contentInset:(UIEdgeInsets)contentInset contentOffset:(CGPoint) contentOffset{
    scrollView.contentInset = contentInset;
    scrollView.contentOffset = contentOffset;
}

#pragma mark - 构造方法
+ (instancetype)headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock
{
    MJRefreshHeader *cmp = [[self alloc] init];
    cmp.refreshingBlock = refreshingBlock;
    return cmp;
}
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    MJRefreshHeader *cmp = [[self alloc] init];
    [cmp setRefreshingTarget:target refreshingAction:action];
    return cmp;
}

#pragma mark - 覆盖父类的方法
- (void)prepare
{
    [super prepare];
    
    // 设置key
    self.lastUpdatedTimeKey = MJRefreshHeaderLastUpdatedTimeKey;
    
    // 设置高度
    self.mj_h = MJRefreshHeaderHeight;
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    // 设置y值(当自己的高度发生改变了，肯定要重新调整Y值，所以放到placeSubviews方法中设置y值)
    self.mj_y = - self.mj_h - self.ignoredScrollViewContentInsetTop;
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
    // 在刷新的refreshing状态
    if (self.state == MJRefreshStateRefreshing) {
        // 暂时保留
        if (self.window == nil) return;
        
        // sectionheader停留解决
        CGFloat insetT = - self.scrollView.mj_offsetY > _scrollViewOriginalInset.top ? - self.scrollView.mj_offsetY : _scrollViewOriginalInset.top;
        insetT = insetT > self.mj_h + _scrollViewOriginalInset.top ? self.mj_h + _scrollViewOriginalInset.top : insetT;
        self.scrollView.mj_insetT = insetT;
        
        self.insetTDelta = _scrollViewOriginalInset.top - insetT;
        return;
    }
    
    // 跳转到下一个控制器时，contentInset可能会变
    _scrollViewOriginalInset = self.scrollView.mj_inset;
    
    // 当前的contentOffset
    CGFloat offsetY = self.scrollView.mj_offsetY;
    // 头部控件刚好出现的offsetY
    CGFloat happenOffsetY = - self.scrollViewOriginalInset.top;
    
    // 如果是向上滚动到看不见头部控件，直接返回
    // >= -> >
    if (offsetY > happenOffsetY) return;
    
    // 普通 和 即将刷新 的临界点
    CGFloat normal2pullingOffsetY = happenOffsetY - self.mj_h;
    CGFloat pullingPercent = (happenOffsetY - offsetY) / self.mj_h;
    
    if (self.scrollView.isDragging) { // 如果正在拖拽
        self.pullingPercent = pullingPercent;
        if (self.state == MJRefreshStateIdle && offsetY < normal2pullingOffsetY) {
            // 转为即将刷新状态
            self.state = MJRefreshStatePulling;
        } else if (self.state == MJRefreshStatePulling && offsetY >= normal2pullingOffsetY) {
            // 转为普通状态
            self.state = MJRefreshStateIdle;
        }
    } else if (self.state == MJRefreshStatePulling) {// 即将刷新 && 手松开
        // 开始刷新
        
        [self beginRefreshing];
    
    } else if (pullingPercent < 1) {
        self.pullingPercent = pullingPercent;
    }
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState != MJRefreshStateRefreshing) return;
        
        // 保存刷新时间
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:self.lastUpdatedTimeKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // 恢复inset和offset
        [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
            self.scrollView.mj_insetT += self.insetTDelta;
            
            // 自动调整透明度
            if (self.isAutomaticallyChangeAlpha) self.alpha = 0.0;
        } completion:^(BOOL finished) {
            self.pullingPercent = 0.0;
            
            if (self.endRefreshingCompletionBlock) {
                self.endRefreshingCompletionBlock();
            }
        }];
    } else if (state == MJRefreshStateRefreshing) {
        MJRefreshDispatchAsyncOnMainQueue({
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                if (self.scrollView.panGestureRecognizer.state != UIGestureRecognizerStateCancelled) {
                    CGFloat top = self.scrollViewOriginalInset.top + self.mj_h;
                    // 增加滚动区域top
                    self.scrollView.mj_insetT = top;
                    // 设置滚动位置
                    CGPoint offset = self.scrollView.contentOffset;
                    offset.y = -top;
                    [self.scrollView setContentOffset:offset animated:NO];
                }
            } completion:^(BOOL finished) {
                [self executeRefreshingCallback];
            }];
        })
    }
}

#pragma mark - 公共方法
- (NSDate *)lastUpdatedTime
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:self.lastUpdatedTimeKey];
}

- (void)setIgnoredScrollViewContentInsetTop:(CGFloat)ignoredScrollViewContentInsetTop {
    _ignoredScrollViewContentInsetTop = ignoredScrollViewContentInsetTop;
    
    self.mj_y = - self.mj_h - _ignoredScrollViewContentInsetTop;
}

@end
