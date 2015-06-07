//
//  UIView+HKProgressHUD.h
//  HKProjectBase
//
//  Created by Harley.xk on 15/6/7.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>

@interface UIView (HKProgressHUD)

@property (strong, nonatomic, readonly) MBProgressHUD *progressHUD;

/**
 *  使用HUD显示一段文字, 1秒后自动隐藏
 */
- (void)showTextHUDWithMessage:(NSString *)message;

/**
 *  使用HUD显示一段文字，指定时间后隐藏
 */
- (void)showTextHUDWithMessage:(NSString *)message andHideAfterDelay:(NSTimeInterval)timeInterval;

/**
 *  显示不带文字的任务处理提示
 */
- (void)showProgressHUD;
/**
 *  显示带文字的任务处理提示
 */
- (void)showProgressHUDWithMessage:(NSString *)message;

/**
 *  使用指定模式显示HUD
 */
- (void)showProgressHUDWithMessage:(NSString *)message mode:(MBProgressHUDMode)mode;
/**
 *  显示完毕提示,会在0.5秒后自动隐藏
 */
- (void)changeProgressHUDToFinishMode;
- (void)changeProgressHUDToFinishModeWithMessage:(NSString *)message;

/**
 *  隐藏HUD
 */
- (void)hideProgressHUD;
/**
 *  指定时间后隐藏HUD
 */
- (void)hideProgressHUDAfterDelay:(NSTimeInterval)timeInterval;


@end
