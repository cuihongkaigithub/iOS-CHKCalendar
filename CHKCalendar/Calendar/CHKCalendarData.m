//
//  CHKCalendarData.m
//  Calendar-Demo
//
//  Created by 尊旅环球游 on 2017/6/1.
//  Copyright © 2017年 chk. All rights reserved.
//

#import "CHKCalendarData.h"

@implementation CHKCalendarData


- (instancetype)init {
    if (self = [super init]) {
        _monthDates = [NSMutableDictionary dictionary];
        _monthHeadDates = [NSMutableDictionary dictionary];
        [self setupNumOfMonths];
    }
    return self;
}

- (void)setupNumOfMonths {
    NSDateComponents *components = [self.calendar components:NSCalendarUnitMonth fromDate:self.minDate toDate:self.maxDate options:0];
    _numOfMonths = components.month;
}

- (NSCalendar *)calendar {
    if (_calendar == nil) {
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    return _calendar;
}

- (NSDateFormatter *)formatter {
    if (_formatter == nil) {
        _formatter = [[NSDateFormatter alloc] init];
        [_formatter setDateFormat:@"yyyy-MM-dd"];
    }
    return _formatter;
}

- (NSDate *)minDate {
    if (_minDate == nil) {
        _minDate = [self.formatter dateFromString:@"2016-10-01"];
    }
    return _minDate;
}
- (NSDate *)maxDate {
    if (_maxDate == nil) {
        _maxDate = [self.formatter dateFromString:@"2020-05-31"];
    }
    return _maxDate;
}



@end
