//
//  UIView+HKProjectBase.m
//  HKProjectBase-Sample
//
//  Created by Harley.xk on 15/6/11.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import "UIView+HKProjectBase.h"

@implementation UIView (HKProjectBase)

-(CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
}

- (CGFloat)borderWidth
{
    return self.layer.borderWidth;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}

- (UIColor *)borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}


@end
