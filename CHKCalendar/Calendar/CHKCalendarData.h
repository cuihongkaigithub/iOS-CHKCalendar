//
//  CHKCalendarData.h
//  Calendar-Demo
//
//  Created by 尊旅环球游 on 2017/6/1.
//  Copyright © 2017年 chk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHKCalendarData : NSObject

@property (nonatomic,strong) NSMutableDictionary<NSNumber *, NSDate *> *monthDates;//缓存每个月的第一天date
@property (nonatomic,strong) NSMutableDictionary<NSNumber *, NSDate *> *monthHeadDates;//缓存每一页第一个date
@property (nonatomic,assign) NSInteger numOfMonths;//最大与最小时间内包含多少个月

@property (nonatomic,strong) NSDate *minDate;//可显示的最早日期
@property (nonatomic,strong) NSDate *maxDate;//可显示的最晚日期

@property (nonatomic,strong) NSDateFormatter *formatter;
@property (nonatomic,strong) NSCalendar *calendar;

- (void)setupNumOfMonths;

@end
