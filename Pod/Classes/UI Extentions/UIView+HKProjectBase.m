//
//  UIView+HKProjectBase.m
//  HKProjectBase
//
//  Created by Harley.xk on 15/6/11.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import "UIView+HKProjectBase.h"
#import <objc/runtime.h>

@interface UIView (_HKProjectBase)
@property (strong, nonatomic) NSHashTable *unfinishedRequests;
@end

@implementation UIView (_HKProjectBase)
- (NSHashTable *)unfinishedRequests
{
    return objc_getAssociatedObject(self, @selector(unfinishedRequests));
}
- (void)setUnfinishedRequests:(NSHashTable *)unfinishedRequests
{
    objc_setAssociatedObject(self, @selector(unfinishedRequests), unfinishedRequests, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end

@implementation UIView (HKProjectBase)

+(void)load
{
    SEL originalSelector = NSSelectorFromString(@"dealloc");
    SEL overrideSelector = @selector(hk_dealloc);
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method overrideMethod = class_getInstanceMethod(self, overrideSelector);
    if (class_addMethod(self, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(self, overrideSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, overrideMethod);
    }
}

- (void)hk_dealloc {
    [self cancelUnfinishedTasks];
    [self hk_dealloc];
}



-(CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}

- (CGFloat)borderWidth
{
    return self.layer.borderWidth;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}

- (UIColor *)borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

#pragma mark - Requests
/**
 *  记录发起的任务（比如网络请求），如果在视图被销毁时任务还未执行完毕，这些任务将被取消并销毁
 */
- (void)recordTask:(id<HKTaskProtocol>)task
{
    if (!self.unfinishedRequests) {
        self.unfinishedRequests = [NSHashTable weakObjectsHashTable];
    }
    [self.unfinishedRequests addObject:task];
}

- (void)cancelUnfinishedTasks
{
    for (id<HKTaskProtocol> task in self.unfinishedRequests) {
        [task cancel];
    }
}

@end
