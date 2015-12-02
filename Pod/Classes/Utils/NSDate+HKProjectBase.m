//
//  NSDate+HKProjectBase.h
//  HKProjectBase
//
//  Created by Harley.xk on 15/10/29.
//  Copyright (c) 2015年 Harley.xk. All rights reserved.
//


#import "NSDate+HKProjectBase.h"
#import <time.h>
#import <xlocale.h>

@implementation NSDate (Exts)

#pragma mark
#pragma mark - ** 日期类方法 **
+ (id)dateWithString:(NSString *)string
{
    return [NSDate dateWithString:string format:NSDATE_FORMAT_NORMAL locale:LOCALE_CURRENT];
}

+ (id)dateWithDateString:(NSString *)string
{
    return [NSDate dateWithString:string format:NSDATE_FORMAT_DATE];
}

+ (id)dateWithTimeString:(NSString *)string
{
    return [NSDate dateWithString:string format:NSDATE_FORMAT_TIME];
}

+ (id)dateWithString:(NSString *)string format:(NSString *)format
{
    return [NSDate dateWithString:string format:format locale:LOCALE_CURRENT];
}

+ (id)dateWithString:(NSString *)string locale:(NSLocale *)locale
{
    return [NSDate dateWithString:string format:NSDATE_FORMAT_NORMAL locale:LOCALE_CURRENT];
}

+ (id)dateWithString:(NSString *)string format:(NSString *)format locale:(NSLocale *)locale
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    [dateFormatter setLocale:locale];
    NSDate *retDate = [dateFormatter dateFromString:string];
    return retDate;
}

+ (id)dateFromRFC1123:(NSString *)rfc1123
{
    if(rfc1123 == nil)
        return nil;

    const char *str = [rfc1123 UTF8String];
    const char *fmt;
    NSDate *retDate;
    char *ret;

    fmt = "%a, %d %b %Y %H:%M:%S %Z";
    struct tm rfc1123timeinfo;
    memset(&rfc1123timeinfo, 0, sizeof(rfc1123timeinfo));
    ret = strptime_l(str, fmt, &rfc1123timeinfo, NULL);
    if (ret) {
        time_t rfc1123time = mktime(&rfc1123timeinfo);
        retDate = [NSDate dateWithTimeIntervalSince1970:rfc1123time];
        if (retDate != nil)
            return retDate;
    }


    fmt = "%A, %d-%b-%y %H:%M:%S %Z";
    struct tm rfc850timeinfo;
    memset(&rfc850timeinfo, 0, sizeof(rfc850timeinfo));
    ret = strptime_l(str, fmt, &rfc850timeinfo, NULL);
    if (ret) {
        time_t rfc850time = mktime(&rfc850timeinfo);
        retDate = [NSDate dateWithTimeIntervalSince1970:rfc850time];
        if (retDate != nil)
            return retDate;
    }

    fmt = "%a %b %e %H:%M:%S %Y";
    struct tm asctimeinfo;
    memset(&asctimeinfo, 0, sizeof(asctimeinfo));
    ret = strptime_l(str, fmt, &asctimeinfo, NULL);
    if (ret) {
        time_t asctime = mktime(&asctimeinfo);
        return [NSDate dateWithTimeIntervalSince1970:asctime];
    }

    return nil;
}

- (NSString *)rfc1123String
{
    time_t date = (time_t)[self timeIntervalSince1970];
    struct tm timeinfo;
    gmtime_r(&date, &timeinfo);
    char buffer[32];
    size_t ret = strftime_l(buffer, sizeof(buffer), "%a, %d %b %Y %H:%M:%S GMT", &timeinfo, NULL);
    if (ret) {
        return @(buffer);
    } else {
        return nil;
    }
}

#pragma mark - ** 日期实例方法 **
- (NSDate *)dateByAddingMinutes:(NSInteger)minutes
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + MINUTE_SECONDS * minutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

- (NSDate *)dateByAddingHours:(NSInteger)hours
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + HOUR_SECONDS * hours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

