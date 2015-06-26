//
//  NSString+HKProjectBase.m
//  HKProjectBase
//
//  Created by Harley.xk on 15/6/26.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import "NSString+HKProjectBase.h"
#import "HKProjectBaseUtils.h"

#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (HKProjectBase)

- (BOOL)contains:(NSString *)aString
{
    if (HKSystemVersion() >= 8.0) {
        return [self containsString:aString];
    }
    else {
        NSRange range = [self rangeOfString:aString];
        return range.location != NSNotFound;
    }
}

/**
 *  MD5编码
 */
- (NSString *)md5EncodedString
{
    const char *concat_str = [self UTF8String];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(concat_str, (CC_LONG)strlen(concat_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash uppercaseString];
}

/**
 *  URL编解码
 */
- (NSString *)URLEncodedString
{
    return (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault,  (CFStringRef)self, NULL, (CFStringRef)@":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`",   CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
}
- (NSString *)URLDecodedString
{
    return (__bridge NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)self, (CFStringRef)@":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`", CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
}

- (BOOL)isBlank
{
    return [self isEqualToString:@""];
}

/**
 *  判断字符串中是否包含emoji表情
 */
-(BOOL)containsEmoji
{
    if ([self isEqualToString:@""]) {
        return NO;
    }
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}

- (NSArray *)links
{
    NSError *error = nil;
    NSDataDetector *linkDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:&error];
    NSArray *matches = [linkDetector matchesInString:self options:NSMatchingReportCompletion range:NSMakeRange(0, [self length])];
    if (matches == nil || matches.count <= 0) {
        return nil;
    }
    
    NSMutableArray *links = [NSMutableArray array];
    for (NSTextCheckingResult *match in matches) {
        if ([match resultType] == NSTextCheckingTypeLink) {
            NSURL *URL = [match URL];
            NSString *urlString = [URL absoluteString];
            [links addObject:[urlString URLDecodedString]];
        }
    }
    return links;
}

#pragma mark - PingYin
/**
 *  带声调的拼音
 */
-(NSString *)pingYinWithTone
{
    CFMutableStringRef nameRef = CFStringCreateMutableCopy(NULL, 0, (CFStringRef)self);
    //转换为带声调的拼音
    CFStringTransform(nameRef, NULL, kCFStringTransformMandarinLatin, NO);
    return (__bridge NSString *)(nameRef);
}
/**
 *  不带声调的拼音
 */
-(NSString *)pingYin
{
    CFMutableStringRef nameRef = CFStringCreateMutableCopy(NULL, 0, (CFStringRef)self);
    //转换为带声调的拼音
    CFStringTransform(nameRef, NULL, kCFStringTransformMandarinLatin, NO);
    //去除声调
    CFStringTransform(nameRef, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pinyin = (__bridge NSString *)(nameRef);
    return pinyin;
}

/**
 *  拼音首字母
 */
-(NSString *)pingYinFirstLetter
{
    NSString *pinyin = [self pingYin];
    return [pinyin substringToIndex:1];
}

#pragma mark - RegEx
/// 常用正则表达式
// 邮箱
NSString *HKRegEx_Email = @"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*";
// 电话号码
NSString *HKRegEx_PhoneNumber = @"^(([+])\\d{1,4})*(\\d{3,4})*\\d{7,8}(\\d{1,4})*$";
// 手机号码
NSString *HKRegEx_MobileNumber = @"^(([+])\\d{1,4})*1[0-9][0-9]\\d{8}$";

/**
 *   判断字符串是否满足某个正则表达式
 */
- (BOOL)matchRegEx:(NSString *)regEx
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    BOOL isMatch = [pred evaluateWithObject:self];
    
    return isMatch;
}

/**
 *   判断字符串是否是邮箱
 */
- (BOOL)isEmailAdress
{
    if (self == nil || self.isBlank) {
        return NO;
    }
    return [self matchRegEx:HKRegEx_Email];
}

/**
 *   判断是否是电话号码
 */
- (BOOL)isPhoneNumber
{
    if (self == nil || self.isBlank) {
        return NO;
    }
    return [self matchRegEx:HKRegEx_PhoneNumber];
}

/**
 *   判断是否是手机号码
 */
- (BOOL)isMobileNumber
{
    if (self == nil || self.isBlank) {
        return NO;
    }
    return [self matchRegEx:HKRegEx_MobileNumber];
}

/**
 *  同时验证电话和手机
 */
- (BOOL)isPhoneOrMobileNumber
{
    return [self isPhoneNumber] || [self isMobileNumber];
}


@end
