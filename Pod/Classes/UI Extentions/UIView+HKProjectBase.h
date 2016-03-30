//
//  UIView+HKProjectBase.h
//  HKProjectBase
//
//  Created by Harley.xk on 15/6/11.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+HKProjectBase.h"

@interface UIView (HKProjectBase)

/**
 *  扩展以支持在IB中直接设置这些属性
 */
@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable UIColor *borderColor;

/**
 *  记录发起的任务（比如网络请求），如果在视图被销毁时任务还未执行完毕，这些任务将被取消并销毁
 */
- (void)recordTask:(id<HKTaskProtocol>)task;

@end
