//
//  UIView+HKProjectBase.h
//  HKProjectBase-Sample
//
//  Created by Harley.xk on 15/6/11.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HKProjectBase)

/**
 *  扩展以支持在IB中直接设置这些属性
 */
@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable UIColor *borderColor;

@end
