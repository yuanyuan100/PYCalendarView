//
//  PYWeekOfElementView.m
//  PYCalendarViewDemo
//
//  Created by Snake on 16/12/29.
//  Copyright © 2016年 IAsk. All rights reserved.
//

#import "PYWeekOfElementView.h"
#import "PYCalendarMarco.h"
#import "PYDayOfElementView.h"

#ifndef WEEKVIEW_WIDTH
#define WEEKVIEW_WIDTH self.bounds.size.width
#endif
#ifndef WEEKVIEW_HEIGHT
#define WEEKVIEW_HEIGHT self.bounds.size.height
#endif
#ifndef WEEKVIEW_WIDTH_7
#define WEEKVIEW_WIDTH_7 WEEKVIEW_WIDTH/7
#endif

#ifndef WEEK_DAYS
#define WEEK_DAYS 7
#endif

struct {
    unsigned int didSetData             :   1;
    unsigned int didSetCurrentMonth     :   1;
    unsigned int didSetToday            :   1;
    unsigned int didSetTask             :   1;
    unsigned int willSelectSomeDay      :   1;
    unsigned int didSelectSomeDay       :   1;

} _dataSourceOrDelegateFlags;

@interface PYWeekOfElementView ()
/** 天元素资源 */
@property (nonatomic, strong) NSMutableArray *dayOfElementSource;


@property (nonatomic, strong) void(^WillSelectBlock)(PYDayOfElementView *dayView);
@property (nonatomic, strong) void(^DidSelectBlock)(PYDayOfElementView *dayView);
@end

@implementation PYWeekOfElementView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

#pragma mark --------- UI
- (void)creatUI {
    for (NSInteger i = 0; i < WEEK_DAYS; i++) {
        PYDayOfElementView *dayView = [[PYDayOfElementView alloc] initWithFrame:CGRectMake(0 + WEEKVIEW_WIDTH_7 * i,\
                                                                                        WEEKVIEW_HEIGHT/2 - ELEMENT_HEIGHT/2,\
                                                                                        ELEMENT_WIDTH,\
                                                                                        ELEMENT_HEIGHT)];
        [self.dayOfElementSource addObject:dayView];
        [self addSubview:dayView];
        
        dayView.WillSelectBlock = self.WillSelectBlock;
        dayView.DidSelectBlock = self.DidSelectBlock;
    }
}

- (void)reloadDataSource {
    if (_dataSourceOrDelegateFlags.didSetData) {
        NSArray<NSString *> *dateS = [self.dataSource py_weekOfElementView:self didSetDateWithIndex:self.index];
        NSAssert(dateS.count == WEEK_DAYS, @"一周一定为7天");
        for (NSInteger i = 0; i < WEEK_DAYS; i++) {
            [self.dayOfElementSource[i] setDateStr:dateS[i]];
        }
        
        
        if (_dataSourceOrDelegateFlags.didSetCurrentMonth) {
            NSRange range = [self.dataSource py_weekOfElementView:self didSetCurrentMonthWithIndex:self.index];
            NSUInteger maxLength = NSMaxRange(range);
            NSAssert(maxLength <= WEEK_DAYS, @"超出一周范围");
            if (maxLength == 0) {
                // do nothing
                // 本周都在本月中
                // 默认都在本月中
            }else if (maxLength < WEEK_DAYS) {
                for (NSInteger i = 0, count = range.length; i < count; i++) {
                    [self.dayOfElementSource[i] setMonthType:PYDayOfElementViewMonth_Unknow];
                }
            } else if (maxLength == 7) {
                for (NSInteger i = WEEK_DAYS - 1, count = range.location; i >= count ; i--) {
                    [self.dayOfElementSource[i] setMonthType:PYDayOfElementViewMonth_Unknow];
                }
            }
        }
        
        
        if (_dataSourceOrDelegateFlags.didSetToday) {
            PYWeekOfElementViewType type = [self.dataSource py_weekOfElementView:self didSetTodayWithIndex:self.index];
            switch (type) {
                case PYWeekOfElementView_Sunday:
                case PYWeekOfElementView_Monday:
                case PYWeekOfElementView_Tuesday:
                case PYWeekOfElementView_Wednesday:
                case PYWeekOfElementView_Thursday:
                case PYWeekOfElementView_Friday:
                case PYWeekOfElementView_Saturday:
                    [self.dayOfElementSource[type] setLatelyType:PYDayOfElementViewLately_Today];
                    break;
                case PYWeekOfElementView_NotThisWeek:
                    // do nothing
                    break;
                default:
                    NSAssert(NO, @"不再枚举范围中");
                    break;
            }
        }
    }
}

