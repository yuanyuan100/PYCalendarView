//
//  PYCalendarContentProvider.m
//  PYCalendarViewDemo
//
//  Created by Snake on 16/12/30.
//  Copyright © 2016年 IAsk. All rights reserved.
//

#import "PYCalendarContentProvider.h"

NSString * const kPYCalendarContentProvider_YYYY    = @"YYYY";
NSString * const kPYCalendarContentProvider_MM      = @"MM";
NSString * const kPYCalendarContentProvider_DD      = @"DD";
NSString * const kPYCalendarContentProvider_YYYYMM    = @"YYYY-MM";
NSString * const kPYCalendarContentProvider_YYYYMMDD    = @"YYYY-MM-DD";

@interface PYCalendarContentProvider ()
@property (nonatomic, strong) NSCalendar *calendarObj;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation PYCalendarContentProvider
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initCalendar];
    }
    return self;
}


- (void)initCalendar {
    // 返回当前客户端的逻辑日历
    /*
     当每次修改系统日历设定，其实例化的对象也会随之改变
     */
    self.calendarObj = [NSCalendar autoupdatingCurrentCalendar];
    self.calendarObj.firstWeekday = 1;
    self.calendarObj.minimumDaysInFirstWeek = 1;
}

- (NSRange)weekOfMonthWithDate:(NSDate *)date {
    return [self.calendarObj rangeOfUnit:NSCalendarUnitWeekOfMonth inUnit:NSCalendarUnitMonth forDate:date];
}

- (NSRange)dayOfMonthWithDate:(NSDate *)date {
    return [self.calendarObj rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
}

//- (NSArray<NSString *> *)monthAllDayWith:(NSDate *)date {
//
//}

/// 本月第一天 (该方法是暂时方法，带有更好方法则替换)
- (NSDate *)earlierThisMonth:(NSDate *)date {
    NSString *yyyymm = [self earlierThisMonthString:date];
    [self.dateFormatter setDateFormat:kPYCalendarContentProvider_YYYYMMDD];
    return [self.dateFormatter dateFromString:yyyymm];
}

- (NSString *)earlierThisMonthString:(NSDate *)date {
    [self.dateFormatter setDateFormat:kPYCalendarContentProvider_YYYYMM];
    NSString *yyyymm = [self.dateFormatter stringFromDate:date];
    yyyymm = [NSString stringWithFormat:@"%@-01", yyyymm];
    return yyyymm;
}

/// 本月第一天是周几
- (NSUInteger)weekOfMonthFirstDay:(NSDate *)date {
    NSDate *monthFirstDay_date = [self earlierThisMonth:date];
    NSDateComponents *dateComponents = [self.calendarObj components:NSCalendarUnitWeekday fromDate:monthFirstDay_date];
    return dateComponents.weekday;
}

/// 本月最后一天
- (NSDate *)lastDayOfThisMonth:(NSDate *)date {
    NSString *yyyymm = [self lastDayOfThisMonthString:date];
    return [self.dateFormatter dateFromString:yyyymm];
}

- (NSString *)lastDayOfThisMonthString:(NSDate *)date {
    [self.dateFormatter setDateFormat:kPYCalendarContentProvider_YYYYMM];
     NSString *yyyymm = [self.dateFormatter stringFromDate:date];
    yyyymm = [NSString stringWithFormat:@"%@-%2ld", yyyymm, [self dayOfMonthWithDate:date].length];
    return yyyymm;
}

///上月某一天
- (NSDate *)oneDayLastMonth:(NSDate *)date {
    NSDateComponents *dateComponents = [self.calendarObj components:(NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:date];
    // 支持跨年
    [dateComponents setMonth:[dateComponents month] - 1];
    return [self.calendarObj dateFromComponents:dateComponents];
}

////下个月
- (NSDate *)oneDayNextMonth:(NSDate *)date {
    NSDateComponents *dateComponents = [self.calendarObj components:(NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:date];
    // 支持跨年
    [dateComponents setMonth:[dateComponents month] + 1];
    return [self.calendarObj dateFromComponents:dateComponents];
}

#pragma mark - getter 
- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    return _dateFormatter;
}
@end
