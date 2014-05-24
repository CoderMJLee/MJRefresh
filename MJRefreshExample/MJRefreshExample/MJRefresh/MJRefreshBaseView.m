//
//  MJRefreshBaseView.m
//  MJRefresh
//
//  Created by mj on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MJRefreshBaseView.h"
#import "MJRefreshConst.h"

@interface  MJRefreshBaseView()
@property (assign, nonatomic) BOOL hasInitInset;
/**
 交给子类去实现
 */
// 合理的Y值
- (CGFloat)validY;
// view的类型
- (MJRefreshViewType)viewType;
@end

@implementation MJRefreshBaseView
#pragma mark - 初始化方法
/**
 *  创建一个UILabel
 *
 *  @param size 字体大小
 */
- (UILabel *)labelWithFontSize:(CGFloat)size
{
    UILabel *label = [[UILabel alloc] init];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.font = [UIFont boldSystemFontOfSize:size];
    label.textColor = MJRefreshLabelTextColor;
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (instancetype)initWithScrollView:(UIScrollView *)scrollView
{
    if (self = [super init]) {
        self.scrollView = scrollView;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!self.hasInitInset) { // 记录scrollView刚开始的contentInset
        _scrollViewInitInset = self.scrollView.contentInset;
        
        // 监听
        [self observeValueForKeyPath:MJRefreshContentSize ofObject:nil change:nil context:nil];
        
        self.hasInitInset = YES;
        
        // 进入刷新状态
        if (self.state == MJRefreshStateWillRefreshing) {
            [self setState:MJRefreshStateRefreshing];
        }
    }
}

/**
 *  构造方法
 */
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 1.自己的属性
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor clearColor];
        
        // 2.时间标签
        [self addSubview:_lastUpdateTimeLabel = [self labelWithFontSize:12]];
        
        // 3.状态标签
        [self addSubview:_statusLabel = [self labelWithFontSize:13]];
        
        // 4.箭头图片
        UIImageView *arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:MJRefreshSrcName(@"arrow.png")]];
        arrowImage.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [self addSubview:_arrowImage = arrowImage];
        
        // 5.指示器
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityView.bounds = arrowImage.bounds;
        activityView.autoresizingMask = arrowImage.autoresizingMask;
        [self addSubview:_activityView = activityView];
        
        // 6.设置默认状态
        self.state = MJRefreshStateNormal;
    }
    return self;
}

/**
 *  设置frame
 */
- (void)setFrame:(CGRect)frame
{
    frame.size.height = MJRefreshViewHeight;
    [super setFrame:frame];
    
    CGFloat w = frame.size.width;
    CGFloat h = frame.size.height;
    if (w == 0 || self.arrowImage.center.y == h * 0.5) return;
    
    CGFloat statusX = 0;
    CGFloat statusY = 5;
    CGFloat statusHeight = 20;
    CGFloat statusWidth = w;
    // 1.状态标签
    self.statusLabel.frame = CGRectMake(statusX, statusY, statusWidth, statusHeight);
    
    // 2.时间标签
    CGFloat lastUpdateY = statusY + statusHeight + 5;
    self.lastUpdateTimeLabel.frame = CGRectMake(statusX, lastUpdateY, statusWidth, statusHeight);
    
    // 3.箭头
    CGFloat arrowX = w * 0.5 - 100;
    self.arrowImage.center = CGPointMake(arrowX, h * 0.5);
    
    // 4.指示器
    self.activityView.center = _arrowImage.center;
}

- (void)setBounds:(CGRect)bounds
{
    bounds.size.height = MJRefreshViewHeight;
    [super setBounds:bounds];
}

#pragma mark - UIScrollView相关
/**
 *  设置UIScrollView
*/
- (void)setScrollView:(UIScrollView *)scrollView
{
    // 移除之前的监听器
    [self.scrollView removeObserver:self forKeyPath:MJRefreshContentOffset context:nil];
    // 监听contentOffset
    [scrollView addObserver:self forKeyPath:MJRefreshContentOffset options:NSKeyValueObservingOptionNew context:nil];
    
    // 设置scrollView
    _scrollView = scrollView;
    [scrollView addSubview:self];
}

