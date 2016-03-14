//
//  UIViewController+HKProjectBase.h
//  HKProjectBase
//
//  Created by Harley.xk on 15/6/7.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HKTaskProtocol <NSObject>
- (void)cancel;
@end

@interface UIViewController (HKProjectBase)

/**
 *  使用XIB创建视图
 *  @attention XIB文件名必须与类名相同
 */
+ (instancetype)controllerFromXIB;
/**
 *  使用StoryBoard创建对象
 *  @attention identifier需要设置为类名
 */
+ (instancetype)controllerFromMainStoryboard;
+ (instancetype)initialControllerFromStoryboard:(NSString *)storyboardName;
+ (instancetype)controllerFromStoryboard:(NSString *)storyboardName;

/**
 *  使用StoryBoard创建对象
 *  指定identifier来创建对应的视图控制器对象
 */
+ (instancetype)controllerFromMainStoryboardWithIdentifier:(NSString *)identifier;
+ (instancetype)controllerFromStoryboard:(NSString *)storyboardName withIdentifier:(NSString *)identifier;



/**
 *  记录发起的任务（比如网络请求），如果在视图被销毁时任务还未执行完毕，这些任务将被取消并销毁
 */
- (void)recordTask:(id<HKTaskProtocol>)task;


@end