- (void)reloadTask {
    if (_dataSourceOrDelegateFlags.didSetTask) {
        NSArray<NSNumber *> * workTypeS = [self.delegate py_weekOfElementView:self setTaskWithIndex:self.index];
        NSAssert(workTypeS.count == WEEK_DAYS, @"一周有7天的状态");
        for (NSInteger i = 0 ; i < WEEK_DAYS; i++) {
            NSNumber *number = workTypeS[i];
            PYDayOfElementViewWorkType workType = number.integerValue;
            [self.dayOfElementSource[i] setWorkType:workType];
        }
    }
}

#pragma mark ---------- setter
- (void)setDataSource:(id<PYWeekOfElementViewDataSouce>)dataSource {
    _dataSource = dataSource;
    
    _dataSourceOrDelegateFlags.didSetData = [dataSource respondsToSelector:@selector(py_weekOfElementView:didSetDateWithIndex:)];
    _dataSourceOrDelegateFlags.didSetCurrentMonth = [dataSource respondsToSelector:@selector(py_weekOfElementView:didSetCurrentMonthWithIndex:)];
    _dataSourceOrDelegateFlags.didSetToday = [dataSource respondsToSelector:@selector(py_weekOfElementView:didSetTodayWithIndex:)];
}

- (void)setDelegate:(id<PYWeekOfElementViewDelegate>)delegate {
    _delegate = delegate;
    
    _dataSourceOrDelegateFlags.didSetTask = [delegate respondsToSelector:@selector(py_weekOfElementView:setTaskWithIndex:)];
    _dataSourceOrDelegateFlags.willSelectSomeDay = [delegate respondsToSelector:@selector(py_weekOfElementView:willSelectSomeDay:index:)];
    _dataSourceOrDelegateFlags.didSelectSomeDay = [delegate respondsToSelector:@selector(py_weekOfElementView:didSelectSomeDay:index:)];
}

#pragma mark ----------- getter
- (NSMutableArray *)dayOfElementSource {
    if (!_dayOfElementSource) {
        _dayOfElementSource = [[NSMutableArray alloc] init];
    }
    return _dayOfElementSource;
}

- (void (^)(PYDayOfElementView *))WillSelectBlock {
    if (!_WillSelectBlock) {
        __weak PYWeekOfElementView *weakSelf = self;
        _WillSelectBlock = ^void(PYDayOfElementView *dayView) {
            if (_dataSourceOrDelegateFlags.willSelectSomeDay) {
                [weakSelf.delegate py_weekOfElementView:weakSelf willSelectSomeDay:dayView.dateStr index:weakSelf.index];
            }
        };
    }
    return _WillSelectBlock;
}

- (void (^)(PYDayOfElementView *))DidSelectBlock {
    if (!_DidSelectBlock) {
        __weak PYWeekOfElementView *weakSelf = self;
        _DidSelectBlock = ^void(PYDayOfElementView *dayView) {
            if (_dataSourceOrDelegateFlags.didSelectSomeDay) {
                [weakSelf.delegate py_weekOfElementView:weakSelf didSelectSomeDay:dayView.dateStr index:weakSelf.index];
            }
        };
    }
    return _DidSelectBlock;
}
@end
