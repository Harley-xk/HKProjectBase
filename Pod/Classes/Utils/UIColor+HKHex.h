//
//  UIColor+HKHex.h
//  HKProjectBase-Sample
//
//  Created by Harley.xk on 15/8/26.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HKHex)

+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end
