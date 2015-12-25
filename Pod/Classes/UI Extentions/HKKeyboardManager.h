//
//  HKKeyboardManager.h
//  HKProjectBase-Sample
//
//  Created by Harley.xk on 15/12/24.
//  Copyright © 2015年 Harley.xk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  键盘管理器，用于在键盘弹出或收起时调整相应视图，以保证相关内容始终可见
 *
 *  使用方法：
 *  1、将需要始终可见的视图放置于 UIScrollView 或其子类中
 *  2、设置合适的约束
 *  3、创建 HKKeyboardManager，并关联对应的约束和视图
 */

@interface HKKeyboardManager : NSObject

/**
 *  创建键盘管理器
 *
 *  @param viewController 管理器所属的视图控制器
 *  @param constraint     关联的位置约束
 *  @param view           关联的 ScrollView
 */
+ (instancetype)managerWithViewController:(UIViewController *)viewController
                       positionConstraint:(NSLayoutConstraint *)constraint
                             viewToAdjust:(UIScrollView *)view;

/**
 *  临时启用或关闭管理器
 */
@property (assign, nonatomic, getter=isEnabled) BOOL enabled;

/**
 *  是否与键盘同时执行调整动画，默认为 YES。设置为 NO 后，将会在键盘显示之后再执行动画。
 */
@property (assign, nonatomic) BOOL animateAlongwithKeyboard;

@end


@interface UIViewController (HKKeyboardManager)

/**
 *  创建键盘管理器，自动关联到当前视图控制器
 */
- (void)setupHKKeyboardManagerWithPositionConstraint:(NSLayoutConstraint *)constraint
                                        viewToAdjust:(UIScrollView *)view;

/**
 *  获取当前已关联的键盘管理器
 */
- (HKKeyboardManager *)keyboardManagerHK;

@end


