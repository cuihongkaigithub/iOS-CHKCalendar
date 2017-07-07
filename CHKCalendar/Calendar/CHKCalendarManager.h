//
//  CHKCalendarManager.h
//  Calendar-Demo
//
//  Created by 尊旅环球游 on 2017/6/1.
//  Copyright © 2017年 chk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHKCalendarData.h"

@interface CHKCalendarManager : NSObject

@property (nonatomic,strong) CHKCalendarData *calendarData;

- (NSDate *)dateForIndexPath:(NSIndexPath *)indexPath;

- (NSDate *)getMonthHeadDateWithSection:(NSInteger)section;

- (NSString *)titleNumForDate:(NSDate *)date;
- (NSString *)titleChForFate:(NSDate *)date;


@end
