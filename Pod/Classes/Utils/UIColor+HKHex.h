//
//  UIColor+HKHex.h
//  HKProjectBase-Sample
//
//  Created by Harley.xk on 15/8/26.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HKHex)

/**
 *  使用16进制字符串创建颜色
 *
 *  @param hexString 16进制字符串，可以是 0XFFFFFF/#FFFFFF/FFFFFF 三种格式之一
 *
 *  @return 返回创建的UIColor对象
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end
