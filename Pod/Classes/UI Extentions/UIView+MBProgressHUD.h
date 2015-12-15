//
//  UIView+HKProgressHUD.h
//  HKProjectBase
//
//  Created by Harley.xk on 15/6/7.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>

@interface UIView (MBProgressHUD)

@property (strong, nonatomic, readonly) MBProgressHUD *progressHUD NS_DEPRECATED_IOS(2.0,6.0,"MBProgressHUD is not recommended, Use HKProgressHUD instead");

/**
 *  使用HUD显示一段文字, 1秒后自动隐藏
 */
- (void)showTextHUDWithMessage:(NSString *)message NS_DEPRECATED_IOS(2.0,6.0,"MBProgressHUD is not recommended, Use HKProgressHUD instead");

/**
 *  使用HUD显示一段文字，指定时间后隐藏
 */
- (void)showTextHUDWithMessage:(NSString *)message andHideAfterDelay:(NSTimeInterval)timeInterval NS_DEPRECATED_IOS(2.0,6.0,"MBProgressHUD is not recommended, Use HKProgressHUD instead");

/**
 *  显示不带文字的任务处理提示
 */
- (void)showProgressHUD NS_DEPRECATED_IOS(2.0,6.0,"MBProgressHUD is not recommended, Use HKProgressHUD instead");
/**
 *  显示带文字的任务处理提示
 */
- (void)showProgressHUDWithMessage:(NSString *)message NS_DEPRECATED_IOS(2.0,6.0,"MBProgressHUD is not recommended, Use HKProgressHUD instead");

/**
 *  使用指定模式显示HUD
 */
- (void)showProgressHUDWithMessage:(NSString *)message mode:(MBProgressHUDMode)mode NS_DEPRECATED_IOS(2.0,6.0,"MBProgressHUD is not recommended, Use HKProgressHUD instead");
/**
 *  显示完毕提示,会在0.5秒后自动隐藏
 */
- (void)changeProgressHUDToFinishMode NS_DEPRECATED_IOS(2.0,6.0,"MBProgressHUD is not recommended, Use HKProgressHUD instead");
- (void)changeProgressHUDToFinishModeWithMessage:(NSString *)message NS_DEPRECATED_IOS(2.0,6.0,"MBProgressHUD is not recommended, Use HKProgressHUD instead");

/**
 *  隐藏HUD
 */
- (void)hideProgressHUD NS_DEPRECATED_IOS(2.0,6.0,"MBProgressHUD is not recommended, Use HKProgressHUD instead");
/**
 *  指定时间后隐藏HUD
 */
- (void)hideProgressHUDAfterDelay:(NSTimeInterval)timeInterval NS_DEPRECATED_IOS(2.0,6.0,"MBProgressHUD is not recommended, Use HKProgressHUD instead");


@end
