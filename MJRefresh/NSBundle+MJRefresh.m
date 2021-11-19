//
//  NSBundle+MJRefresh.m
//  MJRefresh
//
//  Created by MJ Lee on 16/6/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "NSBundle+MJRefresh.h"
#import "MJRefreshComponent.h"
#import "MJRefreshConfig.h"

static NSBundle *mj_defaultI18nBundle = nil;
static NSBundle *mj_systemI18nBundle = nil;

@implementation NSBundle (MJRefresh)
+ (instancetype)mj_refreshBundle
{
    static NSBundle *refreshBundle = nil;
    if (refreshBundle == nil) {
#ifdef SWIFT_PACKAGE
        NSBundle *containnerBundle = SWIFTPM_MODULE_BUNDLE;
#else
        NSBundle *containnerBundle = [NSBundle bundleForClass:[MJRefreshComponent class]];
#endif
        refreshBundle = [NSBundle bundleWithPath:[containnerBundle pathForResource:@"MJRefresh" ofType:@"bundle"]];
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

+ (UIImage *)mj_trailArrowImage {
    static UIImage *arrowImage = nil;
    if (arrowImage == nil) {
        arrowImage = [[UIImage imageWithContentsOfFile:[[self mj_refreshBundle] pathForResource:@"trail_arrow@2x" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    return arrowImage;
}

+ (NSString *)mj_localizedStringForKey:(NSString *)key
{
    return [self mj_localizedStringForKey:key value:nil];
}

+ (NSString *)mj_localizedStringForKey:(NSString *)key value:(NSString *)value
{
    NSString *table = MJRefreshConfig.defaultConfig.i18nFilename;
    
    // 如果没有缓存, 则走初始化逻辑
    if (mj_defaultI18nBundle == nil) {
        NSString *language = MJRefreshConfig.defaultConfig.languageCode;
        // 如果配置中没有配置语言
        if (!language) {
            language = [NSLocale preferredLanguages].firstObject;
        }
        NSBundle *bundle = MJRefreshConfig.defaultConfig.i18nBundle;
        // 首先优先使用公共配置中的 i18nBundle, 如果为空则使用 mainBundle
        bundle = bundle ? bundle : NSBundle.mainBundle;
        // 按语言选取语言包
        NSString *i18nFolderPath = [bundle pathForResource:language ofType:@"lproj"];
        mj_defaultI18nBundle = [NSBundle bundleWithPath:i18nFolderPath];
        // 检查语言包, 如果没有查找到, 则默认使用 mainBundle
        mj_defaultI18nBundle = mj_defaultI18nBundle ? mj_defaultI18nBundle : NSBundle.mainBundle;
        
        // 获取 MJRefresh 自有的语言包
        if (mj_systemI18nBundle == nil) {
            mj_systemI18nBundle = [self mj_defaultI18nBundleWithLanguage:language];
        }
    }
    // 首先在 MJRefresh 内置语言文件中寻找
    value = [mj_systemI18nBundle localizedStringForKey:key value:value table:nil];
    // 然后在 MainBundle 对应语言文件中寻找
    value = [mj_defaultI18nBundle localizedStringForKey:key value:value table:table];
    return value;
}

+ (NSBundle *)mj_defaultI18nBundleWithLanguage:(NSString *)language {
    if ([language hasPrefix:@"en"]) {
        language = @"en";
    } else if ([language hasPrefix:@"zh"]) {
        if ([language rangeOfString:@"Hans"].location != NSNotFound) {
            language = @"zh-Hans"; // 简体中文
        } else { // zh-Hant\zh-HK\zh-TW
            language = @"zh-Hant"; // 繁體中文
        }
    } else if ([language hasPrefix:@"ko"]) {
        language = @"ko";
    } else if ([language hasPrefix:@"ru"]) {
        language = @"ru";
    } else if ([language hasPrefix:@"uk"]) {
        language = @"uk";
    } else {
        language = @"en";
    }
    
    // 从MJRefresh.bundle中查找资源
    return [NSBundle bundleWithPath:[[NSBundle mj_refreshBundle] pathForResource:language ofType:@"lproj"]];
}
@end

@implementation MJRefreshConfig (Bundle)

+ (void)resetLanguageResourceCache {
    mj_defaultI18nBundle = nil;
    mj_systemI18nBundle = nil;
}

@end
