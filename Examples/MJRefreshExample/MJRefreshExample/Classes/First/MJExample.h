//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  MJExample.h
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJExample : NSObject
@property (copy, nonatomic) NSString *header;
@property (strong, nonatomic) NSArray *titles;
@property (strong, nonatomic) NSArray *methods;
@property (assign, nonatomic) Class vcClass;
@end
