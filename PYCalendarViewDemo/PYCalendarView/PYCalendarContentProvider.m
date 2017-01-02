//
//  PYCalendarContentProvider.m
//  PYCalendarViewDemo
//
//  Created by Snake on 16/12/30.
//  Copyright © 2016年 IAsk. All rights reserved.
//

#import "PYCalendarContentProvider.h"
//#import "PYCalendarMarco.h"

#ifndef WEEK_DAYS
#define WEEK_DAYS 7
#endif

NSString * const kPYCalendarContentProvider_YYYY    = @"YYYY";
NSString * const kPYCalendarContentProvider_MM      = @"MM";
NSString * const kPYCalendarContentProvider_DD      = @"DD";
NSString * const kPYCalendarContentProvider_YYYYMM    = @"YYYY-MM";
NSString * const kPYCalendarContentProvider_YYYYMMDD    = @"YYYY-MM-DD";


@interface PYCalendarContentProvider ()
@property (nonatomic, strong) NSCalendar *calendarObj;
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

- (NSArray<NSString *> *)monthAllDayWith:(NSDate *)date {
    // 本月1号是周几
    NSInteger firstWeekDayThisMonth = [self firstWeekdayInThisMonth:date];
    //这个月有多少天
    NSInteger currentMonth = [self dayOfMonthWithDate:date].length;
    // 上个月有多少天
    NSDate *lastMonthDate = [self lastMonthTransformDate:date];
    NSInteger lastMonth = [self dayOfMonthWithDate:lastMonthDate].length;
    
    // 装在
    NSMutableArray *monthArr = [[NSMutableArray alloc] init];
    // YYYYMM
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:kPYCalendarContentProvider_YYYYMM];
    NSString *yyyymmL = [formatter stringFromDate:lastMonthDate];
    NSString *yyyymmC = [formatter stringFromDate:date];
    NSString *yyyymmN = [formatter stringFromDate:[self nextMonthTransformDate:date]];
    // 本月有几周
    NSInteger weekDay = [self weekOfMonthWithDate:date].length;
    for (NSInteger i = 0; i < weekDay; i++) {
        NSMutableArray *weekArr = [[NSMutableArray alloc] init];
        NSInteger day;
        NSString *yyyymmdd = [[NSString alloc] init];
        for (NSInteger j = 0; j < WEEK_DAYS; j++) {
            
            if (i == 0) {
                if (j < firstWeekDayThisMonth) {
                    day = lastMonth - firstWeekDayThisMonth + 1 + j;
                    yyyymmdd = [NSString stringWithFormat:@"%@-%02ld", yyyymmL, day];
                } else {
                    day = j - firstWeekDayThisMonth + 1;
                    yyyymmdd = [NSString stringWithFormat:@"%@-%02ld", yyyymmC, day];
                }
                
            } else {
                
                day = i * WEEK_DAYS - firstWeekDayThisMonth  + 1 + j;
                // 最后一周
                if (day > currentMonth) {
                    day = day - currentMonth;
                    yyyymmdd = [NSString stringWithFormat:@"%@-%02ld", yyyymmN, day];
                } else {
                    yyyymmdd = [NSString stringWithFormat:@"%@-%02ld", yyyymmC, day];
                }
            }
            
            [weekArr addObject:yyyymmdd];
        }

        
        
        [monthArr addObject:weekArr];
    }
    
    return monthArr;
    
}

// 第一天是周几
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date {
    NSDateComponents *comp = [self.calendarObj components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [self.calendarObj dateFromComponents:comp];
    NSUInteger firstWeekday = [self.calendarObj ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}


///上个月
- (NSDate *)lastMonthTransformDate:(NSDate *)date {
    NSDateComponents *comp = [self.calendarObj components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setMonth:comp.month - 1];
    [comp setDay:1];
    return [self.calendarObj dateFromComponents:comp];
}
///下个月
- (NSDate *)nextMonthTransformDate:(NSDate *)date {
    NSDateComponents *comp = [self.calendarObj components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setMonth:comp.month + 1];
    [comp setDay:1];
    return [self.calendarObj dateFromComponents:comp];
}
@end
