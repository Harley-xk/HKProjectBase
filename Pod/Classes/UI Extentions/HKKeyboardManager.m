//
//  HKKeyboardManager.m
//  HKProjectBase-Sample
//
//  Created by Harley.xk on 15/12/24.
//  Copyright © 2015年 Harley.xk. All rights reserved.
//

#import "HKKeyboardManager.h"
#import <objc/runtime.h>

@interface HKKeyboardManager ()
@property (weak,   nonatomic) UIViewController *viewController;
@property (weak,   nonatomic) UIView *viewToAdjust;
@property (weak,   nonatomic) NSLayoutConstraint *positionConstraint;

@property (assign, nonatomic) CGFloat originalConstant;
@property (assign, nonatomic) CGFloat originalBottomSpace;
@property (assign, nonatomic) CGFloat currentKeyboardHeight;
@end

@implementation HKKeyboardManager

+ (instancetype)managerWithViewController:(UIViewController *)viewController positionConstraint:(NSLayoutConstraint *)constraint viewToAdjust:(UIView *)view
{
    return [[self alloc] initWithViewController:viewController positionConstraint:constraint viewToAdjust:view];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithViewController:(UIViewController *)viewController positionConstraint:(NSLayoutConstraint *)constraint viewToAdjust:(UIView *)view
{
    self = [super init];
    if (self) {
        self.viewController = viewController;
        self.viewToAdjust = view;
        self.positionConstraint = constraint;
        self.originalConstant = constraint.constant;
        self.animateAlongwithKeyboard = YES;
        self.enabled = YES;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self registerKeyboardEvents];
        });
    }
    return self;
}

- (void)registerKeyboardEvents
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (CGFloat)viewBottomSpace
{
    CGFloat bottomOffSet = 0;
    
    if ([self.viewToAdjust isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self.viewToAdjust;
        bottomOffSet = scrollView.contentInset.bottom;
        bottomOffSet = MAX(0, bottomOffSet);
    }
    
    return self.viewController.view.frame.size.height - self.viewToAdjust.frame.size.height - self.viewToAdjust.frame.origin.y + bottomOffSet;
}

#pragma mark - Keyboard Events
- (void)keyboardWillShow:(NSNotification *)notification
{
    self.originalBottomSpace = [self viewBottomSpace];
    
    if (self.animateAlongwithKeyboard) {
        [self updateForKeyboardWithNotification:notification];
    }
}
- (void)keyboardDidShow:(NSNotification *)notification
{
    [self updateForKeyboardWithNotification:notification];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    [self updateForKeyboardWithNotification:notification];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    if (self.isEnabled) {
        NSDictionary *userInfo = notification.userInfo;
        NSTimeInterval timeInterval = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
        NSUInteger option = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:timeInterval delay:0 options:option animations:^{
                self.positionConstraint.constant = self.originalConstant;
                [self.viewController.view layoutIfNeeded];
            } completion:nil];
        });
        
        self.currentKeyboardHeight = 0;
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}


- (void)updateForKeyboardWithNotification:(NSNotification *)notification
{
    if (self.isEnabled) {
        NSDictionary *userInfo = notification.userInfo;
        
        CGRect endFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGRect frameInView = [self.viewController.view convertRect:endFrame fromView:self.viewController.view.window];
        
        CGFloat keyBoardHeight = self.viewController.view.frame.size.height - frameInView.origin.y;
        keyBoardHeight = MAX(0, keyBoardHeight);
        
        CGFloat bottomSpace = self.originalBottomSpace;
        if (bottomSpace > keyBoardHeight) {
            return;
        }
        
        CGFloat offset = keyBoardHeight - bottomSpace;
        
        NSTimeInterval timeInterval = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
        NSUInteger option = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
        
        [UIView animateWithDuration:timeInterval delay:0 options:option animations:^{
            self.positionConstraint.constant = self.originalConstant + offset;
            [self.viewController.view layoutIfNeeded];
        } completion:nil];
        
        self.currentKeyboardHeight = keyBoardHeight;
    }
}

@end


@implementation UIViewController (HKKeyboardManager)

/**
 *  创建键盘管理器，自动关联到当前视图控制器
 */
- (void)setupHKKeyboardManagerWithPositionConstraint:(NSLayoutConstraint *)constraint
                                        viewToAdjust:(UIView *)view
{
    HKKeyboardManager *manager = [HKKeyboardManager managerWithViewController:self positionConstraint:constraint viewToAdjust:view];
    self.keyboardManagerHK = manager;
}

/**
 *  获取当前已关联的键盘管理器
 */
- (HKKeyboardManager *)keyboardManagerHK
{
    return objc_getAssociatedObject(self, @selector(keyboardManagerHK));
}

- (void)setKeyboardManagerHK:(HKKeyboardManager *)manager
{
    objc_setAssociatedObject(self, @selector(keyboardManagerHK), manager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end



