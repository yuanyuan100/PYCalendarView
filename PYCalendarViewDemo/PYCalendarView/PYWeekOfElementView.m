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
#define WEEKVIEW_WIDTH self.frame.size.width
#endif
#ifndef WEEKVIEW_HEIGHT
#define WEEKVIEW_HEIGHT self.frame.size.height
#endif
#ifndef WEEKVIEW_WIDTH_7
#define WEEKVIEW_WIDTH_7 self.frame.size.width/7
#endif

@interface PYWeekOfElementView ()
/** 天元素资源 */
@property (nonatomic, strong) NSMutableArray *dayOfElementSource;
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
    for (NSInteger i = 0; i < 7; i++) {
        PYDayOfElementView *dayView = [[PYDayOfElementView alloc] initWithFrame:CGRectMake(0 + WEEKVIEW_WIDTH_7 * i,\
                                                                                        WEEKVIEW_HEIGHT/2 - ELEMENT_HEIGHT/2,\
                                                                                        ELEMENT_WIDTH,\
                                                                                        ELEMENT_HEIGHT)];
        [self.dayOfElementSource addObject:dayView];
    }
}



#pragma mark --------- getter
- (NSMutableArray *)dayOfElementSource {
    if (!_dayOfElementSource) {
        _dayOfElementSource = [[NSMutableArray alloc] init];
    }
    return _dayOfElementSource;
}
@end
