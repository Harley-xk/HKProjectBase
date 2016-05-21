//
//  UIResponder+HKProjectBase.m
//  HKProjectBase
//
//  Created by Harley.xk on 15/6/9.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import "UIResponder+HKProjectBase.h"

@implementation UIResponder (HKProjectBase)


+ (BOOL)resignAnyFirstResponder
{
    return [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (IBAction)hk_resignFirstResponder
{
    [self resignFirstResponder];
}

- (IBAction)hk_becomeFirstResponder
{
    [self becomeFirstResponder];
}

@end