- (NSDate *)dateByAddingDays:(NSInteger)days
{
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + DAY_SECONDS * days;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

- (NSDate *)dateByAddingMonths:(NSInteger)months
{
    NSDate *date = self;
    NSInteger m = labs(months);
    NSInteger flag = months/m;
    
    for (int i = 0; i < m; i++) {
        NSInteger days = [date daysOfMonth];
        date = [date dateByAddingDays:flag * days];
    }
    return date;
}

- (NSDate *)dateBySetSecond:(NSInteger)second
{
    NSString *dateStr = [self string];
    NSRange range = NSMakeRange(17, 2);
    NSString *yearStr = [NSString stringWithFormat:@"%2i", (int)second];
    dateStr = [dateStr stringByReplacingCharactersInRange:range withString:yearStr];
    NSDate *retDate = [NSDate dateWithString:dateStr];
    return retDate;
}

- (NSDate *)dateBySetMinute:(NSInteger)minute
{
    NSString *dateStr = [self string];
    NSRange range = NSMakeRange(14, 2);
    NSString *yearStr = [NSString stringWithFormat:@"%2i", (int)minute];
    dateStr = [dateStr stringByReplacingCharactersInRange:range withString:yearStr];
    NSDate *retDate = [NSDate dateWithString:dateStr];
    return retDate;
}

- (NSDate *)dateBySetHour:(NSInteger)hour
{
    NSString *dateStr = [self string];
    NSRange range = NSMakeRange(11, 2);
    NSString *yearStr = [NSString stringWithFormat:@"%2i", (int)hour];
    dateStr = [dateStr stringByReplacingCharactersInRange:range withString:yearStr];
    NSDate *retDate = [NSDate dateWithString:dateStr];
    return retDate;
}

- (NSDate *)dateBySetDay:(NSInteger)day
{
    NSString *dateStr = [self string];
    NSRange range = NSMakeRange(8, 2);
    NSString *yearStr = [NSString stringWithFormat:@"%2i", (int)day];
    dateStr = [dateStr stringByReplacingCharactersInRange:range withString:yearStr];
    NSDate *retDate = [NSDate dateWithString:dateStr];
    return retDate;
}

- (NSDate *)dateBySetMonth:(NSInteger)month
{
    NSString *dateStr = [self string];
    NSRange range = NSMakeRange(5, 2);
    NSString *yearStr = [NSString stringWithFormat:@"%2i", (int)month];
    dateStr = [dateStr stringByReplacingCharactersInRange:range withString:yearStr];
    return [NSDate dateWithString:dateStr];
}

- (NSDate *)dateBySetYear:(NSInteger)year
{
    NSString *dateStr = [self string];
    NSRange range = NSMakeRange(0, 4);
    NSString *yearStr = [NSString stringWithFormat:@"%2i", (int)year];
    dateStr = [dateStr stringByReplacingCharactersInRange:range withString:yearStr];
    return [NSDate dateWithString:dateStr];
}

- (NSDate *)dateWithoutTime
{
    NSString *dateString = [self dateString];
    return [NSDate dateWithDateString:dateString];
}

- (NSDate *)dateOfWeekStart
{
    NSInteger nth = [self nthDayOfWeek];
    return [self dateByAddingDays:(1 - nth + 1)];
}

- (NSDate *)dateOfMonthStart
{
    NSInteger nth = [self nthDayOfMonth];
    return [self dateByAddingDays:(1 - nth)];
}

- (NSDate *)dateOfYearStart
{
    NSInteger nth = [self nthDayOfYear];
    return [self dateByAddingDays:(1 - nth)];
}

- (NSDate *)dateOfWeekEnd
{
    NSInteger nth = [self nthDayOfWeek];
    return [self dateByAddingDays:(7 - nth)];
}

- (NSDate *)dateOfMonthEnd
{
    NSInteger nth = [self nthDayOfMonth];
    NSInteger num = [self daysOfMonth];
    return [self dateByAddingDays:(num - nth)];
}

- (NSDate *)dateOfYearEnd
{
    NSInteger nth = [self nthDayOfMonth];
    NSInteger num = [self daysOfYear];
    return [self dateByAddingDays:(num - nth)];
}

#pragma mark - ** 两个日期相隔时间段 **
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay fromDate:self toDate:anotherDate options:0];
    return components.day;
}

