//
//  MJRefreshConfig.h
//
//  Created by Frank on 2018/11/27.
//  Copyright © 2018 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MJRefreshConfig : NSObject

/** 默认使用的语言版本, 默认为 nil. 将随系统的语言自动改变 */
@property (copy, nonatomic, nullable) NSString *languageCode;

/** 默认使用的语言资源文件名, 默认为 nil, 即默认的 Localizable.strings.
 
 - Attention: 文件名不包含后缀.strings
 */
@property (copy, nonatomic, nullable) NSString *i18nFilename;
/** i18n 多语言资源加载自定义 Bundle.
 
 - Attention: 默认为 nil 采用内置逻辑. 这里设置后将忽略内置逻辑的多语言模式, 采用自定义的多语言 bundle
 */
@property (nonatomic, nullable) NSBundle *i18nBundle;

/** Singleton Config instance */
@property (class, nonatomic, readonly) MJRefreshConfig *defaultConfig;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
