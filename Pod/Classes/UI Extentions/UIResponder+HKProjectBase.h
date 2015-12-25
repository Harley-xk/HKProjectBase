//
//  UIResponder+HKProjectBase.h
//  HKProjectBase
//
//  Created by Harley.xk on 15/6/9.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (HKProjectBase)

+ (BOOL)resignAnyFirstResponder;

- (IBAction)hk_resignFirstResponder;
- (IBAction)hk_becomeFirstResponder;


#pragma mark - DEPRECATED
+ (BOOL)resignAllFirstResponders NS_DEPRECATED_IOS(2.0,6.0,"This method is DEPRECATED, Use resignAnyFirstResponder instead");
- (IBAction)hk_resighFirstResponder NS_DEPRECATED_IOS(2.0,6.0,"This method is DEPRECATED, Use hk_resignFirstResponder instead");


@end
