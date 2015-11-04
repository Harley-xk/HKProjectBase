//
//  NSDate+HKProjectBase.h
//  HKProjectBase
//
//  Created by Harley.xk on 15/10/29.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//

#import <Foundation/Foundation.h>

// 年、月、日、小时、分钟换算成秒
#define MINUTE_SECONDS  60
#define HOUR_SECONDS    3600
#define DAY_SECONDS     86400
#define WEEK_SECONDS    604800
#define YEAR_SECONDS    31556926

// 参考日期：年、月、日、小时、分钟、秒
#define REFERENCE_DATE_YEAR     1970
#define REFERENCE_DATE_MONTH    1
#define REFERENCE_DATE_DAY      1
#define REFERENCE_DATE_HOUR     0
#define REFERENCE_DATE_MINUTE   0
#define REFERENCE_DATE_SECOND   0

#define DATE_COMPONENTS (kCFCalendarUnitEra | NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfYear |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]

// 日期字符串常用格式，NSDATE_FORMAT_NORMAL为默认格式。
#define NSDATE_FORMAT_NORMAL    @"yyyy-MM-dd HH:mm:ss"
#define NSDATE_FORMAT_NORMAL_1  @"yyyy/MM/dd HH:mm:ss"
#define NSDATE_FORMAT_DATE      @"yyyy-MM-dd"
#define NSDATE_FORMAT_DATE_1    @"yyyy/MM/dd"
#define NSDATE_FORMAT_TIME      @"HH:mm:ss"

// 常用地区
#define LOCALE_CHINA [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"]
#define LOCALE_USA [[NSLocale alloc] initWithLocaleIdentifier:@"es_US"]
#define LOCALE_CURRENT [NSLocale currentLocale]

// 判断日期在两个日期之间，比较两个日期，忽略选项。
typedef NS_OPTIONS(NSUInteger, NSDateCompareIgnoreOptions) {
    NSDateIgnoreNone    =  0,
    NSDateIgnoreYear    =  1 << 0,
    NSDateIgnoreMonth   =  1 << 1,
    NSDateIgnoreDay     =  1 << 2,
    NSDateIgnoreHour    =  1 << 3,
    NSDateIgnoreMin     =  1 << 4,
    NSDateIgnoreSecond  =  1 << 5
};

// NS_AVAILABLE(10_7, 5_0).
@interface NSDate (Exts)

// 根据字符串返回date,|format|格式为yyyy-MM-dd HH:mm +0800;
// @return date.
#pragma mark
#pragma mark - ** 日期类方法 **
+ (id)dateWithString:(NSString *)string;
+ (id)dateWithDateString:(NSString *)string;
+ (id)dateWithTimeString:(NSString *)string;
+ (id)dateWithString:(NSString *)string format:(NSString *)format;
+ (id)dateWithString:(NSString *)string locale:(NSLocale *)locale;
+ (id)dateWithString:(NSString *)string format:(NSString *)format locale:(NSLocale *)locale;

/// rfc1123格式为：Tue, 21 Dec 2013 05:54:26 GMT
+ (id)dateFromRFC1123:(NSString*)rfc1123;

#pragma mark - ** 日期实例方法 **
- (NSDate *)dateByAddingMinutes:(NSInteger)minutes;
- (NSDate *)dateByAddingHours:(NSInteger)hours;
- (NSDate *)dateByAddingDays:(NSInteger)days;
- (NSDate *)dateByAddingMonths:(NSInteger)months;

- (NSDate *)dateBySetSecond:(NSInteger)second;
- (NSDate *)dateBySetMinute:(NSInteger)minute;
- (NSDate *)dateBySetHour:(NSInteger)hour;
- (NSDate *)dateBySetDay:(NSInteger)day;
- (NSDate *)dateBySetMonth:(NSInteger)month;
- (NSDate *)dateBySetYear:(NSInteger)year;

- (NSDate *)dateOfWeekStart;
- (NSDate *)dateOfMonthStart;
- (NSDate *)dateOfYearStart;
- (NSDate *)dateOfWeekEnd;
- (NSDate *)dateOfMonthEnd;
- (NSDate *)dateOfYearEnd;

/// 两个日期相隔时间段;
// @return 返回值为正，date日期在前;否则date日期在后.
#pragma mark - ** 两个日期相隔时间段 **
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate;
- (NSDateComponents *)dateComponents:(NSCalendarUnit)unitFlags fromDate:(NSDate *)date;
- (NSDateComponents *)dateComponents:(NSCalendarUnit)unitFlags toDate:(NSDate *)date;

// 日历时间（忽略时分秒）
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate byCalendar:(BOOL)byCalendar;
- (NSDateComponents *)dateComponents:(NSCalendarUnit)unitFlags fromDate:(NSDate *)date byCalendar:(BOOL)byCalendar;
- (NSDateComponents *)dateComponents:(NSCalendarUnit)unitFlags toDate:(NSDate *)date byCalendar:(BOOL)byCalendar;


#pragma mark - ** 判断某个日期在两个日期之间、比较两个日期、判断是否是周末 **
- (BOOL)isBetween:(NSDate *)date1 date2:(NSDate *)date2;
- (BOOL)isBetween:(NSDate *)date1 date2:(NSDate *)date2 ignore:(NSDateCompareIgnoreOptions)option;

- (NSComparisonResult)compare:(NSDate *)other ignore:(NSDateCompareIgnoreOptions)option;

- (BOOL)isEqualToDate:(NSDate *)aDate ignore:(NSDateCompareIgnoreOptions)option;

- (BOOL) isWeekend;
- (BOOL) isWorkday;

