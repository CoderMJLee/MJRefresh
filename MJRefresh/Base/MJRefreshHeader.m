//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  MJRefreshHeader.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/4.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJRefreshHeader.h"

NSString * const MJRefreshHeaderRefreshing2IdleBoundsKey = @"MJRefreshHeaderRefreshing2IdleBounds";
NSString * const MJRefreshHeaderRefreshingBoundsKey = @"MJRefreshHeaderRefreshingBounds";

@interface MJRefreshHeader() <CAAnimationDelegate>
@property (assign, nonatomic) CGFloat insetTDelta;
@end

@implementation MJRefreshHeader
#pragma mark - 构造方法
+ (instancetype)headerWithRefreshingBlock:(MJRefreshComponentAction)refreshingBlock
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

- (void)resetInset {
    if (@available(iOS 11.0, *)) {
    } else {
        // 如果 iOS 10 及以下系统在刷新时, push 新的 VC, 等待刷新完成后回来, 会导致顶部 Insets.top 异常, 不能 resetInset, 检查一下这种特殊情况
        if (!self.window) { return; }
    }
    
    // sectionheader停留解决
    CGFloat insetT = - self.scrollView.mj_offsetY > _scrollViewOriginalInset.top ? - self.scrollView.mj_offsetY : _scrollViewOriginalInset.top;
    insetT = insetT > self.mj_h + _scrollViewOriginalInset.top ? self.mj_h + _scrollViewOriginalInset.top : insetT;
    self.insetTDelta = _scrollViewOriginalInset.top - insetT;
    // 避免 CollectionView 在使用根据 Autolayout 和 内容自动伸缩 Cell, 刷新时导致的 Layout 异常渲染问题
    if (self.scrollView.mj_insetT != insetT) {
        self.scrollView.mj_insetT = insetT;
    }
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
    // 在刷新的refreshing状态
    if (self.state == MJRefreshStateRefreshing) {
        [self resetInset];
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
        
        [self headerEndingAction];
    } else if (state == MJRefreshStateRefreshing) {
        [self headerRefreshingAction];
    }
}

- (void)headerEndingAction {
    // 保存刷新时间
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:self.lastUpdatedTimeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // 默认使用 UIViewAnimation 动画
    if (!self.isCollectionViewAnimationBug) {
        // 恢复inset和offset
        [UIView animateWithDuration:self.slowAnimationDuration animations:^{
            self.scrollView.mj_insetT += self.insetTDelta;
            
            if (self.endRefreshingAnimationBeginAction) {
                self.endRefreshingAnimationBeginAction();
            }
            // 自动调整透明度
            if (self.isAutomaticallyChangeAlpha) self.alpha = 0.0;
        } completion:^(BOOL finished) {
            self.pullingPercent = 0.0;
            
            if (self.endRefreshingCompletionBlock) {
                self.endRefreshingCompletionBlock();
            }
        }];
        
        return;
    }
    
    /**
     这个解决方法的思路出自 https://github.com/CoderMJLee/MJRefresh/pull/844
     修改了用+ [UIView animateWithDuration: animations:]实现的修改contentInset的动画
     fix issue#225 https://github.com/CoderMJLee/MJRefresh/issues/225
     另一种解法 pull#737 https://github.com/CoderMJLee/MJRefresh/pull/737
     
     同时, 处理了 Refreshing 中的动画替换.
    */
    
    // 由于修改 Inset 会导致 self.pullingPercent 联动设置 self.alpha, 故提前获取 alpha 值, 后续用于还原 alpha 动画
    CGFloat viewAlpha = self.alpha;
    
    self.scrollView.mj_insetT += self.insetTDelta;
    // 禁用交互, 如果不禁用可能会引起渲染问题.
    self.scrollView.userInteractionEnabled = NO;

    //CAAnimation keyPath 不支持 contentInset 用Bounds的动画代替
    CABasicAnimation *boundsAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    boundsAnimation.fromValue = [NSValue valueWithCGRect:CGRectOffset(self.scrollView.bounds, 0, self.insetTDelta)];
    boundsAnimation.duration = self.slowAnimationDuration;
    //在delegate里移除
    boundsAnimation.removedOnCompletion = NO;
    boundsAnimation.fillMode = kCAFillModeBoth;
    boundsAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    boundsAnimation.delegate = self;
    [boundsAnimation setValue:MJRefreshHeaderRefreshing2IdleBoundsKey forKey:@"identity"];

    [self.scrollView.layer addAnimation:boundsAnimation forKey:MJRefreshHeaderRefreshing2IdleBoundsKey];
    
    if (self.endRefreshingAnimationBeginAction) {
        self.endRefreshingAnimationBeginAction();
    }
    // 自动调整透明度的动画
    if (self.isAutomaticallyChangeAlpha) {
        CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.fromValue = @(viewAlpha);
        opacityAnimation.toValue = @(0.0);
        opacityAnimation.duration = self.slowAnimationDuration;
        opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [self.layer addAnimation:opacityAnimation forKey:@"MJRefreshHeaderRefreshing2IdleOpacity"];

        // 由于修改了 inset 导致, pullingPercent 被设置值, alpha 已经被提前修改为 0 了. 所以这里不用置 0, 但为了代码的严谨性, 不依赖其他的特殊实现方式, 这里还是置 0.
        self.alpha = 0;
    }
}

