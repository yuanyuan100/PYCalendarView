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
#import "PYMonthOfElementView.h"
#import "PYCalendarContentProvider.h"

@interface ViewController () <PYWeekOfElementViewDataSouce, PYWeekOfElementViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    PYMonthOfElementView *monthView = [[PYMonthOfElementView alloc] initWihtX:0 Y:20 widht:UI_SCREEN_WIDTH date:[[PYCalendarContentProvider new] lastMonthTransformDate:[NSDate date]]];
    [self.view addSubview:monthView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
