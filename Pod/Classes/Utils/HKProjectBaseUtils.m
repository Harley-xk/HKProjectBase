//
//  HKProjectBaseUtils.m
//  HKProjectBase
//
//  Created by Harley.xk on 15/6/7.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import "HKProjectBaseUtils.h"
#import "NSDate+Exts.h"

#pragma mark - EPMLOG
void HKLogTitle(NSString *title)
{
    if (title.length <= 0) {
        return;
    }
    fprintf(stderr, "\n==================================================");
    fprintf(stderr, "\n ## %s ##",[title UTF8String]);
    fprintf(stderr, "\n");
//    fprintf(stderr, "\n------------------------------");
}

void HKLogContent(NSString *content)
{
    fprintf(stderr, "\n%s",[content UTF8String]);
//    fprintf(stderr, "\n");
    fprintf(stderr, "\n\n------------------------");
}

void HKLogInfo(const char *file,int line,const char *func)
{
    fprintf(stderr, "\n %s\n",[[[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:mm:ss.SSS"] UTF8String]);
    fprintf(stderr, " <%s : %d> \n %s",
            [[[NSString stringWithUTF8String:file] lastPathComponent] UTF8String],
            line, func);
    fprintf(stderr, "\n\n");
//    fprintf(stderr, "\n--------------------------------------------------\n\n");
}