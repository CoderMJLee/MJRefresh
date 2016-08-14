//
//  NSBundle+MJRefresh.m
//  MJRefreshExample
//
//  Created by MJ Lee on 16/6/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "NSBundle+MJRefresh.h"
#import "MJRefreshComponent.h"

FOUNDATION_STATIC_INLINE NSString * mj_preferredLanguage(NSBundle *bundle)
{
    // `preferredLanguage` 中 `scriptCode` 有些地区并没有
    // 使用 `currentLocale`时 `countryCode` 不准确
    // 这里的 `languageCode` 和 `scriptCode` 取自 `currentLocale` 而 `countryCode` 取自`preferredLanguage`
    // 优先顺序如下:
    // (`languageCode` + `scriptCode` + `countryCode`) ~> (`languageCode` + `scriptCode`) ~> (`languageCode` + `countryCode`) ~> (`languageCode`)
    NSDictionary *components = [NSLocale componentsFromLocaleIdentifier:[NSLocale currentLocale].localeIdentifier];
    NSDictionary *preferredComponents = [NSLocale componentsFromLocaleIdentifier:[NSLocale preferredLanguages].firstObject];
    
    NSString *languageCode = components[NSLocaleLanguageCode];
    NSString *scriptCode = components[NSLocaleScriptCode];
    NSString *countryCode = preferredComponents[NSLocaleCountryCode];
    
    // 命名一般是`languageCode`或者 (`languageCode` + `scriptCode`) 或者 (`languageCode` + `countryCode`)
    NSArray<NSString *> *localizations = [bundle localizations];
    __block NSString *language = @"en";
    [localizations enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *includingComponents = [NSLocale componentsFromLocaleIdentifier:obj];
        NSString *includingLanguageCode = includingComponents[NSLocaleLanguageCode];
        NSString *includingScriptCode = includingComponents[NSLocaleScriptCode];
        NSString *includingCountryCode = includingComponents[NSLocaleCountryCode];
        
        BOOL isLanguageCodeEqual = [languageCode isEqualToString:includingLanguageCode];
        BOOL isScriptCodeEqual = scriptCode.length > 0 && [scriptCode isEqualToString:includingScriptCode];
        BOOL isCountryCodeEqual = countryCode.length > 0 && [countryCode isEqualToString:includingCountryCode];
        
        if (includingScriptCode.length > 0 && includingCountryCode.length > 0) {
            *stop = isLanguageCodeEqual && isScriptCodeEqual && isCountryCodeEqual;
        } else if (includingScriptCode.length > 0) {
            *stop = isLanguageCodeEqual && isScriptCodeEqual;
        } else if (includingCountryCode.length > 0) {
            *stop = isLanguageCodeEqual && isCountryCodeEqual;
        } else if (includingLanguageCode.length > 0) { // 仅有 languageCode
            *stop = isLanguageCodeEqual;
        }
        
        language = (*stop) ? obj : language;
    }];
    return language;
}

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
    static NSBundle *mainBundle = nil;
    if (bundle == nil) {
        // 默认`en`
        NSString *language = mj_preferredLanguage([NSBundle mj_refreshBundle]);
        NSString *mainBundleLanguage = mj_preferredLanguage([NSBundle mainBundle]);
        // 方便用户自己国际化其他语种
        // 优先从 mainBundle 中查找资源, 找不到`key`所对应的值时`fallback`到`MJRefresh.bundle`中查找资源
        bundle = [NSBundle bundleWithPath:[[NSBundle mj_refreshBundle] pathForResource:language ofType:@"lproj"]];
        mainBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:mainBundleLanguage ofType:@"lproj"]];
    }
    value = [bundle localizedStringForKey:key value:value table:nil];
    return mainBundle ? [mainBundle localizedStringForKey:key value:value table:nil] : value;
}
@end