- (void)headerRefreshingAction {
    // 默认使用 UIViewAnimation 动画
    if (!self.isCollectionViewAnimationBug) {
        MJRefreshDispatchAsyncOnMainQueue({
            [UIView animateWithDuration:self.fastAnimationDuration animations:^{
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
        return;
    }
    
    if (self.scrollView.panGestureRecognizer.state != UIGestureRecognizerStateCancelled) {
        CGFloat top = self.scrollViewOriginalInset.top + self.mj_h;
        // 禁用交互, 如果不禁用可能会引起渲染问题.
        self.scrollView.userInteractionEnabled = NO;

        // CAAnimation keyPath不支持 contentOffset 用Bounds的动画代替
        CABasicAnimation *boundsAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
        CGRect bounds = self.scrollView.bounds;
        bounds.origin.y = -top;
        boundsAnimation.fromValue = [NSValue valueWithCGRect:self.scrollView.bounds];
        boundsAnimation.toValue = [NSValue valueWithCGRect:bounds];
        boundsAnimation.duration = self.fastAnimationDuration;
        //在delegate里移除
        boundsAnimation.removedOnCompletion = NO;
        boundsAnimation.fillMode = kCAFillModeBoth;
        boundsAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        boundsAnimation.delegate = self;
        [boundsAnimation setValue:MJRefreshHeaderRefreshingBoundsKey forKey:@"identity"];
        [self.scrollView.layer addAnimation:boundsAnimation forKey:MJRefreshHeaderRefreshingBoundsKey];
    } else {
        [self executeRefreshingCallback];
    }
}

#pragma mark . 链式语法部分 .

- (instancetype)linkTo:(UIScrollView *)scrollView {
    scrollView.mj_header = self;
    return self;
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSString *identity = [anim valueForKey:@"identity"];
    if ([identity isEqualToString:MJRefreshHeaderRefreshing2IdleBoundsKey]) {
        self.pullingPercent = 0.0;
        self.scrollView.userInteractionEnabled = YES;
        if (self.endRefreshingCompletionBlock) {
            self.endRefreshingCompletionBlock();
        }
    } else if ([identity isEqualToString:MJRefreshHeaderRefreshingBoundsKey]) {
        // 避免出现 end 先于 Refreshing 状态
        if (self.state != MJRefreshStateIdle) {
            CGFloat top = self.scrollViewOriginalInset.top + self.mj_h;
            self.scrollView.mj_insetT = top;
            // 设置最终滚动位置
            CGPoint offset = self.scrollView.contentOffset;
            offset.y = -top;
            [self.scrollView setContentOffset:offset animated:NO];
         }
        self.scrollView.userInteractionEnabled = YES;
        [self executeRefreshingCallback];
    }
    
    if ([self.scrollView.layer animationForKey:MJRefreshHeaderRefreshing2IdleBoundsKey]) {
        [self.scrollView.layer removeAnimationForKey:MJRefreshHeaderRefreshing2IdleBoundsKey];
    }
    
    if ([self.scrollView.layer animationForKey:MJRefreshHeaderRefreshingBoundsKey]) {
        [self.scrollView.layer removeAnimationForKey:MJRefreshHeaderRefreshingBoundsKey];
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
