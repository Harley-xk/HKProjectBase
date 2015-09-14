//
//  NSString+HKProjectBase.h
//  HKProjectBase
//
//  Created by Harley.xk on 15/6/26.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@interface NSString (HKProjectBase)

/**
 *  判断是否包含特定字符串
 */
- (BOOL)contains:(NSString *)aString;

/**
 *  MD5编码
 */
- (NSString *)md5EncodedString;

/**
 *  URL编解码
 */
- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;

/**
 *  判断string是否是空字符串 @"" 
 */
-(BOOL)isBlank;

/**
 *  判断字符串中是否包含emoji表情
 */
-(BOOL)containsEmoji;

/**
 *  查找字符串中的超链接，不存在返回空
 */
- (NSArray *)links;

#pragma mark - PingYin
/**
 *  带声调的拼音
 */
-(NSString *)pingYinWithTone;
/**
 *  不带声调的拼音
 */
-(NSString *)pingYin;
/**
 *  拼音首字母
 */
-(NSString *)pingYinFirstLetter;


#pragma mark - RegEx
/**
 *   判断字符串是否满足某个正则表达式
 */
- (BOOL)matchRegEx:(NSString *)regEx;
/**
 *   判断字符串是否是邮箱
 */
- (BOOL)isEmailAdress;
/**
 *   判断是否是电话号码
 */
- (BOOL)isPhoneNumber;
/**
 *  判断是否是手机号码
 */
- (BOOL)isMobileNumber;
/**
 *  判断是否是手机号码或者电话号码
 */
- (BOOL)isPhoneOrMobileNumber;

#pragma mark - Bounding Rect
/**
 *  计算字符串的大小，根据限定的高或者宽度，计算另一项的值
 */
- (CGFloat)widthLimitedToHeight:(CGFloat)height withFont:(UIFont *)font;
- (CGFloat)heightLimitedToWidth:(CGFloat)width withFont:(UIFont *)font;

@end