#pragma mark - ** 按指定格式返回字符串 **
- (NSString *)string;
- (NSString *)dateString;
- (NSString *)timeString;
- (NSString *)stringWithLocale:(NSLocale *)locale;
- (NSString *)stringWithFormat:(NSString *)format;
- (NSString *)stringWithFormat:(NSString *)format locale:(NSLocale *)locale;

/// rfc1123格式为：Tue, 21 Dec 2013 05:54:26 GMT
- (NSString *)rfc1123String;

#pragma mark - ** 纪元、年、月、日、小时、分钟、秒、星期 **
- (NSInteger)era;
- (NSInteger)year;
- (NSInteger)month;
- (NSInteger)day;
- (NSInteger)hour;
- (NSInteger)minute;
- (NSInteger)second;
- (NSInteger)week NS_DEPRECATED(10_4, 10_9, 2_0, 7_0, "Use weekOfMonth or weekOfYear, depending on which you mean");
- (NSInteger)weekday;
- (NSInteger)quarter NS_AVAILABLE(10_6, 4_0);
- (NSInteger)weekOfMonth NS_AVAILABLE(10_7, 5_0);
- (NSInteger)weekOfYear NS_AVAILABLE(10_7, 5_0);
- (NSInteger)yearForWeekOfYear NS_AVAILABLE(10_7, 5_0);
- (BOOL)isLeapYear;

#pragma mark - ** 第几天、从1开始 **
- (NSInteger)nthDayOfWeek;
- (NSInteger)nthDayOfMonth;
- (NSInteger)nthDayOfYear;

#pragma mark - ** 第几周、从1开始 **
- (NSInteger)nthWeekOfMonth;
- (NSInteger)nthWeekOfYear;

#pragma mark - ** 第几季度、从1开始 **
- (NSInteger)nthSeason;

#pragma mark - ** 天数 **
- (NSInteger)daysOfMonth;
- (NSInteger)daysOfYear;

@end

/***************************************************************************
 * 格式化日期字符串常用参数：
 * a: AM/PM (上午/下午)
 * A: 0~86399999 (一天的第A微秒)
 * c/cc: 1~7 (一周的第一天, 周天为1)
 * ccc: Sun/Mon/Tue/Wed/Thu/Fri/Sat (星期几简写)
 * cccc: Sunday/Monday/Tuesday/Wednesday/Thursday/Friday/Saturday (星期几全拼)
 * d: 1~31 (月份的第几天, 带0)
 * D: 1~366 (年份的第几天,带0)
 * e: 1~7 (一周的第几天, 带0)
 * E~EEE: Sun/Mon/Tue/Wed/Thu/Fri/Sat (星期几简写)
 * EEEE: Sunday/Monday/Tuesday/Wednesday/Thursday/Friday/Saturday (星期几全拼)
 * F: 1~5 (每月的第几周, 一周的第一天为周一)
 * g: Julian Day Number (number of days since 4713 BC January 1)
 * G~GGG: BC/AD (Era Designator Abbreviated)
 * GGGG: Before Christ/Anno Domini
 * h: 1~12 (0 padded Hour (12hr)) 带0的时, 12小时制
 * H: 0~23 (0 padded Hour (24hr))  带0的时, 24小时制
 * k: 1~24 (0 padded Hour (24hr) 带0的时, 24小时制
 * K: 0~11 (0 padded Hour (12hr)) 带0的时, 12小时制
 * L/LL: 1~12 (0 padded Month)  第几月
 * LLL: Jan/Feb/Mar/Apr/May/Jun/Jul/Aug/Sep/Oct/Nov/Dec 月份简写
 * LLLL: January/February/March/April/May/June/July/August/September/October/November/December 月份全称
 * m: 0~59 (0 padded Minute) 分钟
 * M/MM: 1~12 (0 padded Month) 第几月
 * MMM: Jan/Feb/Mar/Apr/May/Jun/Jul/Aug/Sep/Oct/Nov/Dec
 * MMMM: January/February/March/April/May/June/July/August/September/October/November/December
 * q/qq: 1~4 (0 padded Quarter) 第几季度
 * qqq: Q1/Q2/Q3/Q4 季度简写
 * qqqq: 1st quarter/2nd quarter/3rd quarter/4th quarter 季度全拼
 * Q/QQ: 1~4 (0 padded Quarter) 同小写
 * QQQ: Q1/Q2/Q3/Q4 同小写
 * QQQQ: 1st quarter/2nd quarter/3rd quarter/4th quarter 同小写
 * s: 0~59 (0 padded Second) 秒数
 * S: (rounded Sub-Second)
 * u: (0 padded Year)
 * v~vvv: (General GMT Timezone Abbreviation) 常规GMT时区的编写
 * vvvv: (General GMT Timezone Name) 常规GMT时区的名称
 * w: 1~53 (0 padded Week of Year, 1st day of week = Sunday, NB: 1st week of year starts from the last Sunday of last year) 一年的第几周, 一周的开始为周日,第一周从去年的最后一个周日起算
 * W: 1~5 (0 padded Week of Month, 1st day of week = Sunday) 一个月的第几周
 * y/yyyy: (Full Year) 完整的年份
 * yy/yyy: (2 Digits Year)  2个数字的年份
 * Y/yyyy: (Full Year, starting from the Sunday of the 1st week of year)
 * YY/YYY: (2 Digits Year, starting from the Sunday of the 1st week of year)
 * z~zzz: (Specific GMT Timezone Abbreviation) 指定GMT时区的编写
 * zzzz: (Specific GMT Timezone Name) Z: +0000 (RFC 822 Timezone) 指定GMT时区的名称
 ***************************************************************************/


