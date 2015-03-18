//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  MJRefreshFooter.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/5.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "MJRefreshFooter.h"
#import "MJRefreshConst.h"
#import "UIScrollView+MJExtension.h"
#import "MJRefreshHeader.h"
#import "UIView+MJExtension.h"
#import "UIScrollView+MJRefresh.h"
#import <objc/message.h>

@interface MJRefreshFooter()
/** 显示状态文字的标签 */
@property (weak, nonatomic) UILabel *stateLabel;
/** 点击可以加载更多 */
@property (weak, nonatomic) UIButton *loadMoreButton;
/** 没有更多的数据 */
@property (weak, nonatomic) UILabel *noMoreLabel;
/** 即将要执行的代码 */
@property (strong, nonatomic) NSMutableArray *willExecuteBlocks;
@end

@implementation MJRefreshFooter
#pragma mark - 懒加载
- (NSMutableArray *)willExecuteBlocks
{
    if (!_willExecuteBlocks) {
        self.willExecuteBlocks = [NSMutableArray array];
    }
    return _willExecuteBlocks;
}

- (UIButton *)loadMoreButton
{
    if (!_loadMoreButton) {
        UIButton *loadMoreButton = [[UIButton alloc] init];
        loadMoreButton.backgroundColor = [UIColor clearColor];
        [loadMoreButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_loadMoreButton = loadMoreButton];
    }
    return _loadMoreButton;
}

- (UILabel *)noMoreLabel
{
    if (!_noMoreLabel) {
        UILabel *noMoreLabel = [[UILabel alloc] init];
        noMoreLabel.backgroundColor = [UIColor clearColor];
        noMoreLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_noMoreLabel = noMoreLabel];
    }
    return _noMoreLabel;
}

- (UILabel *)stateLabel
{
    if (!_stateLabel) {
        UILabel *stateLabel = [[UILabel alloc] init];
        stateLabel.backgroundColor = [UIColor clearColor];
        stateLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_stateLabel = stateLabel];
    }
    return _stateLabel;
}

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 默认底部控件100%出现时才会自动刷新
        self.appearencePercentTriggerAutoRefresh = 1.0;
        
        // 设置为默认状态
        self.automaticallyRefresh = YES;
        self.state = MJRefreshFooterStateIdle;
        
        // 初始化文字
        [self setTitle:MJRefreshFooterStateIdleText forState:MJRefreshFooterStateIdle];
        [self setTitle:MJRefreshFooterStateRefreshingText forState:MJRefreshFooterStateRefreshing];
        [self setTitle:MJRefreshFooterStateNoMoreDataText forState:MJRefreshFooterStateNoMoreData];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    // 旧的父控件
    [self.superview removeObserver:self forKeyPath:MJRefreshContentSize context:nil];
    [self.superview removeObserver:self forKeyPath:MJRefreshPanState context:nil];
    
    if (newSuperview) { // 新的父控件
        // 监听
        [newSuperview addObserver:self forKeyPath:MJRefreshContentSize options:NSKeyValueObservingOptionNew context:nil];
        [newSuperview addObserver:self forKeyPath:MJRefreshPanState options:NSKeyValueObservingOptionNew context:nil];
        
        self.mj_h = MJRefreshFooterHeight;
        _scrollView.mj_insetB += self.mj_h;
        
        // 重新调整frame
        [self adjustFrameWithContentSize];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.loadMoreButton.frame = self.bounds;
    self.stateLabel.frame = self.bounds;
    self.noMoreLabel.frame = self.bounds;
}

#pragma mark - 私有方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 遇到这些情况就直接返回
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden) return;
    
    if (self.state == MJRefreshFooterStateIdle) {
        // 当是Idle状态时，才需要检测是否要进入刷新状态
        if ([keyPath isEqualToString:MJRefreshPanState]) {
            if (_scrollView.panGestureRecognizer.state == UIGestureRecognizerStateEnded) {// 手松开
                if (_scrollView.mj_insetT + _scrollView.mj_contentSizeH <= _scrollView.mj_h) {  // 不够一个屏幕
                    if (_scrollView.mj_offsetY > - _scrollView.mj_insetT) { // 向上拽
                        [self beginRefreshing];
                    }
                } else { // 超出一个屏幕
                    if (_scrollView.mj_offsetY > _scrollView.mj_contentSizeH + _scrollView.mj_insetB - _scrollView.mj_h) {
                        [self beginRefreshing];
                    }
                }
            }
        } else if ([keyPath isEqualToString:MJRefreshContentOffset]) {
            if (self.state != MJRefreshFooterStateRefreshing && self.automaticallyRefresh) {
                // 根据contentOffset调整state
                [self adjustStateWithContentOffset];
            }
        }
    }
    
    // 不管是什么状态，都要调整位置
    if ([keyPath isEqualToString:MJRefreshContentSize]) {
        [self adjustFrameWithContentSize];
    }
}

