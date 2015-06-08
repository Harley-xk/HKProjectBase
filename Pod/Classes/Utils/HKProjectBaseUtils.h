//
//  HKProjectBaseUtils.h
//  HKProjectBase
//
//  Created by Harley.xk on 15/6/7.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import <Foundation/Foundation.h>

// =============================================
//                 HKLOG Settings
// =============================================
#pragma mark - HKLOG
#if !defined(DEBUG) || DEBUG == 0
#define HKLog(format, ...) do {}while(0)
#define HKSimpleLOG(format,...) do {}while(0)
#elif DEBUG >= 1
#define HKSimpleLOG(...) NSLog(__VA_ARGS__)
//A better version of NSLog
#define HKLog(title,format, ...) \
          do { \
                HKLogTitle(title); \
                if (format) { \
                  HKLogContent([NSString stringWithFormat:format,##__VA_ARGS__]); \
                } \
                HKLogInfo(__FILE__,__LINE__,__func__); \
             } while (0)
#endif

extern void HKLogTitle(NSString *title);
extern void HKLogContent(NSString *content);
extern void HKLogInfo(const char *file, int line, const char *func);

