//
//  NSString+HKRC4.h
//  HKProjectBase
//
//  Created by Harley.xk on 15/6/30.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HKRC4)

/**
 *  RC4加解密，加密与解密都使用该方法。
 *  使用加密时的key对加密后的字符串调用该方法，返回加密前的值。
 *
 *  @param key 加密及解密使用的密钥
 *
 *  @return 加解密后的字符串
 */
- (NSString *)cryptByRC4WithKey:(NSString *)key;

@end
