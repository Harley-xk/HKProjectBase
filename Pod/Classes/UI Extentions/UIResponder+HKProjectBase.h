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


@end
