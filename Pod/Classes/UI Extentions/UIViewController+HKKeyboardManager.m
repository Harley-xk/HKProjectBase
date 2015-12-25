//
//  UIViewController+HKKeyboardManager.m
//  HKProjectBase
//
//  Created by Harley.xk on 15/6/9.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import "UIViewController+HKKeyboardManager.h"
#import "HKProjectBase.h"
#import <objc/runtime.h>

typedef void(^HKKeyboardEventHandler)(NSNotification *);

@interface _HKKeyboardManager : NSObject

@property (assign, nonatomic) BOOL shouldManageKeyboard;
@property (assign, nonatomic) BOOL shouldObserveKeyboard;

@property (strong, nonatomic) NSLayoutConstraint *topConstraint;
@property (weak,   nonatomic) UIViewController *viewController;
@property (assign, nonatomic) CGFloat originalTopSpace;
@property (assign, nonatomic) CGRect currentKeyboardFrame;
@property (assign, nonatomic) BOOL isPositiveOffset;
@property (copy,   nonatomic) CGFloat(^bottomSpaceBlock)(void);

@property (copy, nonatomic) HKKeyboardEventHandler willShowHandler;
@property (copy, nonatomic) HKKeyboardEventHandler willHideHandler;
@property (copy, nonatomic) HKKeyboardEventHandler willChangeHandler;

@end


@implementation _HKKeyboardManager

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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    return self;
}

- (void)updateLayoutWithKeyboard
{
    CGFloat keyBoardHeight = self.currentKeyboardFrame.size.height;
    
    CGFloat bottomSpace = self.bottomSpaceBlock();
    CGFloat offset = keyBoardHeight - bottomSpace;
    CGFloat topSpace = self.isPositiveOffset ? self.topConstraint.constant - offset : self.topConstraint.constant + offset;
    if ((topSpace > self.originalTopSpace && self.isPositiveOffset) ||
        (topSpace < self.originalTopSpace && !self.isPositiveOffset)) {
        topSpace = self.originalTopSpace;
    }
    
    HKExcuteAfterOnMainQueue(0.05, ^{
        [UIView animateWithDuration:0.25 animations:^{
            self.topConstraint.constant = topSpace;
            [self.viewController.view layoutIfNeeded];
        }];
    });
}

- (void)updateForKeyboardWithInfo:(NSDictionary *)userInfo
{
    CGRect endFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect frameInView = [self.viewController.view convertRect:endFrame fromView:self.viewController.view.window];
    
    CGFloat keyBoardHeight = self.viewController.view.frame.size.height - frameInView.origin.y;
    keyBoardHeight = MAX(0, keyBoardHeight);
    
    CGFloat bottomSpace = self.bottomSpaceBlock();
    if (bottomSpace >= keyBoardHeight) {
        return;
    }
    
    CGFloat offset = keyBoardHeight - bottomSpace;
    
    NSTimeInterval timeInterval = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    NSUInteger option = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    HKExcuteAfterOnMainQueue(0.05, ^{
        [UIView animateWithDuration:timeInterval delay:0 options:option animations:^{
            self.topConstraint.constant = self.isPositiveOffset ? self.originalTopSpace - offset : self.originalTopSpace + offset;
            [self.viewController.view layoutIfNeeded];
        } completion:nil];
    });
    
    self.currentKeyboardFrame = endFrame;
}


- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    if (self.shouldObserveKeyboard && self.willChangeHandler) {
        self.willChangeHandler(notification);
    }
    
    if (self.shouldManageKeyboard) {
        NSDictionary *userInfo = notification.userInfo;
        [self updateForKeyboardWithInfo:userInfo];
    }
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    if (self.shouldObserveKeyboard && self.willShowHandler) {
        self.willShowHandler(notification);
    }
    
    if (self.shouldManageKeyboard) {
        NSDictionary *userInfo = notification.userInfo;
        [self updateForKeyboardWithInfo:userInfo];
    }
}

