//
//  HKProjectBaseUtils.m
//  HKProjectBase
//
//  Created by Harley.xk on 15/6/7.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import "HKProjectBaseUtils.h"
#import "NSDate+Exts.h"

// 设备型号
#import <sys/utsname.h>
// 获取文件MimeType
#import <MobileCoreServices/MobileCoreServices.h>
// 取文件夹大小库
#include <sys/stat.h>
#include <dirent.h>
// 设备IP
#import <ifaddrs.h>
#import <arpa/inet.h>


#pragma mark - EPMLOG
void _HKLogTitle(NSString *title)
{
    if (title.length <= 0) {
        return;
    }
    fprintf(stderr, "\n==================================================");
    fprintf(stderr, "\n ## %s ##",[title UTF8String]);
    fprintf(stderr, "\n");
//    fprintf(stderr, "\n------------------------------");
}

void _HKLogContent(NSString *content)
{
    fprintf(stderr, "\n%s",[content UTF8String]);
//    fprintf(stderr, "\n");
    fprintf(stderr, "\n\n------------------------");
}

void _HKLogInfo(const char *file,int line,const char *func)
{
    fprintf(stderr, "\n %s\n",[[[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:mm:ss.SSS"] UTF8String]);
    fprintf(stderr, " <%s : %d> \n %s",
            [[[NSString stringWithUTF8String:file] lastPathComponent] UTF8String],
            line, func);
    fprintf(stderr, "\n\n");
//    fprintf(stderr, "\n--------------------------------------------------\n\n");
}

#pragma mark - System Utils
/**
 *  获取设备唯一标识号
 */
NSString* HKDeviceUUID()
{
    NSUUID *uuid = [[UIDevice currentDevice] identifierForVendor];
    return [uuid UUIDString];
}

/**
 *  系统版本号
 */
float HKSystemVersion()
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

/**
 *  App版本号
 */
extern NSString* HKAppVersion()
{
    NSDictionary *dictionary = [[NSBundle mainBundle] infoDictionary];
    return [dictionary objectForKey:@"CFBundleShortVersionString"];
}

extern NSString* HKAppVersionFull()
{
    NSDictionary *dictionary = [[NSBundle mainBundle] infoDictionary];
    return [dictionary objectForKey:@"CFBundleVersion"];
}

/**
 *  设备型号
 *
 *  @return iPhone 1,2 etc...
 */
NSString* HKDeviceModel()
{
    struct utsname systemInfo;
    uname(&systemInfo);
    //get the device model and the system version
    NSString *machine =[NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return machine;
}

NSString* HKDeviceIP()
{
    NSString *address = nil;
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

/**
 *  获取设备方向
 */
UIDeviceOrientation HKDeviceOrientation()
{
    return [[UIDevice currentDevice] orientation];
}

/**
 *  获取界面方向
 */
UIInterfaceOrientation HKInterfaceOrientation()
{
    return [[UIApplication sharedApplication] statusBarOrientation];
}

/**
 *  电话呼叫
 */
BOOL HKMakePhoneCall(NSString *phoneNum, BOOL immediately)
{
    NSString *typeString = immediately? @"tel" : @"telprompt";
    NSURL *callURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@",typeString,phoneNum]];
    
    if (![[UIApplication sharedApplication] canOpenURL:callURL]) {
        return NO;
    }
    
    [[UIApplication sharedApplication] openURL:callURL];
    
    return YES;

}

#pragma mark - Path Utils
NSString* HKPathAtMainBundle(NSString *resourceName)
{
    NSString *extention = [resourceName pathExtension];
    NSString *nameWithoutExtention = resourceName;
    if (extention) {
        nameWithoutExtention = [resourceName stringByDeletingPathExtension];
    }
    return [[NSBundle mainBundle] pathForResource:nameWithoutExtention ofType:extention];
}

NSString* HKDocumentsPath()
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

NSString* HKPathAtDocuments(NSString *subPath)
{
    return [HKDocumentsPath() stringByAppendingPathComponent:subPath];
}

NSString* HKLibraryPath()
{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

NSString* HKPathAtLibrary(NSString *subPath)
{
    return [HKLibraryPath() stringByAppendingPathComponent:subPath];
}

// Library/Application Support 目录默认不存在，需要手动创建
NSString* HKApplicationSupportPath()
{
    return [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

NSString* HKPathAtApplicationSupport(NSString *subPath)
{
    return [HKApplicationSupportPath() stringByAppendingPathComponent:subPath];
}

NSString* HKTempPath()
{
    return NSTemporaryDirectory();
}

NSString* HKPathAtTemp(NSString *subPath)
{
    return [HKTempPath() stringByAppendingPathComponent:subPath];
}

/**
 *  判断路径是否存在，可能是文件夹，也可能是文件
 */
extern BOOL HKPathExist(NSString *path)
{
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

/**
 *  判断文件是否存在，不是文件或路径不存在都返回NO
 */
extern BOOL HKFileExistAtPath(NSString *path)
{
    BOOL isDirectory;
    BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
    return (exist && !isDirectory);
}

/**
 *  获取文件MineType，不存在返回nil，以文件后缀名为依据
 */
extern NSString* HKFileMIMEType(NSString *fileName)
{
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[fileName pathExtension], NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    
    return (__bridge NSString*)MIMEType;
}


long long _HKFolderSize(const char *folderPath)
{
    long long folderSize = 0;
    DIR* dir = opendir(folderPath);
    if (dir == NULL) return 0;
    struct dirent* child;
    while ((child = readdir(dir))!=NULL) {
        if (child->d_type == DT_DIR && (
                                        (child->d_name[0] == '.' && child->d_name[1] == 0) || // 忽略目录 .
                                        (child->d_name[0] == '.' && child->d_name[1] == '.' && child->d_name[2] == 0) // 忽略目录 ..
                                        )) continue;
        
        size_t folderPathLength = strlen(folderPath);
        char childPath[1024]; // 子文件的路径地址
        stpcpy(childPath, folderPath);
        if (folderPath[folderPathLength-1] != '/'){
            childPath[folderPathLength] = '/';
            folderPathLength++;
        }
        stpcpy(childPath+folderPathLength, child->d_name);
        childPath[folderPathLength + child->d_namlen] = 0;
        if (child->d_type == DT_DIR){ // directory
            folderSize += _HKFolderSize(childPath); // 递归调用子目录
            // 把目录本身所占的空间也加上
            struct stat st;
            if(lstat(childPath, &st) == 0) folderSize += st.st_size;
        }else if (child->d_type == DT_REG || child->d_type == DT_LNK){ // file or link
            struct stat st;
            if(lstat(childPath, &st) == 0) folderSize += st.st_size;
        }
    }
    return folderSize;
}

long long HKFileSize(NSString *filePath)
{
    return [[[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil] fileSize];
}

long long HKFolderSize(NSString *path)
{
    const char *folderPath = [path cStringUsingEncoding:NSUTF8StringEncoding];
    return _HKFolderSize(folderPath);
}

/**
 *  路径空间大小，不存在返回0
 */
extern long long HKPathSize(NSString *path)
{
    // 文件夹和文件采用不同的方法
    if (HKFileExistAtPath(path))
    {
        return HKFileSize(path);
    }
    else if (HKPathExist(path))
    {
        return HKFolderSize(path);
    }
    else {
        return 0;
    }
}

/**
 *  文件夹较大时计算大小会比较耗时，此时建议使用该函数
 *
 *  @param path    文件夹路径
 *  @param ^finish 计算完毕后的回调
 */
extern void HKGetFolderSize(NSString *path, void(^finish)(long long size))
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        long long size = 0;
        
        if (HKFileExistAtPath(path))
        {
            size = HKFileSize(path);
        }
        else if (HKPathExist(path))
        {
            size = HKFolderSize(path);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (finish) {
                finish(size);
            }
        });
    });
}

/**
 *  转换字节数为最大单位可读字符串
 */
extern NSString* HKBytesToString(long long bytes)
{
    float kb = bytes/1024.0;
    if (kb < 1) {
        return [NSString stringWithFormat:@"%lliB",bytes];
    }
    float mb = kb/1024.0;
    if (mb < 1) {
        return [NSString stringWithFormat:@"%.1fK",kb];
    }
    float gb = mb/1024.0;
    if (gb < 1) {
        return [NSString stringWithFormat:@"%.1fM",mb];
    }
    float tb = gb/1024.0;
    if (tb < 1) {
        return [NSString stringWithFormat:@"%.1fG",gb];
    }else{
        return [NSString stringWithFormat:@"%.1fT",tb];
    }
}


#pragma mark - GCD Short Cut
extern void HKExcuteOnMainQueueAfter(NSTimeInterval seconds, void(^block)(void))
{
    HKExcuteAfterOnQueue(seconds, dispatch_get_main_queue(), block);
}

extern void HKExcuteAfterOnHighPriorityGloableQueue(NSTimeInterval seconds, void(^block)(void))
{
    HKExcuteAfterOnQueue(seconds, dispatch_get_global_queue(0, DISPATCH_QUEUE_PRIORITY_HIGH), block);
}

extern void HKExcuteAfterOnQueue(NSTimeInterval seconds, dispatch_queue_t queue, void(^block)(void))
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), queue, ^{
        if (block) {
            block();
        }
    });
}

extern void HKExcuteAsyncOnMainQueue(void(^block)(void))
{
    HKExcuteAsyncOnQueue(dispatch_get_main_queue(), block);
}

extern void HKExcuteAsyncOnHighPriorityGloableQueue(void(^block)(void))
{
    HKExcuteAsyncOnQueue(dispatch_get_global_queue(0, DISPATCH_QUEUE_PRIORITY_HIGH), block);
}

extern void HKExcuteAsyncOnQueue(dispatch_queue_t queue, void(^block)(void))
{
    dispatch_async(queue, block);
}



