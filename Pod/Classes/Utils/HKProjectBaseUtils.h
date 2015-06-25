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

