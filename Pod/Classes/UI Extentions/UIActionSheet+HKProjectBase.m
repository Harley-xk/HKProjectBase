//
//  UIActionSheet+HKProjectBase.m
//  HKProjectBase
//
//  Created by Harley.xk on 15/6/7.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import "UIActionSheet+HKProjectBase.h"
#import <objc/runtime.h>

@interface UIActionSheet (_HKProjectBase)
<UIActionSheetDelegate>
@property (copy, nonatomic) void (^callback)(NSUInteger);
@end

@implementation UIActionSheet (_HKProjectBase)
- (void)setCallback:(void (^)(NSUInteger))callback
{
    objc_setAssociatedObject(self, @selector(callback), callback, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(NSUInteger))callback
{
    return objc_getAssociatedObject(self, @selector(callback));
}
@end

@implementation UIActionSheet (HKProjectBase)

+ (instancetype)actionSheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles;
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:nil cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles: nil];
    actionSheet.delegate = actionSheet;
    for (NSString *title in otherButtonTitles) {
        [actionSheet addButtonWithTitle:title];
    }
    return actionSheet;
}

- (void)showFromToolbar:(UIToolbar *)view withCallback:(void(^)(NSUInteger buttonIndex))callback
{
    self.callback = callback;
    [self showFromToolbar:view];
}

- (void)showFromTabBar:(UITabBar *)view withCallback:(void(^)(NSUInteger buttonIndex))callback
{
    self.callback = callback;
    [self showFromTabBar:view];
}

- (void)showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated  withCallback:(void(^)(NSUInteger buttonIndex))callback
{
    self.callback = callback;
    [self showFromBarButtonItem:item animated:animated];
}

- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated  withCallback:(void(^)(NSUInteger buttonIndex))callback
{
    self.callback = callback;
    [self showFromRect:rect inView:view animated:animated];
}

- (void)showInView:(UIView *)view withCallback:(void(^)(NSUInteger buttonIndex))callback
{
    self.callback = callback;
    [self showInView:view];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.callback) {
        self.callback(buttonIndex);
    }
}

@end
