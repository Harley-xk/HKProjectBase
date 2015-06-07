//
//  UIViewController+HKProgressHUD.m
//  Pods
//
//  Created by Harley.xk on 15/6/7.
//
//

#import "UIViewController+HKProgressHUD.h"

@interface UIView ()
-(void)setupProgressHUD;
@end


@implementation UIViewController (HKProgressHUD)

/**
 *  获取当前view的唯一HUD
 */
- (MBProgressHUD *)progressHUD
{
    [self.view setupProgressHUD];
    return self.view.progressHUD;
}

/**
 *  使用HUD显示一段文字, 1秒后自动隐藏
 */
- (void)showTextHUDWithMessage:(NSString *)message
{
    [self.view showTextHUDWithMessage:message];
}

/**
 *  使用HUD显示一段文字，指定时间后隐藏
 */
- (void)showTextHUDWithMessage:(NSString *)message andHideAfterDelay:(NSTimeInterval)timeInterval
{
    [self.view showTextHUDWithMessage:message andHideAfterDelay:timeInterval];
}

/**
 *  显示不带文字的任务处理提示
 */
- (void)showProgressHUD
{
    [self.view showProgressHUD];
}
/**
 *  显示带文字的任务处理提示
 */
- (void)showProgressHUDWithMessage:(NSString *)message
{
    [self.view showProgressHUDWithMessage:message];
}

/**
 *  使用指定模式显示HUD
 */
- (void)showProgressHUDWithMessage:(NSString *)message mode:(MBProgressHUDMode)mode
{
    [self.view showProgressHUDWithMessage:message mode:mode];
}
/**
 *  显示完毕提示,会在0.5秒后自动隐藏
 */
- (void)changeProgressHUDToFinishMode
{
    [self.view changeProgressHUDToFinishMode];
}

- (void)changeProgressHUDToFinishModeWithMessage:(NSString *)message
{
    [self.view changeProgressHUDToFinishModeWithMessage:message];
}

/**
 *  隐藏HUD
 */
- (void)hideProgressHUD
{
    [self.view hideProgressHUD];
}
/**
 *  指定时间后隐藏HUD
 */
- (void)hideProgressHUDAfterDelay:(NSTimeInterval)timeInterval
{
    [self.view hideProgressHUDAfterDelay:timeInterval];
}

@end
