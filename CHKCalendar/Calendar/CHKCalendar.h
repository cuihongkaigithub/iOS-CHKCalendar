//
//  CHKCalendar.h
//  Calendar-Demo
//
//  Created by 尊旅环球游 on 2017/6/1.
//  Copyright © 2017年 chk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CHKCalendarDelegate <NSObject>

- (void)chk_calendarItemSelectedCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

@end

#define SC_WIDTH [[UIScreen mainScreen] bounds].size.width

@interface CHKCalendar : UIView

@property (nonatomic,weak) id <CHKCalendarDelegate> delegate;

@end
