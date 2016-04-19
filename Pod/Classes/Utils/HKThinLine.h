//
//  HKThinLine.h
//  HKProjectBase
//
//  Created by Harley.xk on 16/4/19.
//  Copyright © 2016年 Harley.xk. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  该类用于在视图上添加极细的分割线（粗细<1pt），并可以通过 Autolayout 设置分割线的高度或者宽度
 */

@interface HKThinLine : UIView

/**
 *  分割线的粗细属性对应的约束，只能通过 IB 设置
 */
@property (strong, nonatomic, readonly) IBOutlet NSLayoutConstraint *lineConstraint;

/**
 *  分割线的实际粗细，只能通过 IB 设置，默认为 0.3
 */
@property (assign, nonatomic, readonly) IBInspectable CGFloat constant;


@end
