//
//  MJRefreshConfig.m
//
//  Created by Frank on 2018/11/27.
//  Copyright © 2018 小码哥. All rights reserved.
//

#import "MJRefreshConfig.h"

@implementation MJRefreshConfig

static MJRefreshConfig *mj_RefreshConfig = nil;

+ (instancetype)defaultConfig {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mj_RefreshConfig = [[self alloc] init];
    });
    return mj_RefreshConfig;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _headerHeight = 54;
        _footerHeight = 44;
        _fastAnimationDuration = 0.25;
        _slowAnimationDuration = 0.4;
    }
    
    return self;
}

@end
