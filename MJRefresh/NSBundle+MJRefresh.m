//
//  NSBundle+MJRefresh.m
//  MJRefreshExample
//
//  Created by MJ Lee on 16/6/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "NSBundle+MJRefresh.h"
#import "MJRefreshComponent.h"

@implementation NSBundle (MJRefresh)
+ (instancetype)mj_refreshBundle
{
    static NSBundle *refreshBundle = nil;
    if (refreshBundle == nil) {
        // 这里不使用mainBundle是为了适配pod 1.x和0.x
        refreshBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[MJRefreshComponent class]] pathForResource:@"MJRefresh" ofType:@"bundle"]];
    }
    return refreshBundle;
}

+ (UIImage *)mj_arrowImage
{
    static UIImage *arrowImage = nil;
    if (arrowImage == nil) {
        arrowImage = [[UIImage imageWithContentsOfFile:[[self mj_refreshBundle] pathForResource:@"arrow@2x" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    return arrowImage;
}

+ (NSString *)mj_localizedStringForKey:(NSString *)key
{
    return [self mj_localizedStringForKey:key value:nil];
}

+ (NSString *)mj_localizedStringForKey:(NSString *)key value:(NSString *)value
{
    static NSBundle *bundle = nil;
    if (bundle == nil) {
        // 获得设备的语言
        NSString *language = [NSLocale preferredLanguages].firstObject;
        // 如果是iOS9以上，去掉后面的设备购买地区比如zh-Hans-US和zh-Hans-CN后面的US和CN
        if ([UIDevice currentDevice].systemVersion.floatValue >= 9.0) {
            NSRange range = [language rangeOfString:@"-" options:NSBackwardsSearch];
            if (range.location != NSNotFound) {
                language = [language substringToIndex:range.location];
            }
        }
        
        if ([language isEqualToString:@"zh"]) { // zh-HK被去掉了-HK
            language = @"zh-Hant";
        }
        
        if (language.length == 0) {
            language = @"zh-Hans";
        }
        
        // 先从MJRefresh.bundle中查找资源
        NSBundle *refreshBundle = [NSBundle mj_refreshBundle];
        if ([refreshBundle.localizations containsObject:language]) {
            bundle = [NSBundle bundleWithPath:[refreshBundle pathForResource:language ofType:@"lproj"]];
        }
    }
    value = [bundle localizedStringForKey:key value:value table:nil];
    return [[NSBundle mainBundle] localizedStringForKey:key value:value table:nil];
}
@end