- (void)keyboardDidShow:(NSNotification *)notification
{    
    if (self.shouldManageKeyboard) {
        NSDictionary *userInfo = notification.userInfo;
        [self updateForKeyboardWithInfo:userInfo];
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
        
        HKExcuteAfterOnMainQueue(0.05, ^{
            [UIView animateWithDuration:timeInterval delay:0 options:option animations:^{
                self.topConstraint.constant = self.originalTopSpace;
                [self.viewController.view layoutIfNeeded];
            } completion:nil];
        });
        
        self.currentKeyboardFrame = CGRectZero;
    }
}

@end


@implementation UIViewController (_HKKeyboardManager)

- (_HKKeyboardManager *)hkd_keyboardManager
{
    return objc_getAssociatedObject(self, @selector(hkd_keyboardManager));
}

- (void)setHkd_keyboardManager:(_HKKeyboardManager *)hkd_keyboardManager
{
    objc_setAssociatedObject(self, @selector(hkd_keyboardManager), hkd_keyboardManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)manageKeyboardWithPositionConstraint:(NSLayoutConstraint *)constraint
                              positiveOffset:(BOOL)isPositiveOffset
                            bottomSpaceBlock:(CGFloat(^)(void))bottomSpaceBlock
{
    if (!self.hkd_keyboardManager) {
        self.hkd_keyboardManager = [[_HKKeyboardManager alloc] init];
    }
    
    
    self.hkd_keyboardManager.isPositiveOffset = isPositiveOffset;
    self.hkd_keyboardManager.topConstraint = constraint;
    self.hkd_keyboardManager.originalTopSpace = constraint.constant;
    self.hkd_keyboardManager.bottomSpaceBlock = bottomSpaceBlock;
    
    self.hkd_keyboardManager.shouldManageKeyboard = YES;
    self.hkd_keyboardManager.viewController = self;
}

- (void)manageKeyboardWithBottomConstraint:(NSLayoutConstraint *)bottomConstraint
                            associatedView:(UIView *)view
{
    __weak typeof(self) weakSelf = self;
    __weak typeof(view) weakView = view;
    [self manageKeyboardWithPositionConstraint:bottomConstraint positiveOffset:NO bottomSpaceBlock:^CGFloat
    {
        CGFloat bottomOffSet = 0;
        if ([weakView isKindOfClass:[UIScrollView class]]) {
            bottomOffSet = [(UIScrollView *)weakView contentInset].bottom;
        }
        bottomOffSet = MAX(0, bottomOffSet);
        
        return weakSelf.view.frame.size.height - weakView.frame.size.height - weakView.frame.origin.y + bottomOffSet;
    }];
}

- (void)updateLayoutWithKeyboard
{
    if (!self.hkd_keyboardManager) {
        return;
    }
    
    [self.view layoutIfNeeded];
    [self.hkd_keyboardManager updateLayoutWithKeyboard];
}

/**
 *  注册键盘事件观察者，并以Block形式处理
 */
- (void)observeKeyboardEventForKeyboardWillShow:(void(^)(NSNotification *notification))willShow
                                       willHide:(void(^)(NSNotification *notification))willHide
                                     willChange:(void(^)(NSNotification *notification))willChange
{
    if (!self.hkd_keyboardManager) {
        self.hkd_keyboardManager = [[_HKKeyboardManager alloc] init];
    }
    
    self.hkd_keyboardManager.willShowHandler = willShow;
    self.hkd_keyboardManager.willChangeHandler = willChange;
    self.hkd_keyboardManager.willHideHandler = willHide;
    
    self.hkd_keyboardManager.shouldObserveKeyboard = YES;
    self.hkd_keyboardManager.viewController = self;
}

/**
 *  取消/开启键盘管理
 */
- (void)setKeyboardManagerEnabled:(BOOL)enabled
{
    if (self.hkd_keyboardManager) {
        self.hkd_keyboardManager.shouldManageKeyboard = enabled;
    }
}


@end