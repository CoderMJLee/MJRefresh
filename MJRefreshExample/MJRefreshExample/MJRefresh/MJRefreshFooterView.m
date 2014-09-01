//
//  MJRefreshFooterView.m
//  MJRefresh
//
//  Created by mj on 13-2-26.
//  Copyright (c) 2013年 itcast. All rights reserved.
//  上拉加载更多

#import "MJRefreshFooterView.h"
#import "MJRefreshConst.h"
#import "UIView+MJExtension.h"
#import "UIScrollView+MJExtension.h"

@interface MJRefreshFooterView()
@property (assign, nonatomic) int lastRefreshCount;
@end

@implementation MJRefreshFooterView

+ (instancetype)footer
{
    return [[MJRefreshFooterView alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.pullToRefreshText = MJRefreshFooterPullToRefresh;
        self.releaseToRefreshText = MJRefreshFooterReleaseToRefresh;
        self.refreshingText = MJRefreshFooterRefreshing;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.statusLabel.frame = self.bounds;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    // 旧的父控件
    [self.superview removeObserver:self forKeyPath:MJRefreshContentSize context:nil];
    
    if (newSuperview) { // 新的父控件
        // 监听
        [newSuperview addObserver:self forKeyPath:MJRefreshContentSize options:NSKeyValueObservingOptionNew context:nil];
        
        // 重新调整frame
        [self adjustFrameWithContentSize];
    }
}

#pragma mark 重写调整frame
- (void)adjustFrameWithContentSize
{
    // 内容的高度
    CGFloat contentHeight = self.scrollView.mj_contentSizeHeight;
    // 表格的高度
    CGFloat scrollHeight = self.scrollView.mj_height - self.scrollViewOriginalInset.top - self.scrollViewOriginalInset.bottom;
    // 设置位置和尺寸
    self.mj_y = MAX(contentHeight, scrollHeight);
}

#pragma mark 监听UIScrollView的属性
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 不能跟用户交互，直接返回
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden) return;
    
    if ([MJRefreshContentSize isEqualToString:keyPath]) {
        // 调整frame
        [self adjustFrameWithContentSize];
    } else if ([MJRefreshContentOffset isEqualToString:keyPath]) {
#warning 这个返回一定要放这个位置
        // 如果正在刷新，直接返回
        if (self.state == MJRefreshStateRefreshing) return;
        
        // 调整状态
        [self adjustStateWithContentOffset];
    }
}

/**
 *  调整状态
 */
- (void)adjustStateWithContentOffset
{
    // 当前的contentOffset
    CGFloat currentOffsetY = self.scrollView.mj_contentOffsetY;
    // 尾部控件刚好出现的offsetY
    CGFloat happenOffsetY = [self happenOffsetY];
    
    // 如果是向下滚动到看不见尾部控件，直接返回
    if (currentOffsetY <= happenOffsetY) return;
    
    if (self.scrollView.isDragging) {
        // 普通 和 即将刷新 的临界点
        CGFloat normal2pullingOffsetY = happenOffsetY + self.mj_height;
        
        if (self.state == MJRefreshStateNormal && currentOffsetY > normal2pullingOffsetY) {
            // 转为即将刷新状态
            self.state = MJRefreshStatePulling;
        } else if (self.state == MJRefreshStatePulling && currentOffsetY <= normal2pullingOffsetY) {
            // 转为普通状态
            self.state = MJRefreshStateNormal;
        }
    } else if (self.state == MJRefreshStatePulling) {// 即将刷新 && 手松开
        // 开始刷新
        self.state = MJRefreshStateRefreshing;
    }
}

#pragma mark - 状态相关
#pragma mark 设置状态
- (void)setState:(MJRefreshState)state
{
    // 1.一样的就直接返回
    if (self.state == state) return;
    
    // 2.保存旧状态
    MJRefreshState oldState = self.state;
    
    // 3.调用父类方法
    [super setState:state];
    
    // 4.根据状态来设置属性
	switch (state)
    {
		case MJRefreshStateNormal:
        {
            // 刷新完毕
            if (MJRefreshStateRefreshing == oldState) {
                self.arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
                [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                    self.scrollView.mj_contentInsetBottom = self.scrollViewOriginalInset.bottom;
                }];
            } else {
                // 执行动画
                [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                    self.arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
                }];
            }
            
            CGFloat deltaH = [self heightForContentBreakView];
            int currentCount = [self totalDataCountInScrollView];
            // 刚刷新完毕
            if (MJRefreshStateRefreshing == oldState && deltaH > 0 && currentCount != self.lastRefreshCount) {
                self.scrollView.mj_contentOffsetY = self.scrollView.mj_contentOffsetY;
            }
			break;
        }
            
		case MJRefreshStatePulling:
        {
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                self.arrowImage.transform = CGAffineTransformIdentity;
            }];
			break;
        }
            
        case MJRefreshStateRefreshing:
        {
            // 记录刷新前的数量
            self.lastRefreshCount = [self totalDataCountInScrollView];
            
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                CGFloat bottom = self.mj_height + self.scrollViewOriginalInset.bottom;
                CGFloat deltaH = [self heightForContentBreakView];
                if (deltaH < 0) { // 如果内容高度小于view的高度
                    bottom -= deltaH;
                }
                self.scrollView.mj_contentInsetBottom = bottom;
            }];
			break;
        }
            
        default:
            break;
	}
}

- (int)totalDataCountInScrollView
{
    int totalCount = 0;
    if ([self.scrollView isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self.scrollView;
        
        for (int section = 0; section<tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    } else if ([self.scrollView isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self.scrollView;
        
        for (int section = 0; section<collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
}

#pragma mark 获得scrollView的内容 超出 view 的高度
- (CGFloat)heightForContentBreakView
{
    CGFloat h = self.scrollView.frame.size.height - self.scrollViewOriginalInset.bottom - self.scrollViewOriginalInset.top;
    return self.scrollView.contentSize.height - h;
}

#pragma mark - 在父类中用得上
/**
 *  刚好看到上拉刷新控件时的contentOffset.y
 */
- (CGFloat)happenOffsetY
{
    CGFloat deltaH = [self heightForContentBreakView];
    if (deltaH > 0) {
        return deltaH - self.scrollViewOriginalInset.top;
    } else {
        return - self.scrollViewOriginalInset.top;
    }
}
@end