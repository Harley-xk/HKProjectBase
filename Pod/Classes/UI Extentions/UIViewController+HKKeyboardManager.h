//
//  UIViewController+HKKeyboardManager.h
//  HKProjectBase
//
//  Created by Harley.xk on 15/6/9.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIViewController (HKKeyboardManager)

/**
 *  自适应键盘弹出收起，需要配合Autolayout使用
 *
 *  @param positionConstraint 控制需要调整位置的视图的竖向位置的约束
 *  @param isPositiveOffset 竖向约束与视图位置的关系，若约束值增加，视图下移，则isPositiveOffset为YES，反之为NO
 *  @param bottomSpaceBlock 需要调整位置的视图距离屏幕底部的实时距离，通过block返回。
 */
- (void)manageKeyboardWithPositionConstraint:(NSLayoutConstraint *)positionConstraint
                              positiveOffset:(BOOL)isPositiveOffset
                            bottomSpaceBlock:(CGFloat(^)(void))bottomSpaceBlock;

/**
 *  进一步分装自适应键盘功能，适用于键盘弹出收起时需要调整底部视图位置或尺寸的情况
 *
 *  @param bottomConstraint 关联视图到视图控制器底部的位置约束
 *  @param view             相关联的视图
 */
- (void)manageKeyboardWithBottomConstraint:(NSLayoutConstraint *)bottomConstraint
                            associatedView:(UIView *)view;

/**
 *  如果键盘处于弹出状态时UI发生改变，调用该方法可以在UI改变之后自动调整以适应键盘
 *  @attention 需要事先已启用自适应键盘功能，即已执行上面的方法。
 */
- (void)updateLayoutWithKeyboard;


/**
 *  注册键盘事件观察者，并以Block形式处理
 */
- (void)observeKeyboardEventForKeyboardWillShow:(void(^)(NSNotification *notification))willShow
                                       willHide:(void(^)(NSNotification *notification))willHide
                                     willChange:(void(^)(NSNotification *notification))willChange;

/**
 *  取消/开启键盘管理
 */
- (void)setKeyboardManagerEnabled:(BOOL)enabled;;

@end



