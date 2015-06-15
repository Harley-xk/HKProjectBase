//
//  NSString+HKBase64.m
//  HKProjectBase-Sample
//
//  Created by Harley.xk on 15/6/15.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import "NSString+HKBase64.h"

@implementation NSString (HKBase64)

+ (NSString *)stringWithBase64EncodedString:(NSString *)base64String
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString *)base64EncodedString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}


@end
