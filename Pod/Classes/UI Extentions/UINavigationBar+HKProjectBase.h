//
//  UINavigationBar+HKProjectBase.h
//  HKProjectBase
//
//  Created by Harley.xk on 15/6/8.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (HKProjectBase)

/**
 *  设置 NavigationBar 的文字颜色
 */
- (void)setTextColor:(UIColor *)color;
/**
 *  设置标题字体
 */
- (void)setTitleFont:(UIFont *)font;


#pragma mark - DEPRECATED
- (void)hk_setTitleColor:(UIColor *)color NS_DEPRECATED_IOS(2.0,6.0,"This method is DEPRECATED, Use setTextColor: instead");

@end
