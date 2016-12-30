//
//  PYCalendarMarco.h
//  PYCalendarViewDemo
//
//  Created by Snake on 16/12/29.
//  Copyright © 2016年 IAsk. All rights reserved.
//

#ifndef PYCalendarMarco_h
#define PYCalendarMarco_h

#ifndef UI_SCREEN_WIDTH
#define UI_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#endif 

#ifndef UI_SCREEN_HEIGHT
#define UI_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#endif

/// 基本元素的宽
#ifndef ELEMENT_WIDTH
#define ELEMENT_WIDTH 44
#endif

/// 基本元素的高
#ifndef ELEMENT_HEIGHT
#define ELEMENT_HEIGHT 44
#endif

/// 周元素的高度
#ifndef WEEK_ELEMENT_HEIGHT
#define WEEK_ELEMENT_HEIGHT 54.0F
#endif

/// 红点(事件)
#ifndef WORKVIEW_SIZE
#define WORKVIEW_SIZE CGSizeMake(6, 6)
#endif

/// 红点距离中心点的高度
#ifndef WORKVIEW_TOP
#define WORKVIEW_TOP 11
#endif

/**
 内联函数，返回元素层view的frame
 
 @param center 承载层的中心店
 @return 元素层的frame
 */
static inline CGRect getElementFrame(CGPoint center) {
    return CGRectMake(center.x- ELEMENT_WIDTH/2, center.y - ELEMENT_HEIGHT/2, ELEMENT_WIDTH, ELEMENT_HEIGHT);
}

static inline CGPoint getElementCenter(CGRect bounds) {
    return CGPointMake(bounds.size.width/2, bounds.size.height/2);
}

#ifndef COLOR_HEX
#define COLOR_HEX(c, a) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:a]
#endif

#endif /* PYCalendarMarco_h */
