//
//  UIAlertView+HKProjectBase.m
//  HKProjectBase
//
//  Created by Harley.xk on 15/6/7.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import "UIAlertView+HKProjectBase.h"
#import <objc/runtime.h>

@interface UIAlertView (_HKProjectBase)
@property (copy, nonatomic) void (^callback)(NSUInteger);
@end

@implementation UIAlertView (_HKProjectBase)
- (void)setCallback:(void (^)(NSUInteger))callback
{
    objc_setAssociatedObject(self, @selector(callback), callback, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(NSUInteger))callback
{
    return objc_getAssociatedObject(self, @selector(callback));
}
@end

@implementation UIAlertView (HKProjectBase)

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles: nil];
    alert.delegate = alert;
    for (NSString *title in otherButtonTitles) {
        [alert addButtonWithTitle:title];
    }
    return alert;
}

- (void)showWithCallback:(void(^)(NSUInteger index))callback
{
    self.callback = callback;
    [self show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (self.callback) {
        self.callback(buttonIndex);
    }
}

@end
