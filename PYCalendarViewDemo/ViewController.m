//
//  ViewController.m
//  PYCalendarViewDemo
//
//  Created by Snake on 16/12/29.
//  Copyright © 2016年 IAsk. All rights reserved.
//

#import "ViewController.h"
#import "PYDayOfElementView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    PYDayOfElementView *dayView = [[PYDayOfElementView alloc] initWithFrame:CGRectMake(100, 100, 100, 100) dateStr:@"2016-12-28"];
    dayView.monthType = PYDayOfElementViewMonth_Unknow;
    dayView.workType = PYDayOfElementViewWorkType_Pending;
    [self.view addSubview:dayView];
    
    PYDayOfElementView *dayView1 = [[PYDayOfElementView alloc] initWithFrame:CGRectMake(100, 200, 100, 100) dateStr:@"2016-12-29"];
    dayView1.monthType = PYDayOfElementViewMonth_Unknow;
    dayView1.workType = PYDayOfElementViewWorkType_Outpatient;
    dayView1.latelyType = PYDayOfElementViewLately_Today;
    [self.view addSubview:dayView1];
    
    PYDayOfElementView *dayView2 = [[PYDayOfElementView alloc] initWithFrame:CGRectMake(100, 300, 100, 100) dateStr:@"2016-12-30"];
    dayView2.monthType = PYDayOfElementViewMonth_Unknow;
    dayView2.workType = PYDayOfElementViewWorkType_None;
    dayView2.latelyType = PYDayOfElementViewLately_Today;
    [self.view addSubview:dayView2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
