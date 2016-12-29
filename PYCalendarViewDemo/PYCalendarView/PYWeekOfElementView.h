//
//  PYWeekOfElementView.h
//  PYCalendarViewDemo
//
//  Created by Snake on 16/12/29.
//  Copyright © 2016年 IAsk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PYWeekOfElementView : UIView

@end

@protocol PYWeekOfElementViewDataSouce <NSObject>
@required
/**
 设置本周的日期

 @param weekView 周对象
 @return YYYY-MM-DD 日期
 */
- (NSArray<NSString *> *)py_setDateWeekOfElementView:(PYWeekOfElementView *)weekView;

/**
 设置本月的日期
 
 @param weekView 周对象
 @return YYYY-MM-DD 日期
 */
- (NSArray<NSString *> *)py_setCurrentMonthWeekOfElementView:(PYWeekOfElementView *)weekView;
@end
