//
//  PYCalendarContentProvider.h
//  PYCalendarViewDemo
//
//  Created by Snake on 16/12/30.
//  Copyright © 2016年 IAsk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PYCalendarContentProvider : NSObject

/**
 该月所包含周的数量

 @param date 该月
 @return 本月周数
 */
- (NSRange)weekOfMonthWithDate:(NSDate *)date;

/**
 该月所包含天的数量

 @param date 该月
 @return 本月天数
 */
- (NSRange)dayOfMonthWithDate:(NSDate *)date;

// 本月1号周几
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;
// 上个月
- (NSDate *)lastMonthTransformDate:(NSDate *)date;
///下个月
- (NSDate *)nextMonthTransformDate:(NSDate *)date;


// 一个月包含周，周包含天
- (NSArray<NSString *> *)monthAllDayWith:(NSDate *)date;
@end
