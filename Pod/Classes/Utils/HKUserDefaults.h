//
//  HKUserDefaults.h
//  HKProjectBase
//
//  Created by Harley.xk on 15/6/30.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  HKUserDefaults是一个简单的本地数据存储工具，是对系统NSUserDefaults的功能扩展。
 *  由于系统的NSUserDefaults采用的是明文存储，所以在很多场景下无法很好地胜任工作。
 *  HKUserDefaults采用RC4方式对存储的数据进行加密，并且对key值进行md5编码.
 *  @attention 由于加/解密操作相对耗时，操作大量数据时建议使用异步方式
 */

@interface HKUserDefaults : NSObject

/**
 *  设置存储密钥，只需要在使用前设置一次
 */
+ (void)setPassword:(NSString *)password;

/**
 *  存储数据
 */
+ (void)setValue:(NSString *)value forKey:(NSString *)key;
/**
 *  批量存储数据，避免多次synchronize
 *  @attention Dictionory只接受字符串和基本数据类型
 */
+ (void)setValues:(NSDictionary *)values;

/**
 *  删除数据
 */
+ (void)removeObjectForKey:(NSString *)key;

/**
 *  存储基本类型数据
 */
+ (void)setInteger:(NSInteger)value forKey:(NSString *)key;
+ (void)setFloat:(float)value forKey:(NSString *)key;
+ (void)setDouble:(double)value forKey:(NSString *)key;
+ (void)setBool:(BOOL)value forKey:(NSString *)key;

/**
 *  读取数据
 */
+ (NSString *)valueForKey:(NSString *)key;
/**
 *  读取基本类型的数据
 */
+ (NSInteger)integerForKey:(NSString *)key;
+ (float)floatForKey:(NSString *)key;
+ (double)doubleForKey:(NSString *)key;
+ (BOOL)boolForKey:(NSString *)key;

@end