- (NSDateComponents *)dateComponents:(NSCalendarUnit)unitFlags fromDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar components:unitFlags fromDate:date toDate:self options:0];
}

- (NSDateComponents *)dateComponents:(NSCalendarUnit)unitFlags toDate:(NSDate *)date
{
    return [date dateComponents:unitFlags fromDate:self];
}

// 日历时间（忽略时分秒）
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate byCalendar:(BOOL)byCalendar
{
    return [[self dateWithoutTime] distanceInDaysToDate:[anotherDate dateWithoutTime]];
}

- (NSDateComponents *)dateComponents:(NSCalendarUnit)unitFlags fromDate:(NSDate *)date byCalendar:(BOOL)byCalendar;
{
    return [[date dateWithoutTime] dateComponents:unitFlags fromDate:[self dateWithoutTime]];
}

- (NSDateComponents *)dateComponents:(NSCalendarUnit)unitFlags toDate:(NSDate *)date byCalendar:(BOOL)byCalendar;
{
    return [[self dateWithoutTime] dateComponents:unitFlags toDate:[date dateWithoutTime]];
}

#pragma mark - ** 两个日期相隔时间段、比较两个日期  **
- (BOOL)isBetween:(NSDate *)date1 date2:(NSDate *)date2
{
    NSTimeInterval val1 = [date1 timeIntervalSince1970];
    NSTimeInterval val2 = [date2 timeIntervalSince1970];
    NSTimeInterval val = [self timeIntervalSince1970];
    return fabs(val1 - val2) == fabs(val - val1) + fabs(val - val2);
}

- (NSDate *)dateByIgnoreOption:(NSDateCompareIgnoreOptions)option
{
    BOOL ignoreYear = option & NSDateIgnoreYear ? YES : NO;
    BOOL ignoreMonth = option & NSDateIgnoreMonth ? YES : NO;
    BOOL ignoreDay = option & NSDateIgnoreDay ? YES : NO;
    BOOL ignoreHour = option & NSDateIgnoreHour ? YES : NO;
    BOOL ignoreMinute = option & NSDateIgnoreMin ? YES : NO;
    BOOL ignoreSecond = option & NSDateIgnoreSecond ? YES : NO;
    
    NSDate *retDate = self;
    retDate = ignoreYear ? [self dateBySetYear:REFERENCE_DATE_YEAR] : retDate;
    retDate = ignoreMonth ? [self dateBySetMonth:REFERENCE_DATE_MONTH] : retDate;
    retDate = ignoreDay ? [self dateBySetDay:REFERENCE_DATE_DAY] : retDate;
    retDate = ignoreHour ? [self dateBySetHour:REFERENCE_DATE_HOUR] : retDate;
    retDate = ignoreMinute ? [self dateBySetMinute:REFERENCE_DATE_MINUTE] : retDate;
    retDate = ignoreSecond ? [self dateBySetSecond:REFERENCE_DATE_SECOND] : retDate;
    
    return retDate;
}

- (BOOL)isBetween:(NSDate *)date1 date2:(NSDate *)date2 ignore:(NSDateCompareIgnoreOptions)option
{
    NSDate *date_1 = [date1 dateByIgnoreOption:option];
    NSDate *date_2 = [date2 dateByIgnoreOption:option];
    NSDate *date_self = [self dateByIgnoreOption:option];
    return [date_self isBetween:date_1 date2:date_2];
}

- (NSComparisonResult)compare:(NSDate *)other ignore:(NSDateCompareIgnoreOptions)option
{
    NSDate *date_1 = [other dateByIgnoreOption:option];
    NSDate *date_self = [self dateByIgnoreOption:option];
    return [date_self compare:date_1];
}

