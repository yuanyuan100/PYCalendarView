//
//  PYDayOfElementView.h
//  PYCalendarViewDemo
//
//  Created by Snake on 16/12/29.
//  Copyright © 2016年 IAsk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PYDayOfElementViewWeekType) {
    PYDayOfElementViewWeek_Sunday,
    PYDayOfElementViewWeek_Monday,
    PYDayOfElementViewWeek_Tuesday,
    PYDayOfElementViewWeek_Wednesday,
    PYDayOfElementViewWeek_Thursday,
    PYDayOfElementViewWeek_Friday,
    PYDayOfElementViewWeek_Saturday,
};

typedef NS_ENUM(NSUInteger, PYDayOfElementViewMonth) {
    PYDayOfElementViewMonth_Unknow,
    PYDayOfElementViewMonth_Current,
};

typedef NS_ENUM(NSUInteger, PYDayOfElementViewLately) {
    PYDayOfElementViewLately_Unknow,
    PYDayOfElementViewLately_Yesterday,
    PYDayOfElementViewLately_Today,
    PYDayOfElementViewLately_Tomorrow,
};

typedef NS_ENUM(NSUInteger, PYDayOfElementViewState) {
    PYDayOfElementViewState_Normal,
    PYDayOfElementViewState_Selected,
};

/**
 默认没有待处理事件 PYDayOfElementViewWorkType_None
 */
typedef NS_ENUM(NSUInteger, PYDayOfElementViewWorkType) {
    /** 无事件*/
    PYDayOfElementViewWorkType_None,
    /** 有待处理事件 */
    PYDayOfElementViewWorkType_Pending,
    /** 有门诊事件 */
    PYDayOfElementViewWorkType_Outpatient,
};

@interface PYDayOfElementView : UIView

- (instancetype)initWithFrame:(CGRect)frame dateStr:(NSString *)dateStr;
/** 控件所携带的日期信息 YYYY-MM-DD */
@property (nonatomic, copy) NSString *dateStr;
/** 设置事件 */
@property (nonatomic, assign) PYDayOfElementViewWorkType workType;
/** 设置今日 */
@property (nonatomic, assign) PYDayOfElementViewLately latelyType;
/** 设置当月 */
@property (nonatomic, assign) PYDayOfElementViewMonth monthType;
/** 设置被选择 */
@property (nonatomic, assign) PYDayOfElementViewState state;
/** 该日期为周几 */
@property (nonatomic, assign) PYDayOfElementViewWeekType weekType;
@property (nonatomic, strong) void(^WillSelectBlock)(PYDayOfElementView *dayView);
@property (nonatomic, strong) void(^DidSelectBlock)(PYDayOfElementView *dayView);
@end
