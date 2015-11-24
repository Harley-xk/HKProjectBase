//
//  UINavigationBar+HKProjectBase.m
//  HKProjectBase
//
//  Created by Harley.xk on 15/6/8.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import "UINavigationBar+HKProjectBase.h"

@implementation UINavigationBar (HKProjectBase)

- (void)hk_setTitleColor:(UIColor *)color
{
    self.tintColor = [UIColor whiteColor];
    NSMutableDictionary *titleTextAttributes = [NSMutableDictionary dictionaryWithDictionary:self.titleTextAttributes];
    [titleTextAttributes setObject:color forKey:NSForegroundColorAttributeName];
    
    self.titleTextAttributes = titleTextAttributes;
}

- (void)setTitleFont:(UIFont *)font
{
    NSMutableDictionary *titleTextAttributes = [NSMutableDictionary dictionaryWithDictionary:self.titleTextAttributes];
    [titleTextAttributes setObject:font forKey:NSFontAttributeName];
    
    self.titleTextAttributes = titleTextAttributes;
}

@end