- (BOOL)isEqualToDate:(NSDate *)aDate ignore:(NSDateCompareIgnoreOptions)option
{
    NSDate *date_1 = [aDate dateByIgnoreOption:option];
    NSDate *date_self = [self dateByIgnoreOption:option];
    return [date_self isEqualToDate:date_1];
}

- (BOOL) isWeekend
{
    NSDateComponents *components = [CURRENT_CALENDAR components:NSCalendarUnitWeekday fromDate:self];
    return  ((components.weekday == 1) || (components.weekday == 7)) ? YES : NO;
}

- (BOOL) isWorkday
{
    return ![self isWeekend];
}

#pragma mark - ** 按指定格式返回字符串 **
- (NSString *)stringWithFormat:(NSString *)format
{
    return [self stringWithFormat:format locale:LOCALE_CURRENT];
}

- (NSString *)stringWithFormat:(NSString *)format locale:(NSLocale *)locale
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    [dateFormatter setLocale:locale];
    NSString *retStr = [dateFormatter stringFromDate:self];
    return retStr;
}

- (NSString *)string
{
    return [self stringWithFormat:NSDATE_FORMAT_NORMAL locale:LOCALE_CURRENT];
}

- (NSString *)dateString
{
    return [self stringWithFormat:NSDATE_FORMAT_DATE];
}

- (NSString *)timeString
{
	return [self stringWithFormat:NSDATE_FORMAT_TIME];
}

- (NSString *)stringWithLocale:(NSLocale *)locale
{
    return [self stringWithFormat:NSDATE_FORMAT_NORMAL locale:locale];
}

#pragma mark - ** 纪元、年、月、日、小时、分钟、秒、星期 **
- (NSInteger)era
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.era;
}

- (NSInteger)year
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.year;
}

- (NSInteger)month
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.month;
}

- (NSInteger)day
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.day;
}

- (NSInteger)hour {
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.hour;
}

- (NSInteger)minute
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.minute;
}

- (NSInteger)second
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.second;
}

- (NSInteger)week
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.week;
}

- (NSInteger)weekday
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.weekday;
}

- (NSInteger)quarter NS_AVAILABLE(10_6, 4_0)
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.quarter;
}

- (NSInteger)weekOfMonth NS_AVAILABLE(10_7, 5_0)
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.weekOfMonth;
}

- (NSInteger)weekOfYear NS_AVAILABLE(10_7, 5_0)
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.weekOfYear;
}

- (NSInteger)yearForWeekOfYear NS_AVAILABLE(10_7, 5_0)
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.yearForWeekOfYear;
}

- (BOOL)isLeapYear
{
    NSInteger year = [self year];
    return (year%4 == 0 && year%100 != 0) || year%400 == 0;
}

#pragma mark - ** 第几天 **
- (NSInteger)nthDayOfWeek
{
    return [self weekday];
}

- (NSInteger)nthDayOfMonth
{
    return [self day];
}

- (NSInteger)nthDayOfYear
{
    NSString *nthStr_year = [self stringWithFormat:@"D"];
    return [nthStr_year integerValue];
}

#pragma mark - ** 第几周 **
- (NSInteger)nthWeekOfMonth
{
    NSString *nthStr = [self stringWithFormat:@"W"];
    return [nthStr integerValue];
}

- (NSInteger)nthWeekOfYear
{
    NSString *nthStr = [self stringWithFormat:@"w"];
    return [nthStr integerValue];
}


#pragma mark - ** 第几季度 **
- (NSInteger)nthSeason
{
    NSString *nthStr_season = [self stringWithFormat:@"q"];
    return [nthStr_season integerValue];
}

#pragma mark - ** 天数 **
- (NSInteger)daysOfMonth
{
    NSInteger nthMonth = [self month];
    
    NSInteger days[12] = {  31, 28, 31, 30, 31, 30,
                            31, 31, 30, 31, 30, 31
                         };
    
    if ([self isLeapYear]) {
        return nthMonth == 2 ? 29 : 28;
    }
    return days[nthMonth - 1];
}

- (NSInteger)daysOfYear
{
    return [self isLeapYear] ? 366 : 365;
}

@end
