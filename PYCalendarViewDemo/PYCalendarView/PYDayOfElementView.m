//
//  PYDayOfElementView.m
//  PYCalendarViewDemo
//
//  Created by Snake on 16/12/29.
//  Copyright © 2016年 IAsk. All rights reserved.
//

#import "PYDayOfElementView.h"
#import "PYCalendarMarco.h"


@interface PYDayOfElementView ()
/** 文字层(日期显示) */
@property (nonatomic, strong) UILabel *dateView;
/** 圆线层(今日) */
@property (nonatomic, strong) UIView *todayView;
/** 圆圈层(用户选中) */
@property (nonatomic, strong) UILabel *selectedView;
/** 原点层(事件展示层) */
@property (nonatomic, strong) UIView *workView;


@property (nonatomic, copy) NSString *day;
@end

@implementation PYDayOfElementView
- (instancetype)initWithFrame:(CGRect)frame dateStr:(NSString *)dateStr {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
        [self setupSubFrame];
        [self addTap];
        [self addNotificationCenter];
        
        self.dateStr = dateStr;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
        [self setupSubFrame];
        [self addTap];
        [self addNotificationCenter];
    }
    return self;
}

#pragma mark --------- 点击事件
- (void)addTap {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedCurrent:)];
    [self addGestureRecognizer:tap];
}

- (void)selectedCurrent:(UITapGestureRecognizer *)tap {
    __weak PYDayOfElementView *weakSelf = self;
    if (self.WillSelectBlock) {
        self.WillSelectBlock(weakSelf);
    }
    if (self.state != PYDayOfElementViewState_Selected) {
        self.state = PYDayOfElementViewState_Selected;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PYDayOfElementViewStateChanged" object:nil userInfo:@{@"dateStr":self.dateStr}];
    }
    
    if (self.DidSelectBlock) {
        self.DidSelectBlock(weakSelf);
    }
}

- (void)addNotificationCenter {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotificationAboutState:) name:@"PYDayOfElementViewStateChanged" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotificationAboutToday:) name:@"PYDayOfElementViewTodayChanged" object:nil];
}

-  (void)getNotificationAboutState:(NSNotification *)noti {
    if ([noti.name isEqualToString:@"PYDayOfElementViewStateChanged"]) {
        if (![noti.userInfo[@"dateStr"] isEqualToString:self.dateStr]) {
            if (self.state == PYDayOfElementViewState_Selected) {
                self.state = PYDayOfElementViewState_Normal;
            }
        }
    }
}

- (void)getNotificationAboutToday:(NSNotification *)noti {
    if ([noti.name isEqualToString:@"PYDayOfElementViewTodayChanged"]) {
        if (![noti.userInfo[@"dateStr"] isEqualToString:self.dateStr]) {
            if (self.latelyType == PYDayOfElementViewLately_Today) {
                self.latelyType = PYDayOfElementViewLately_Yesterday;
            }
        }
    }
}

#pragma mark --------- frame
- (void)setupSubFrame {
    _dateView.frame = getElementFrame(getElementCenter(self.bounds));
    _todayView.frame = getElementFrame(getElementCenter(self.bounds));
    _selectedView.frame = getElementFrame(getElementCenter(self.bounds));
    _workView.frame = CGRectMake(getElementCenter(self.bounds).x - WORKVIEW_SIZE.width/2,\
                                 getElementCenter(self.bounds).y + WORKVIEW_TOP,\
                                 WORKVIEW_SIZE.width,\
                                 WORKVIEW_SIZE.height);
}

#pragma mark --------- 承载层的UI
- (void)creatUI {
    [self addSubview:self.dateView];
    [self addSubview:self.todayView];
    [self addSubview:self.selectedView];
    [self addSubview:self.workView];
}

#pragma mark --------- setter
- (void)setDateStr:(NSString *)dateStr {
    _dateStr = dateStr;
    
    self.day = [dateStr substringFromIndex:dateStr.length - 2];
}

- (void)setDay:(NSString *)day {
    _day = day;
    
    _dateView.text = day;
    _selectedView.text = day;
}

- (void)setMonthType:(PYDayOfElementViewMonth)monthType {
    _monthType = monthType;
    switch (monthType) {
        case PYDayOfElementViewMonth_Current:
            _dateView.textColor = COLOR_HEX(0x333333, 1);
            break;
        default:
            _dateView.textColor = COLOR_HEX(0xcccccc, 1);
            break;
    }
}

- (void)setLatelyType:(PYDayOfElementViewLately)latelyType {
    _latelyType = latelyType;
    switch (latelyType) {
        case PYDayOfElementViewLately_Today:
            _todayView.hidden = NO;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"PYDayOfElementViewTodayChanged" object:nil userInfo:@{@"dateStr":self.dateStr}];
            break;
        default:
            _todayView.hidden = YES;
            break;
    }
}

- (void)setState:(PYDayOfElementViewState)state {
    _state = state;
    
    switch (state) {
        case PYDayOfElementViewState_Normal:
            _selectedView.hidden = YES;
            break;
        case PYDayOfElementViewState_Selected:
            _selectedView.hidden = NO;
            break;
        default:
            NSAssert(NO, @"类型不存在");
            _selectedView.hidden = YES;
            break;
    }
}

- (void)setWorkType:(PYDayOfElementViewWorkType)workType {
    _workType = workType;
    switch (workType) {
        case PYDayOfElementViewWorkType_None:
            _workView.hidden = YES;
            break;
        case PYDayOfElementViewWorkType_Pending:
            _workView.hidden = NO;
            _workView.backgroundColor = COLOR_HEX(0xff0000, 1);
            break;
        case PYDayOfElementViewWorkType_Outpatient:
            _workView.hidden = NO;
            _workView.backgroundColor = COLOR_HEX(0xcccccc, 1);
            break;
        default:
            NSAssert(NO, @"类型不存在");
            _workView.hidden = YES;
            break;
    }
}

#pragma mark --------- getter
- (UILabel *)dateView {
    if (_dateView) {
        return _dateView;
    }
    return _dateView = ({
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:18.0f];
        label.textColor = COLOR_HEX(0x333333, 1);
        label.textAlignment = NSTextAlignmentCenter;
        label;
    });
}

- (UIView *)todayView {
    if (_todayView) {
        return _todayView;
    }
    return _todayView = ({
        UIView *view = [[UIView alloc] init];
        view.layer.cornerRadius = ELEMENT_WIDTH / 2.0f;
        view.layer.masksToBounds = YES;
        view.layer.borderWidth = 1.0f;
        view.layer.borderColor = COLOR_HEX(0xd7d7d7, 1).CGColor;
        view.hidden = YES;
        view;
    });
}


- (UILabel *)selectedView {
    if (_selectedView) {
        return _selectedView;
    }
    return _selectedView = ({
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = COLOR_HEX(0xbca692, 1);
        label.layer.cornerRadius = ELEMENT_WIDTH / 2.0f;
        label.layer.masksToBounds = YES;
        
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        
        label.hidden = YES;
        
        label;
    });
}

- (UIView *)workView {
    if (_workView) {
        return _workView;
    }
    return _workView = ({
        UIView *view = [[UIView alloc] init];
        view.layer.cornerRadius = WORKVIEW_SIZE.width / 2;
        view.layer.masksToBounds = YES;
        
        view.hidden = YES;
        
        view;
    });
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PYDayOfElementViewStateChanged" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PYDayOfElementViewTodayChanged" object:nil];
}

@end
