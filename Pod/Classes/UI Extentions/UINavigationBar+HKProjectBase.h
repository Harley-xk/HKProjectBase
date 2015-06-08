//
//  UINavigationBar+HKProjectBase.h
//  HKProjectBase-Sample
//
//  Created by Harley.xk on 15/6/8.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (HKProjectBase)

/**
 *  用于解决tintColor无法设置NavigationBar字体颜色问题
 */
- (void)setTitleColor:(UIColor *)color;

/**
 *  设置标题字体
 */
- (void)setTitleFont:(UIFont *)font;

@end
