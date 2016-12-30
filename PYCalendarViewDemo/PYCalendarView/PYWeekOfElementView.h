//
//  PYWeekOfElementView.h
//  PYCalendarViewDemo
//
//  Created by Snake on 16/12/29.
//  Copyright © 2016年 IAsk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PYWeekOfElementViewType) {
    PYWeekOfElementView_Sunday,
    PYWeekOfElementView_Monday,
    PYWeekOfElementView_Tuesday,
    PYWeekOfElementView_Wednesday,
    PYWeekOfElementView_Thursday,
    PYWeekOfElementView_Friday,
    PYWeekOfElementView_Saturday,
    PYWeekOfElementView_NotThisWeek,
};

/**
 默认没有待处理事件 PYDayOfElementViewWorkType_None
 */
typedef NS_ENUM(NSUInteger, PYWeekOfElementViewTask) {
    /** 无事件*/
    PYWeekOfElementViewTask_None,
    /** 有待处理事件 */
    PYWeekOfElementViewTask_Pending,
    /** 有门诊事件 */
    PYWeekOfElementViewTask_Outpatient,
};

@protocol PYWeekOfElementViewDataSouce;
@protocol PYWeekOfElementViewDelegate;

@interface PYWeekOfElementView : UIView
/** 本月的第index周 */
@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, weak) id <PYWeekOfElementViewDataSouce> dataSource;
@property (nonatomic, weak) id <PYWeekOfElementViewDelegate> delegate;
/**
 刷新dataSource
 
 author --pyy
 */
- (void)reloadDataSource;
- (void)reloadTask;
@end

@protocol PYWeekOfElementViewDataSouce <NSObject>
@required
/**
 设置本周的日期

 @param weekView 周对象
 @return YYYY-MM-DD 日期
 */
- (NSArray<NSString *> *)py_weekOfElementView:(PYWeekOfElementView *)weekView didSetDateWithIndex:(NSUInteger)index;

/**
 设置本月的日期
 
 @param weekView 周对象
 @return 本月日期的范围
 */
- (NSRange)py_weekOfElementView:(PYWeekOfElementView *)weekView didSetCurrentMonthWithIndex:(NSUInteger)index;

/**
 设置今天

 @param weekView 周对象
 @param index 本月的第几周
 @return 今天是本周的周几
 */
- (PYWeekOfElementViewType)py_weekOfElementView:(PYWeekOfElementView *)weekView didSetTodayWithIndex:(NSUInteger)index;
@end

@protocol PYWeekOfElementViewDelegate <NSObject>
@optional

/**
 设置当前是否有任务

 @param weekView 周对象
 @param index 本月的第几周
 @return 一周中每天的任务状态 PYWeekOfElementViewTask
 */
- (NSArray<NSNumber *> *)py_weekOfElementView:(PYWeekOfElementView *)weekView setTaskWithIndex:(NSUInteger)index;

/**
 用户将要选择某天

 @param weekView 周对象
 @param someDay 将要选择的某一天
 @param index 本月的第几周
 */
- (void)py_weekOfElementView:(PYWeekOfElementView *)weekView willSelectSomeDay:(NSString *)someDay index:(NSUInteger)index;
/**
 用户已经选择某天
 
 @param weekView 周对象
 @param someDay 将要选择的某一天
 @param index 本月的第几周
 */
- (void)py_weekOfElementView:(PYWeekOfElementView *)weekView didSelectSomeDay:(NSString *)someDay index:(NSUInteger)index;
@end
