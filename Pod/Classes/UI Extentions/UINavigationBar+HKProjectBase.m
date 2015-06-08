//
//  UINavigationBar+HKProjectBase.m
//  HKProjectBase-Sample
//
//  Created by Harley.xk on 15/6/8.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import "UINavigationBar+HKProjectBase.h"

@implementation UINavigationBar (HKProjectBase)

- (void)setTitleColor:(UIColor *)color
{
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)setTitleFont:(UIFont *)font
{
    [self setTitleTextAttributes:@{NSFontAttributeName:font}];
}

@end
