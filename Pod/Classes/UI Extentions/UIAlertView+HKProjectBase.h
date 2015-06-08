//
//  UIAlertView+HKProjectBase.h
//  HKProjectBase
//
//  Created by Harley.xk on 15/6/7.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  UIAlertView block 扩展，与Delegate冲突
 */

@interface UIAlertView (HKProjectBase)

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles;

- (void)showWithCallback:(void(^)(NSUInteger index))callback;

@end
