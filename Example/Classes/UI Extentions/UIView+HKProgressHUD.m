//
//  UIView+HKProgressHUD.m
//  HKProjectBase
//
//  Created by Harley.xk on 15/6/7.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import "UIView+HKProgressHUD.h"
#import <objc/runtime.h>

@implementation UIView (HKProgressHUD)

+(void)load
{
    SEL originalSelector = @selector(didAddSubview:);
    SEL overrideSelector = @selector(fc_didAddSubview:);
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method overrideMethod = class_getInstanceMethod(self, overrideSelector);
    if (class_addMethod(self, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(self, overrideSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, overrideMethod);
    }
}

- (MBProgressHUD *)progressHUD
{
    return objc_getAssociatedObject(self, @selector(progressHUD));
}

- (void)setProgressHUD:(MBProgressHUD *)progressHUD
{
    objc_setAssociatedObject(self, @selector(progressHUD), progressHUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setupProgressHUD
{
    if (self.progressHUD) {
        return;
    }
    self.progressHUD = [[MBProgressHUD alloc] initWithView:self];
    [self addSubview:self.progressHUD];
}


- (void)fc_didAddSubview:(UIView *)subview{
    [self fc_didAddSubview:subview];
    
    if (self.progressHUD) {
        [self bringSubviewToFront:self.progressHUD];
    }
}

/**
 *  使用HUD显示一段文字, 1秒后自动隐藏
 */
- (void)showTextHUDWithMessage:(NSString *)message
{
    [self setupProgressHUD];
    
    self.progressHUD.mode = MBProgressHUDModeText;
    self.progressHUD.labelText = message;
    [self.progressHUD show:YES];
    [self.progressHUD hide:YES afterDelay:1];
}

/**
 *  使用HUD显示一段文字，指定时间后隐藏
 */
- (void)showTextHUDWithMessage:(NSString *)message andHideAfterDelay:(NSTimeInterval)timeInterval
{
    [self setupProgressHUD];
    
    self.progressHUD.mode = MBProgressHUDModeText;
    self.progressHUD.labelText = message;
    [self.progressHUD show:YES];
    [self.progressHUD hide:YES afterDelay:timeInterval];
}

/**
 *  显示不带文字的任务处理提示
 */
- (void)showProgressHUD
{
    [self setupProgressHUD];
    
    self.progressHUD.mode = MBProgressHUDModeIndeterminate;
    self.progressHUD.labelText = nil;
    [self.progressHUD show:YES];
}

/**
 *  显示带文字的任务处理提示
 */
- (void)showProgressHUDWithMessage:(NSString *)message
{
    [self setupProgressHUD];

    self.progressHUD.mode = MBProgressHUDModeIndeterminate;
    self.progressHUD.labelText = message;
    [self.progressHUD show:YES];
}

/**
 *  使用指定模式显示HUD
 */
- (void)showProgressHUDWithMessage:(NSString *)message mode:(MBProgressHUDMode)mode
{
    [self setupProgressHUD];

    self.progressHUD.mode = mode;
    self.progressHUD.labelText = message;
    [self.progressHUD show:YES];
}

/**
 *  显示完毕提示
 */
- (void)changeProgressHUDToFinishMode
{
    [self changeProgressHUDToFinishModeWithMessage:nil];
}
- (void)changeProgressHUDToFinishModeWithMessage:(NSString *)message
{
    self.progressHUD.labelText = message;
    self.progressHUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HK_ProgressHUD_CheckMark"]];
    self.progressHUD.mode = MBProgressHUDModeCustomView;
    
    [self hideProgressHUDAfterDelay:1];
}

/**
 *  隐藏HUD
 */
- (void)hideProgressHUD
{
    [self.progressHUD hide:YES];
}
/**
 *  指定时间后隐藏HUD
 */
- (void)hideProgressHUDAfterDelay:(NSTimeInterval)timeInterval
{
    [self.progressHUD hide:YES afterDelay:timeInterval];
}

@end
