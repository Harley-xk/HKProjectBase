//
//  UIAlertController+HKProjectBase.m
//  HKProjectBase-Sample
//
//  Created by Harley.xk on 15/10/28.
//  Copyright © 2015年 Harley.xk. All rights reserved.
//

#import "UIAlertController+HKProjectBase.h"

@implementation UIAlertController (HKProjectBase)

+ (instancetype)alertViewWithTitle:(nullable NSString *)title message:(nullable NSString *)message
{
    return [self alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
}

+ (instancetype)actonSheetWithTitle:(nullable NSString *)title message:(nullable NSString *)message
{
    return [self alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
}

- (void)addDefaultActionWithTitle:(nullable NSString *)title handler:(void (^ __nullable)( UIAlertAction * _Nonnull action))handler
{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:handler];
    [self addAction:action];
}

- (void)addCancelActionWithTitle:(nullable NSString *)title handler:(void (^ __nullable)( UIAlertAction * _Nonnull action))handler
{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:handler];
    [self addAction:action];
}

- (void)addDestructiveActionWithTitle:(nullable NSString *)title handler:(void (^ __nullable)( UIAlertAction * _Nonnull action))handler
{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDestructive handler:handler];
    [self addAction:action];
}


@end
