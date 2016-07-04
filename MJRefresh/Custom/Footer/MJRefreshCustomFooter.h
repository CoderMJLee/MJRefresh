//
//  MJRefreshCustomFooter.h
//  MJRefreshExample
//
//  Created by king on 16/7/4.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "MJRefreshFooter.h"

@interface MJRefreshCustomFooter : MJRefreshFooter

/** 设置不同状态的视图 */
- (void)setView:(UIView *)view forState:(MJRefreshState)state;
@end
