//
//  UIResponder+HKProjectBase.m
//  HKProjectBase-Sample
//
//  Created by Harley.xk on 15/6/9.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import "UIResponder+HKProjectBase.h"

@implementation UIResponder (HKProjectBase)

- (IBAction)hk_resighFirstResponder
{
    [self resignFirstResponder];
}

- (IBAction)hk_becomeFirstResponder
{
    [self becomeFirstResponder];
}

@end
