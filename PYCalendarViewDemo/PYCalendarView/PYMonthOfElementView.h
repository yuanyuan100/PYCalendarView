//
//  PYMonthOfElementView.h
//  PYCalendarViewDemo
//
//  Created by Snake on 16/12/29.
//  Copyright © 2016年 IAsk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PYMonthOfElementView : UIView
-(instancetype)initWihtX:(CGFloat)x Y:(CGFloat)y widht:(CGFloat)width date:(NSDate *)date;
@property (nonatomic, readonly, assign) CGFloat height;
@end
