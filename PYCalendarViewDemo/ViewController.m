//
//  ViewController.m
//  PYCalendarViewDemo
//
//  Created by Snake on 16/12/29.
//  Copyright © 2016年 IAsk. All rights reserved.
//

#import "ViewController.h"
#import "PYCalendarMarco.h"
#import "PYDayOfElementView.h"
#import "PYWeekOfElementView.h"

@interface ViewController () <PYWeekOfElementViewDataSouce, PYWeekOfElementViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    PYDayOfElementView *dayView = [[PYDayOfElementView alloc] initWithFrame:CGRectMake(100, 20, 100, 100) dateStr:@"2016-12-28"];
    dayView.monthType = PYDayOfElementViewMonth_Unknow;
    dayView.workType = PYDayOfElementViewWorkType_Pending;
    [self.view addSubview:dayView];
    
    PYDayOfElementView *dayView1 = [[PYDayOfElementView alloc] initWithFrame:CGRectMake(100, 120, 100, 100) dateStr:@"2016-12-29"];
    dayView1.monthType = PYDayOfElementViewMonth_Unknow;
    dayView1.workType = PYDayOfElementViewWorkType_Outpatient;
    dayView1.latelyType = PYDayOfElementViewLately_Today;
    [self.view addSubview:dayView1];
    
    PYDayOfElementView *dayView2 = [[PYDayOfElementView alloc] initWithFrame:CGRectMake(100, 220, 100, 100) dateStr:@"2016-12-30"];
    dayView2.monthType = PYDayOfElementViewMonth_Unknow;
    dayView2.workType = PYDayOfElementViewWorkType_None;
    dayView2.latelyType = PYDayOfElementViewLately_Today;
    [self.view addSubview:dayView2];
    
    PYWeekOfElementView *week = [[PYWeekOfElementView alloc] initWithFrame:CGRectMake(0, 320, UI_SCREEN_WIDTH, 60)];
    week.dataSource = self;
    week.delegate = self;
    [self.view addSubview:week];
    [week reloadDataSource];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [week reloadTask];
    });
}

- (NSArray<NSString *> *)py_weekOfElementView:(PYWeekOfElementView *)weekView didSetDateWithIndex:(NSUInteger)index {
    return @[@"2016-12-10", @"2016-12-11", @"2016-12-12", @"2016-12-13", @"2016-12-14", @"2016-12-15", @"2016-12-16"];
}

- (NSRange)py_weekOfElementView:(PYWeekOfElementView *)weekView didSetCurrentMonthWithIndex:(NSUInteger)index {
    return NSMakeRange(0, 0);
}

- (PYWeekOfElementViewType)py_weekOfElementView:(PYWeekOfElementView *)weekView didSetTodayWithIndex:(NSUInteger)index {
    return PYWeekOfElementView_Sunday;
}

- (NSArray<NSNumber *> *)py_weekOfElementView:(PYWeekOfElementView *)weekView setTaskWithIndex:(NSUInteger)index {
    return @[@0,@1,@2,@0,@0,@0,@0];
}

- (void)py_weekOfElementView:(PYWeekOfElementView *)weekView willSelectSomeDay:(NSString *)someDay index:(NSUInteger)index {

}

- (void)py_weekOfElementView:(PYWeekOfElementView *)weekView didSelectSomeDay:(NSString *)someDay index:(NSUInteger)index {

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
