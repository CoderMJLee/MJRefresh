//
//  MJRefreshAutoStateFooter.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/13.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "MJRefreshAutoStateFooter.h"

@interface MJRefreshAutoStateFooter()
{
    /** 显示刷新状态的label */
    __unsafe_unretained UILabel *_stateLabel;
}
/** 所有状态对应的文字 */
@property (strong, nonatomic) NSMutableDictionary *stateTitles;
@end

@implementation MJRefreshAutoStateFooter
#pragma mark - 懒加载
- (NSMutableDictionary *)stateTitles
{
    if (!_stateTitles) {
        self.stateTitles = [NSMutableDictionary dictionary];
    }
    return _stateTitles;
}

- (UILabel *)stateLabel
{
    if (!_stateLabel) {
        [self addSubview:_stateLabel = [UILabel mj_label]];
        _stateLabel.numberOfLines=0;
    }
    return _stateLabel;
}

#pragma mark - 公共方法
- (void)setTitle:(NSString *)title forState:(MJRefreshState)state
{
    if (title == nil) return;
    self.stateTitles[@(state)] = title;
    self.stateLabel.text = self.stateTitles[@(self.state)];
    switch (self.scrollView.mj_refreshDirection) {
        case MJRefreshDirectionHorizontal:{
            if (self.stateLabel.text&&self.stateLabel.text.length>0) {
                NSMutableString * str = [[NSMutableString alloc] initWithString:self.stateLabel.text];
                NSInteger count = str.length;
                for (int i = 1; i < count; i ++) {
                    [str insertString:@"\n" atIndex:i*2 - 1];
                }
                self.stateLabel.text=str;
            }
        }
            break;
        case MJRefreshDirectionVertical:
            break;
        default:
            break;
    }

}

#pragma mark - 私有方法
- (void)stateLabelClick
{
    if (self.state == MJRefreshStateIdle) {
        [self beginRefreshing];
    }
}

#pragma mark - 重写父类的方法
- (void)prepare
{
    [super prepare];
    
    // 初始化间距
    self.labelLeftInset = MJRefreshLabelLeftInset;
    
    // 初始化文字
    [self setTitle:[NSBundle mj_localizedStringForKey:MJRefreshAutoFooterIdleText] forState:MJRefreshStateIdle];
    [self setTitle:[NSBundle mj_localizedStringForKey:MJRefreshAutoFooterRefreshingText] forState:MJRefreshStateRefreshing];
    [self setTitle:[NSBundle mj_localizedStringForKey:MJRefreshAutoFooterNoMoreDataText] forState:MJRefreshStateNoMoreData];
    
    // 监听label
    self.stateLabel.userInteractionEnabled = YES;
    [self.stateLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stateLabelClick)]];
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    if (self.stateLabel.constraints.count) return;
    
    // 状态标签
    self.stateLabel.frame = self.bounds;
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    if (self.isRefreshingTitleHidden && state == MJRefreshStateRefreshing) {
        self.stateLabel.text = nil;
    } else {
        self.stateLabel.text = self.stateTitles[@(state)];
        switch (self.scrollView.mj_refreshDirection) {
            case MJRefreshDirectionHorizontal:{
                if (self.stateLabel.text&&self.stateLabel.text.length>0) {
                    NSMutableString * str = [[NSMutableString alloc] initWithString:self.stateLabel.text];
                    NSInteger count = str.length;
                    for (int i = 1; i < count; i ++) {
                        [str insertString:@"\n" atIndex:i*2 - 1];
                    }
                    self.stateLabel.text=str;
                }
            }
                break;
            case MJRefreshDirectionVertical:
                break;
            default:
                break;
        }

    }
}
@end
