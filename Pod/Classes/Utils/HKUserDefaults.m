//
//  HKUserDefaults.m
//  HKProjectBase
//
//  Created by Harley.xk on 15/6/30.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import "HKUserDefaults.h"
#import "NSString+HKRC4.h"
#import "NSString+HKProjectBase.h"

#define HKSharedUserDefaults [HKUserDefaults sharedUserDefaults]

@interface HKUserDefaults ()
@property (copy,   nonatomic) NSString *password;
@property (weak,   nonatomic) NSUserDefaults *userDefaults;
@end

@implementation HKUserDefaults

+ (instancetype)sharedUserDefaults
{
    static HKUserDefaults *sharedHKUserDefaults;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedHKUserDefaults = [HKUserDefaults new];
        sharedHKUserDefaults.password = @"com.Harley.xk";
    });
    return sharedHKUserDefaults;
}

+ (void)setPassword:(NSString *)password
{
    HKUserDefaults *userDefault = [HKUserDefaults sharedUserDefaults];
    userDefault.password = password;
}

/**
 *  存储数据
 */
+ (void)setValue:(NSString *)value forKey:(NSString *)key
{
    [HKSharedUserDefaults archiveString:value forKey:key];
}
+ (void)setValues:(NSDictionary *)values
{
    [values enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *rc4 = [obj cryptByRC4WithKey:HKSharedUserDefaults.password];
        NSString *md5Key = [key md5EncodedString];
        [HKSharedUserDefaults.userDefaults setObject:rc4 forKey:md5Key];
    }];
    [HKSharedUserDefaults.userDefaults synchronize];
}

/**
 *  删除数据
 */
+ (void)removeObjectForKey:(NSString *)key
{
    [HKSharedUserDefaults removeStringForKey:key];
}

/**
 *  存储基本类型数据
 */
+ (void)setInteger:(NSInteger)value forKey:(NSString *)key
{
    [HKSharedUserDefaults archiveString:[NSString stringWithFormat:@"%lli",(long long)value] forKey:key];
}
+ (void)setFloat:(float)value forKey:(NSString *)key
{
    [HKSharedUserDefaults archiveString:[NSString stringWithFormat:@"%f",value] forKey:key];
}
+ (void)setDouble:(double)value forKey:(NSString *)key
{
    [HKSharedUserDefaults archiveString:[NSString stringWithFormat:@"%f",value] forKey:key];
}
+ (void)setBool:(BOOL)value forKey:(NSString *)key
{
    [HKSharedUserDefaults archiveString:[NSString stringWithFormat:@"%i",value] forKey:key];
}

/**
 *  读取数据
 */
+ (NSString *)valueForKey:(NSString *)key
{
    return [HKSharedUserDefaults unArchiveStringForKey:key];
}
/**
 *  读取特定类型的数据
 */
+ (NSInteger)integerForKey:(NSString *)key
{
    NSString *string = [HKSharedUserDefaults unArchiveStringForKey:key];
    return [string integerValue];
}
+ (float)floatForKey:(NSString *)key
{
    NSString *string = [HKSharedUserDefaults unArchiveStringForKey:key];
    return [string floatValue];
}
+ (double)doubleForKey:(NSString *)key
{
    NSString *string = [HKSharedUserDefaults unArchiveStringForKey:key];
    return [string doubleValue];
}
+ (BOOL)boolForKey:(NSString *)key
{
    NSString *string = [HKSharedUserDefaults unArchiveStringForKey:key];
    return [string boolValue];
}

- (void)archiveString:(NSString *)string forKey:(NSString *)key
{
    NSString *rc4 = [string cryptByRC4WithKey:self.password];
    NSString *md5Key = [key md5EncodedString];
    [self.userDefaults setObject:rc4 forKey:md5Key];
    [self.userDefaults synchronize];
}

- (NSString *)unArchiveStringForKey:(NSString *)key
{
    NSString *md5Key = [key md5EncodedString];
    NSString *rc4 = [self.userDefaults stringForKey:md5Key];
    return [rc4 cryptByRC4WithKey:self.password];
}

- (void)removeStringForKey:(NSString *)key
{
    NSString *md5Key = [key md5EncodedString];
    [self.userDefaults removeObjectForKey:md5Key];
    [self.userDefaults synchronize];
}

@end
