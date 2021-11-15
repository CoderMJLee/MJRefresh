//
//  MJRefreshConfig.m
//
//  Created by Frank on 2018/11/27.
//  Copyright © 2018 小码哥. All rights reserved.
//

#import "MJRefreshConfig.h"
#import "MJRefreshConst.h"
#import "NSBundle+MJRefresh.h"

@interface MJRefreshConfig (Bundle)

+ (void)resetLanguageResourceCache;

@end

@implementation MJRefreshConfig

static MJRefreshConfig *mj_RefreshConfig = nil;

+ (instancetype)defaultConfig {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mj_RefreshConfig = [[self alloc] init];
    });
    return mj_RefreshConfig;
}

- (void)setLanguageCode:(NSString *)languageCode {
    if ([languageCode isEqualToString:_languageCode]) {
        return;
    }
    
    _languageCode = languageCode;
    // 重置语言资源
    [MJRefreshConfig resetLanguageResourceCache];
    [NSNotificationCenter.defaultCenter
     postNotificationName:MJRefreshDidChangeLanguageNotification object:self];
}

@end
