//
//  MJRefreshFooterView.m
//  MJRefresh
//
//  Created by mj on 13-2-26.
//  Copyright (c) 2013年 itcast. All rights reserved.
//  上拉加载更多

#import "MJRefreshFooterView.h"
#import "MJRefreshConst.h"
#import "UIView+Extension.h"
#import "UIScrollView+Extension.h"

@interface MJRefreshFooterView()
@property (assign, nonatomic) int lastRefreshCount;
@end

@implementation MJRefreshFooterView

+ (instancetype)footer
{
    return [[MJRefreshFooterView alloc] init];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.statusLabel.frame = self.bounds;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if (self.superview) { // 旧的父控件
        [self.superview removeObserver:self forKeyPath:MJRefreshContentSize context:nil];
    }
    
    if (newSuperview) { // 新的父控件
        // 监听
        [newSuperview addObserver:self forKeyPath:MJRefreshContentSize options:NSKeyValueObservingOptionNew context:nil];
        
        // 重新调整frame
        [self adjustFrame];
    }
}

#pragma mark 重写调整frame
- (void)adjustFrame
{
    // 内容的高度
    CGFloat contentHeight = self.scrollView.contentSizeHeight;
    // 表格的高度
    CGFloat scrollHeight = self.scrollView.height - self.scrollViewOriginalInset.top - self.scrollViewOriginalInset.bottom;
    // 设置位置和尺寸
    self.y = MAX(contentHeight, scrollHeight);
}

#pragma mark 监听UIScrollView的属性
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    
    // 不是contentSize，直接返回
    if (![MJRefreshContentSize isEqualToString:keyPath]) return;
    
    // 不能跟用户交互，直接返回
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden) return;
    
    // 如果正在刷新，直接返回
    if (self.state == MJRefreshStateRefreshing) return;
    
    // 调整frame
    [self adjustFrame];
}

#pragma mark - 状态相关
#pragma mark 设置状态
- (void)setState:(MJRefreshState)state
{
    if (self.state == state) return;
    MJRefreshState oldState = self.state;
    
    [super setState:state];
    
	switch (state)
    {
		case MJRefreshStatePulling:
        {
            self.statusLabel.text = MJRefreshFooterReleaseToRefresh;
            
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                self.arrowImage.transform = CGAffineTransformIdentity;
                UIEdgeInsets inset = self.scrollView.contentInset;
                inset.bottom = self.scrollViewOriginalInset.bottom;
                self.scrollView.contentInset = inset;
            }];
			break;
        }
            
		case MJRefreshStateNormal:
        {
            self.statusLabel.text = MJRefreshFooterPullToRefresh;
            
            // 刚刷新完毕
            CGFloat animDuration = MJRefreshSlowAnimationDuration;
            CGFloat deltaH = [self contentBreakView];
            CGPoint tempOffset;
            
            int currentCount = [self totalDataCountInScrollView];
            if (MJRefreshStateRefreshing == oldState && deltaH > 0 && currentCount != self.lastRefreshCount) {
                tempOffset = self.scrollView.contentOffset;
                animDuration = 0;
            }
            
            [UIView animateWithDuration:animDuration animations:^{
                UIEdgeInsets inset = self.scrollView.contentInset;
                inset.bottom = self.scrollViewOriginalInset.bottom;
                self.scrollView.contentInset = inset;
            }];
            
            [UIView animateWithDuration:animDuration ? MJRefreshFastAnimationDuration : animDuration animations:^{
                self.arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
            }];
            
            if (animDuration == 0) {
                self.scrollView.contentOffset = tempOffset;
            }
			break;
        }
            
        case MJRefreshStateRefreshing:
        {
            // 记录刷新前的数量
            self.lastRefreshCount = [self totalDataCountInScrollView];
            self.statusLabel.text = MJRefreshFooterRefreshing;
            
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                self.arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
                UIEdgeInsets inset = self.scrollView.contentInset;
                CGFloat bottom = self.frame.size.height + self.scrollViewOriginalInset.bottom;
                CGFloat deltaH = [self contentBreakView];
                if (deltaH < 0) { // 如果内容高度小于view的高度
                    bottom -= deltaH;
                }
                inset.bottom = bottom;
                self.scrollView.contentInset = inset;
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
- (CGFloat)contentBreakView
{
    CGFloat h = self.scrollView.frame.size.height - self.scrollViewOriginalInset.bottom - self.scrollViewOriginalInset.top;
    return self.scrollView.contentSize.height - h;
}

#pragma mark - 在父类中用得上
// 合理的Y值(刚好看到上拉刷新控件时的contentOffset.y，取相反数)
- (CGFloat)validY
{
    CGFloat deltaH = [self contentBreakView];
    if (deltaH > 0) {
        return deltaH - self.scrollViewOriginalInset.top;
    } else {
        return - self.scrollViewOriginalInset.top;
    }
}

// view的类型
- (int)viewType
{
    return MJRefreshViewTypeFooter;
}
@end