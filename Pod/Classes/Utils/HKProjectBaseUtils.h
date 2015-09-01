//
//  HKProjectBaseUtils.h
//  HKProjectBase
//
//  Created by Harley.xk on 15/6/7.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// =============================================
//                 HKLOG Settings
// =============================================
#pragma mark - HKLOG
#if !defined(DEBUG) || DEBUG == 0
#define HKLOG(format, ...) do {}while(0)
#define HKSimpleLOG(format,...) do {}while(0)
#elif DEBUG >= 1
#define HKSimpleLOG(...) NSLog(__VA_ARGS__)
//A better version of NSLog
#define HKLOG(title,format, ...) \
          do { \
                _HKLogTitle(title); \
                if (format) { \
                  _HKLogContent([NSString stringWithFormat:format,##__VA_ARGS__]); \
                } \
                _HKLogInfo(__FILE__,__LINE__,__func__); \
             } while (0)
#endif


/**
 *  Private functions, use HKLOG() or HKSimpleLOG()
 */
extern void _HKLogTitle(NSString *title);
extern void _HKLogContent(NSString *content);
extern void _HKLogInfo(const char *file, int line, const char *func);


#pragma mark - System Utils
/**
 *  获取设备唯一标识号
 */
extern NSString* HKDeviceUUID();

/**
 *  系统版本号
 */
extern float HKSystemVersion();

/**
 *  App版本号
 */
extern NSString* HKAppVersion();
extern NSString* HKAppVersionFull();

/**
 *  设备型号
 *
 *  @return iPhone 1,2 etc...
 */
extern NSString* HKDeviceModel();

/**
 *  设备IP
 */
extern NSString* HKDeviceIP();

/**
 *  获取设备方向
 */
extern UIDeviceOrientation HKDeviceOrientation();

/**
 *  获取界面方向
 */
extern UIInterfaceOrientation HKInterfaceOrientation();

/**
 *  电话呼叫
 *
 *  @param phoneNum 被叫方的电话号码
 *  @param immediately 是否跳过确认提示
 *
 *  @return 不支持电话功能时返回NO。
 */
extern BOOL HKMakePhoneCall(NSString *phoneNum, BOOL immediately);


#pragma mark - Path Utils
extern NSString* HKPathAtMainBundle(NSString *resourceName);

extern NSString* HKDocumentsPath();
extern NSString* HKPathAtDocuments(NSString *subPath);

extern NSString* HKLibraryPath();
extern NSString* HKPathAtLibrary(NSString *subPath);

// Library/Application Support 目录默认不存在，需要手动创建
extern NSString* HKApplicationSupportPath();
extern NSString* HKPathAtApplicationSupport(NSString *subPath);

extern NSString* HKTempPath();
extern NSString* HKPathAtTemp(NSString *subPath);

/**
 *  判断路径是否存在，可能是文件夹，也可能是文件
 */
extern BOOL HKPathExist(NSString *path);
/**
 *  判断文件是否存在，不是文件或路径不存在都返回NO
 */
extern BOOL HKFileExistAtPath(NSString *path);

/**
 *  获取文件MineType，不存在返回nil，以文件后缀名为依据
 */
extern NSString* HKFileMIMEType(NSString *fileName);

/**
 *  路径空间大小，不存在时返回0
 */
extern long long HKPathSize(NSString *path);

/**
 *  文件夹较大时计算大小会比较耗时，此时建议使用该函数
 *  在后台计算完毕大小后通过block回调到主线程
 *
 *  @param path    文件夹路径
 *  @param ^finish 计算完毕后的回调，在主线程中回调
 */
extern void HKGetFolderSize(NSString *path, void(^finish)(long long size));

/**
 *  转换字节数为最大单位可读字符串
 */
extern NSString* HKBytesToString(long long bytes);


#pragma mark - GCD Short Cut
/**
 *  延迟执行block中的代码
 *
 *  @param seconds 延迟的时间，单位秒
 *  @param ^block  被执行的代码
 *
 *  @attention 将使用主队列执行block中的代码
 */
extern void HKExcuteAfterOnMainQueue(NSTimeInterval seconds, void(^block)(void));

/**
 *  延迟执行block中的代码
 *
 *  @param seconds 延迟的时间，单位秒
 *  @param ^block  被执行的代码
 *
 *  @attention 将使用高优先级全局队列执行block中的代码
 */
extern void HKExcuteAfterOnHighPriorityGloableQueue(NSTimeInterval seconds, void(^block)(void));

/**
 *  延迟执行block中的代码
 *
 *  @param seconds 延迟的时间，单位秒
 *  @param ^block  被执行的代码
 *
 *  @attention 将使用指定的队列执行block中的代码
 */
extern void HKExcuteAfterOnQueue(NSTimeInterval seconds, dispatch_queue_t queue, void(^block)(void));

/**
 *  异步执行block中的代码
 *
 *  @param ^block  被执行的代码
 *
 *  @attention 将使用主队列执行block中的代码
 */
extern void HKExcuteAsyncOnMainQueue(void(^block)(void));

/**
 *  异步执行block中的代码
 *
 *  @param ^block  被执行的代码
 *
 *  @attention 将使用高优先级全局队列执行block中的代码
 */
extern void HKExcuteAsyncOnHighPriorityGloableQueue(void(^block)(void));

/**
 *  异步执行block中的代码
 *
 *  @param ^block  被执行的代码
 *
 *  @attention 将使用指定的队列执行block中的代码
 */
extern void HKExcuteAsyncOnQueue(dispatch_queue_t queue, void(^block)(void));
