//
//  UIViewController+HKProjectBase.m
//  HKProjectBase
//
//  Created by Harley.xk on 15/6/7.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import "UIViewController+HKProjectBase.h"
#import <objc/runtime.h>

@interface UIViewController (_HKProjectBase)
@property (strong, nonatomic) NSHashTable *unfinishedRequests;
@end

@implementation UIViewController (_HKProjectBase)
- (NSHashTable *)unfinishedRequests
{
    return objc_getAssociatedObject(self, @selector(unfinishedRequests));
}
- (void)setUnfinishedRequests:(NSHashTable *)unfinishedRequests
{
    objc_setAssociatedObject(self, @selector(unfinishedRequests), unfinishedRequests, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end


@implementation UIViewController (HKProjectBase)

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


/**
 *  使用XIB创建视图
 *  @attention XIB文件名必须与类名相同
 */
+ (instancetype)controllerFromXIB
{
    NSString *name = [self classNameWithoutModule];
    return [[self alloc] initWithNibName:name bundle:nil];
}

/**
 *  使用StoryBoard创建对象
 *  @attention identifier需要设置为类名
 */
+ (instancetype)controllerFromMainStoryboard
{
    return [self controllerFromStoryboard:@"Main"];
}

+ (instancetype)initialControllerFromStoryboard:(NSString *)storyboardName
{
    UIStoryboard *board = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    return [board instantiateInitialViewController];
}

+ (instancetype)controllerFromStoryboard:(NSString *)storyboardName
{
    NSString *identifier = [self classNameWithoutModule];
    UIStoryboard *board = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    return [board instantiateViewControllerWithIdentifier:identifier];
}

+ (NSString *)classNameWithoutModule
{
    NSString *name = [[self class] description];
    NSArray *compments = [name componentsSeparatedByString:@"."];
    name = compments.lastObject;
    return name;
}

+ (instancetype)controllerFromMainStoryboardWithIdentifier:(NSString *)identifier
{
    return [self controllerFromStoryboard:@"Main" withIdentifier:identifier];
}

+ (instancetype)controllerFromStoryboard:(NSString *)storyboardName withIdentifier:(NSString *)identifier
{
    UIStoryboard *board = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    return [board instantiateViewControllerWithIdentifier:identifier];
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
