//
//  UIViewController+HKKeyboardManager.m
//  HKProjectBase
//
//  Created by Harley.xk on 15/6/9.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import "UIViewController+HKKeyboardManager.h"
#import <objc/runtime.h>

typedef void(^HKKeyboardEventHandler)(NSNotification *);

@interface HKKeyboardManager : NSObject

@property (assign, nonatomic) BOOL shouldManageKeyboard;
@property (assign, nonatomic) BOOL shouldObserveKeyboard;

@property (strong, nonatomic) NSLayoutConstraint *topConstraint;
@property (weak,   nonatomic) UIViewController *viewController;
@property (assign, nonatomic) CGFloat originalTopSpace;
@property (assign, nonatomic) BOOL isPositiveOffset;
@property (copy, nonatomic) CGFloat(^bottomSpaceBlock)(void);

@property (copy, nonatomic) HKKeyboardEventHandler willShowHandler;
@property (copy, nonatomic) HKKeyboardEventHandler willHideHandler;
@property (copy, nonatomic) HKKeyboardEventHandler willChangeHandler;

@end


@implementation HKKeyboardManager

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        // 检测键盘事件
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    return self;
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    if (self.shouldObserveKeyboard && self.willChangeHandler) {
        self.willChangeHandler(notification);
    }
    
    if (self.shouldManageKeyboard) {
        NSDictionary *userInfo = notification.userInfo;
        CGRect endFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyBoardHeight = endFrame.size.height;
        
        CGFloat bottomSpace = self.bottomSpaceBlock();
        CGFloat offset = keyBoardHeight - bottomSpace;
        CGFloat topSpace = self.isPositiveOffset ? self.topConstraint.constant - offset : self.topConstraint.constant + offset;
        if ((topSpace > self.originalTopSpace && self.isPositiveOffset) ||
            (topSpace < self.originalTopSpace && !self.isPositiveOffset)) {
            topSpace = self.originalTopSpace;
        }
        
        [UIView animateWithDuration:0.25 animations:^{
            self.topConstraint.constant = topSpace;
            [self.viewController.view layoutIfNeeded];
        }];
    }
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    if (self.shouldObserveKeyboard && self.willShowHandler) {
        self.willShowHandler(notification);
    }
    
    if (self.shouldManageKeyboard) {
        NSDictionary *userInfo = notification.userInfo;
        CGRect endFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyBoardHeight = endFrame.size.height;
        
        CGFloat bottomSpace = self.bottomSpaceBlock();
        if (bottomSpace >= keyBoardHeight) {
            return;
        }
        
        CGFloat offset = keyBoardHeight - bottomSpace;
        
        NSTimeInterval timeInterval = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
        NSUInteger option = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
        
        [UIView animateWithDuration:timeInterval delay:0 options:option animations:^{
            self.topConstraint.constant = self.isPositiveOffset ? self.originalTopSpace - offset : self.originalTopSpace + offset;
            [self.viewController.view layoutIfNeeded];
        } completion:nil];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    if (self.shouldObserveKeyboard && self.willHideHandler) {
        self.willHideHandler(notification);
    }
    
    if (self.shouldManageKeyboard) {
        NSDictionary *userInfo = notification.userInfo;
        NSTimeInterval timeInterval = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
        NSUInteger option = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
        
        [UIView animateWithDuration:timeInterval delay:0 options:option animations:^{
            self.topConstraint.constant = self.originalTopSpace;
            [self.viewController.view layoutIfNeeded];
        } completion:nil];
    }
}

@end


@implementation UIViewController (HKKeyboardManager)

- (HKKeyboardManager *)keyboardManager
{
    return objc_getAssociatedObject(self, @selector(keyboardManager));
}

- (void)setKeyboardManager:(HKKeyboardManager *)keyboardManager
{
    objc_setAssociatedObject(self, @selector(keyboardManager), keyboardManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)manageKeyboardWithPositionConstraint:(NSLayoutConstraint *)constraint
                              positiveOffset:(BOOL)isPositiveOffset
                            bottomSpaceBlock:(CGFloat(^)(void))bottomSpaceBlock
{
    if (!self.keyboardManager) {
        self.keyboardManager = [[HKKeyboardManager alloc] init];
    }
    
    
    self.keyboardManager.isPositiveOffset = isPositiveOffset;
    self.keyboardManager.topConstraint = constraint;
    self.keyboardManager.originalTopSpace = constraint.constant;
    self.keyboardManager.bottomSpaceBlock = bottomSpaceBlock;
    
    self.keyboardManager.shouldManageKeyboard = YES;
    self.keyboardManager.viewController = self;
}

/**
 *  注册键盘事件观察者，并以Block形式处理
 */
- (void)observeKeyboardEventForKeyboardWillShow:(void(^)(NSNotification *notification))willShow
                                       willHide:(void(^)(NSNotification *notification))willHide
                                     willChange:(void(^)(NSNotification *notification))willChange
{
    if (!self.keyboardManager) {
        self.keyboardManager = [[HKKeyboardManager alloc] init];
    }
    
    self.keyboardManager.willShowHandler = willShow;
    self.keyboardManager.willChangeHandler = willChange;
    self.keyboardManager.willHideHandler = willHide;
    
    self.keyboardManager.shouldObserveKeyboard = YES;
    self.keyboardManager.viewController = self;
}

@end