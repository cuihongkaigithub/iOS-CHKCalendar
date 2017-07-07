//
//  CHKCalendarManager.m
//  Calendar-Demo
//
//  Created by 尊旅环球游 on 2017/6/1.
//  Copyright © 2017年 chk. All rights reserved.
//

#import "CHKCalendarManager.h"
#import <UIKit/UIKit.h>

@interface CHKCalendarManager ()

@property (nonatomic,strong) NSCalendar *calendar;

@property (nonatomic,strong) NSCalendar *lunarCalendar;
@property (nonatomic,strong) NSArray <NSString *>*lunarChars;

@end


@implementation CHKCalendarManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        CHKCalendarData *calendarData = [[CHKCalendarData alloc] init];
        _calendarData = calendarData;
        _calendar = calendarData.calendar;
        
        _lunarCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
        _lunarCalendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
        _lunarChars = @[@"初一",@"初二",@"初三",@"初四",@"初五",@"初六",@"初七",@"初八",@"初九",@"初十",@"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十",@"廿一",@"廿二",@"廿三",@"廿四",@"廿五",@"廿六",@"廿七",@"廿八",@"廿九",@"三十"];
    }
    return self;
}

- (NSDate *)dateForIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath) {
        return nil;
    }
    NSDate *head = [self getMonthHeadDateWithSection:indexPath.section];
    NSInteger daysOffset = indexPath.item;
    NSDate *date = [self.calendar dateByAddingUnit:NSCalendarUnitDay value:daysOffset toDate:head options:0];
    return date;
}

- (NSDate *)getMonthHeadDateWithSection:(NSInteger)section {
    NSNumber *key = @(section);
    NSDate *monthHeadDate = self.calendarData.monthHeadDates[key];
    if (!monthHeadDate) {
        NSDate *monthFirst = [self.calendar dateByAddingUnit:NSCalendarUnitMonth value:section toDate:[self getMonthFirstDayWithDate:self.calendarData.minDate] options:0];
        NSInteger tempDays = [self numOfPlaceholdersForMonthFirst:monthFirst];
        monthHeadDate = [self.calendar dateByAddingUnit:NSCalendarUnitDay value:-tempDays toDate:monthFirst options:0];
        self.calendarData.monthHeadDates[key] = monthHeadDate;
        self.calendarData.monthDates[key] = monthFirst;
    }
    return monthHeadDate;
}

- (NSDate *)getMonthFirstDayWithDate:(NSDate *)date {
    if (!date) return nil;
    NSDateComponents *components = [self.calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour fromDate:date];
    components.day = 1;
    return [self.calendar dateFromComponents:components];
}

- (NSInteger)numOfPlaceholdersForMonthFirst:(NSDate *)monthFirst {
    NSInteger currentWeekday = [self.calendar component:NSCalendarUnitWeekday fromDate:monthFirst];
    NSInteger number = currentWeekday - 1;
    return number;
}

- (NSString *)titleNumForDate:(NSDate *)date {
    NSDateComponents *components = [self.calendar components:NSCalendarUnitDay | NSCalendarUnitMonth fromDate:date];
    
    return [NSString stringWithFormat:@"%zd", components.day];
}
- (NSString *)titleChForFate:(NSDate *)date {
    NSInteger day = [self.lunarCalendar component:NSCalendarUnitDay fromDate:date];
    return self.lunarChars[day - 1];
}




@end
