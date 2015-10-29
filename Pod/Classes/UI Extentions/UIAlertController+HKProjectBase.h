//
//  UIAlertController+HKProjectBase.h
//  HKProjectBase-Sample
//
//  Created by Harley.xk on 15/10/28.
//  Copyright © 2015年 Harley.xk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (HKProjectBase)

+ (nonnull instancetype)alertViewWithTitle:(nullable NSString *)title message:(nullable NSString *)message;
+ (nonnull instancetype)actonSheetWithTitle:(nullable NSString *)title message:(nullable NSString *)message;

- (void)addDefaultActionWithTitle:(nullable NSString *)title handler:(void (^ __nullable)( UIAlertAction * _Nonnull action))handler;
- (void)addCancelActionWithTitle:(nullable NSString *)title handler:(void (^ __nullable)( UIAlertAction * _Nonnull action))handler;
- (void)addDestructiveActionWithTitle:(nullable NSString *)title handler:(void (^ __nullable)( UIAlertAction * _Nonnull action))handler;

@end