#pragma mark 监听UIScrollView的contentOffset属性
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{    
    if (![MJRefreshContentOffset isEqualToString:keyPath]) return;
    
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden
        || self.state == MJRefreshStateRefreshing) return;
    
    // scrollView所滚动的Y值 * 控件的类型（头部控件是-1，尾部控件是1）
    CGFloat offsetY = self.scrollView.contentOffset.y * self.viewType;
    CGFloat validY = self.validY;
    if (offsetY <= validY) return;
    
    if (self.scrollView.isDragging) {
        CGFloat validOffsetY = validY + MJRefreshViewHeight;
        if (self.state == MJRefreshStatePulling && offsetY <= validOffsetY) {
            // 转为普通状态
            self.state = MJRefreshStateNormal;
            [self notifyStateChange];
        } else if (self.state == MJRefreshStateNormal && offsetY > validOffsetY) {
            // 转为即将刷新状态
            self.state = MJRefreshStatePulling;
            [self notifyStateChange];
        }
    } else { // 即将刷新 && 手松开
        if (self.state == MJRefreshStatePulling) {
            // 开始刷新
            self.state = MJRefreshStateRefreshing;
            [self notifyStateChange];
        }
    }
}

/**
 *  通知状态改变
 */
- (void)notifyStateChange
{
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(refreshView:stateChange:)]) {
        [self.delegate refreshView:self stateChange:self.state];
    }
    
    // 回调
    if (self.refreshStateChangeBlock) {
        self.refreshStateChangeBlock(self, self.state);
    }
}

#pragma mark 设置状态
- (void)setState:(MJRefreshState)state
{
    if (self.state != MJRefreshStateRefreshing) {
        // 存储当前的contentInset
        _scrollViewInitInset = self.scrollView.contentInset;
    }
    
    // 1.一样的就直接返回
    if (self.state == state) return;
    
    // 2.根据状态执行不同的操作
    switch (state) {
		case MJRefreshStateNormal: // 普通状态
            // 显示箭头
            self.arrowImage.hidden = NO;
            // 停止转圈圈
			[self.activityView stopAnimating];
            
            // 说明是刚刷新完毕 回到 普通状态的
            if (MJRefreshStateRefreshing == self.state) {
                // 通知代理
                if ([self.delegate respondsToSelector:@selector(refreshViewEndRefreshing:)]) {
                    [self.delegate refreshViewEndRefreshing:self];
                }
                
                // 回调
                if (self.endStateChangeBlock) {
                    self.endStateChangeBlock(self);
                }
            }
            
			break;
            
        case MJRefreshStatePulling:
            break;
            
		case MJRefreshStateRefreshing:
            // 开始转圈圈
			[self.activityView startAnimating];
            // 隐藏箭头
			self.arrowImage.hidden = YES;
            self.arrowImage.transform = CGAffineTransformIdentity;
            
            // 通知代理
            if ([self.delegate respondsToSelector:@selector(refreshViewBeginRefreshing:)]) {
                [self.delegate refreshViewBeginRefreshing:self];
            }
            
            // 回调
            if (self.beginRefreshingBlock) {
                self.beginRefreshingBlock(self);
            }
			break;
        default:
            break;
	}
    
    // 3.存储状态
    _state = state;
}

#pragma mark - 状态相关
#pragma mark 是否正在刷新
- (BOOL)isRefreshing
{
    return MJRefreshStateRefreshing == self.state;
}
#pragma mark 开始刷新
- (void)beginRefreshing
{
    if (self.window) {
        self.state = MJRefreshStateRefreshing;
    } else {
        _state = MJRefreshStateWillRefreshing;
    }
}
#pragma mark 结束刷新
- (void)endRefreshing
{
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        self.state = MJRefreshStateNormal;
    });
}

#pragma mark - 随便实现
- (CGFloat)validY { return 0;}
- (MJRefreshViewType)viewType {return MJRefreshViewTypeHeader;}
- (void)free
{
    [self.scrollView removeObserver:self forKeyPath:MJRefreshContentOffset];
}
- (void)removeFromSuperview
{
    MJLog(@"removeFromSuperview");
//    [self free];
    self.scrollView = nil;
    [super removeFromSuperview];
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
@end