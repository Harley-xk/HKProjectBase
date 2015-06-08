//
//  UIActionSheet+HKProjectBase.h
//  HKProjectBase
//
//  Created by Harley.xk on 15/6/7.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  UIAlertView block 扩展，与Delegate冲突
 */

@interface UIActionSheet (HKProjectBase)

+ (instancetype)actionSheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles;

- (void)showFromToolbar:(UIToolbar *)view withCallback:(void(^)(NSUInteger index))callback;
- (void)showFromTabBar:(UITabBar *)view withCallback:(void(^)(NSUInteger index))callback;
- (void)showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated  withCallback:(void(^)(NSUInteger index))callback;
- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated  withCallback:(void(^)(NSUInteger index))callback;
- (void)showInView:(UIView *)view withCallback:(void(^)(NSUInteger index))callback;

@end
