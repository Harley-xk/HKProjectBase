//
//  NSString+HKBase64.h
//  HKProjectBase
//
//  Created by Harley.xk on 15/6/15.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HKBase64)

/**
 *  Base64解码
 */
+ (NSString *)stringWithBase64EncodedString:(NSString *)base64String;
- (NSString *)base64DecodedString;

/**
 *  Base64编码
 */
- (NSString *)base64EncodedString;

@end
