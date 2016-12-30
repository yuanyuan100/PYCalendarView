//
//  PYMonthOfElementView.m
//  PYCalendarViewDemo
//
//  Created by Snake on 16/12/29.
//  Copyright © 2016年 IAsk. All rights reserved.
//

#import "PYMonthOfElementView.h"
#import "PYCalendarMarco.h"
#import "PYCalendarContentProvider.h"
#import "PYWeekOfElementView.h"

@interface PYMonthOfElementView () <PYWeekOfElementViewDelegate, PYWeekOfElementViewDataSouce>
@property (nonatomic, strong) PYCalendarContentProvider *provider;
@property (nonatomic, readwrite, assign) CGFloat height;
@property (nonatomic, strong) NSMutableArray *weekOfElementSource;
@end

@implementation PYMonthOfElementView
{
    CGFloat _x;
    CGFloat _y;
    CGFloat _width;
    NSDate *_date;
}
- (instancetype)initWihtX:(CGFloat)x Y:(CGFloat)y widht:(CGFloat)width date:(NSDate *)date {
    self = [self init];
    _x = x;
    _y = y;
    _width = width;
    _date = date;
    
//    [self creatUI];
    
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.provider = [[PYCalendarContentProvider alloc] init];
    }
    return self;
}

#pragma mark ---------- UI 
- (void)creatUI {
    NSRange weekRange = [self.provider weekOfMonthWithDate:_date];
    self.height = WEEK_ELEMENT_HEIGHT * weekRange.length;
    self.frame = CGRectMake(_x, _y, _width, self.height);
    
    // 创建响应数量的周
    for (NSInteger i = 0, count = weekRange.length; i < count; i++) {
        PYWeekOfElementView *weekView = [[PYWeekOfElementView alloc] initWithFrame:CGRectMake(0, WEEK_ELEMENT_HEIGHT * i, _width, WEEK_ELEMENT_HEIGHT)];
        weekView.index = i;
//        weekView.dataSource = self;
//        weekView.delegate = self;
        [self.weekOfElementSource addObject:weekView];
        [self addSubview:weekView];
    }
}

#pragma mark ---------- 代理协议
//- (NSArray<NSString *> *)py_weekOfElementView:(PYWeekOfElementView *)weekView didSetDateWithIndex:(NSUInteger)index {
//
//}
//
//- (NSRange)py_weekOfElementView:(PYWeekOfElementView *)weekView didSetCurrentMonthWithIndex:(NSUInteger)index {
//
//}
//
//- (PYWeekOfElementViewType)py_weekOfElementView:(PYWeekOfElementView *)weekView didSetTodayWithIndex:(NSUInteger)index {
//
//}

#pragma mark ---------- getter
- (NSMutableArray *)weekOfElementSource {
    if (!_weekOfElementSource) {
        _weekOfElementSource = [[NSMutableArray alloc] init];
    }
    return _weekOfElementSource;
}
@end