#pragma mark 根据contentOffset调整state
- (void)adjustStateWithContentOffset
{
    if (self.mj_y == 0) return;
    
    if (_scrollView.mj_insetT + _scrollView.mj_contentSizeH > _scrollView.mj_h) { // 内容超过一个屏幕
        // 这里的_scrollView.mj_contentSizeH替换掉self.mj_y更为合理
        if (_scrollView.mj_offsetY > _scrollView.mj_contentSizeH - _scrollView.mj_h + self.mj_h * self.appearencePercentTriggerAutoRefresh + _scrollView.mj_insetB - self.mj_h) {
            // 当底部刷新控件完全出现时，才刷新
            [self beginRefreshing];
        }
    }
}

- (void)adjustFrameWithContentSize
{
    // 设置位置
    self.mj_y = _scrollView.mj_contentSizeH;
}

- (void)buttonClick
{
    [self beginRefreshing];
}

#pragma mark - 公共方法
- (void)setHidden:(BOOL)hidden
{
    __weak typeof(self) weakSelf = self;
    BOOL lastHidden = weakSelf.isHidden;
    CGFloat h = weakSelf.mj_h;
    [weakSelf.willExecuteBlocks addObject:^{
        if (!lastHidden && hidden) {
            weakSelf.state = MJRefreshFooterStateIdle;
            _scrollView.mj_insetB -= h;
        } else if (lastHidden && !hidden) {
            _scrollView.mj_insetB += h;
            
            [weakSelf adjustFrameWithContentSize];
        }
    }];
    [weakSelf setNeedsDisplay]; // 放到drawRect是为了延迟执行，防止因为修改了inset，导致循环调用数据源方法
    
    [super setHidden:hidden];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    for (void (^block)() in self.willExecuteBlocks) {
        block();
    }
    [self.willExecuteBlocks removeAllObjects];
}

- (void)beginRefreshing
{
    self.state = MJRefreshFooterStateRefreshing;
}

- (void)endRefreshing
{
    self.state = MJRefreshFooterStateIdle;
}

- (BOOL)isRefreshing
{
    return self.state == MJRefreshFooterStateRefreshing;
}

- (void)noticeNoMoreData
{
    self.state = MJRefreshFooterStateNoMoreData;
}

- (void)resetNoMoreData
{
    self.state = MJRefreshFooterStateIdle;
}

- (void)setTitle:(NSString *)title forState:(MJRefreshFooterState)state
{
    if (title == nil) return;
    
    // 刷新当前状态的文字
    switch (state) {
        case MJRefreshFooterStateIdle:
            [self.loadMoreButton setTitle:title forState:UIControlStateNormal];
            break;
            
        case MJRefreshFooterStateRefreshing:
            self.stateLabel.text = title;
            break;
            
        case MJRefreshFooterStateNoMoreData:
            self.noMoreLabel.text = title;
            break;
            
        default:
            break;
    }
}

- (void)setState:(MJRefreshFooterState)state
{
    if (_state == state) return;
    
    _state = state;
    
    switch (state) {
        case MJRefreshFooterStateIdle:
            self.noMoreLabel.hidden = YES;
            self.stateLabel.hidden = YES;
            self.loadMoreButton.hidden = NO;
            break;
            
        case MJRefreshFooterStateRefreshing:
            self.loadMoreButton.hidden = YES;
            self.noMoreLabel.hidden = YES;
            if (!self.stateHidden) self.stateLabel.hidden = NO;
            if (self.refreshingBlock) {
                self.refreshingBlock();
            }
            if ([self.refreshingTarget respondsToSelector:self.refreshingAction]) {
                msgSend(msgTarget(self.refreshingTarget), self.refreshingAction, self);
            }
            break;
            
        case MJRefreshFooterStateNoMoreData:
            self.loadMoreButton.hidden = YES;
            self.noMoreLabel.hidden = NO;
            self.stateLabel.hidden = YES;
            break;
            
        default:
            break;
    }
}

- (void)setTextColor:(UIColor *)textColor
{
    [super setTextColor:textColor];
    
    self.stateLabel.textColor = textColor;
    [self.loadMoreButton setTitleColor:textColor forState:UIControlStateNormal];
    self.noMoreLabel.textColor = textColor;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.loadMoreButton.titleLabel.font = font;
    self.noMoreLabel.font = font;
    self.stateLabel.font = font;
}

- (void)setStateHidden:(BOOL)stateHidden
{
    _stateHidden = stateHidden;
    
    self.stateLabel.hidden = stateHidden;
    [self setNeedsLayout];
}
@end
