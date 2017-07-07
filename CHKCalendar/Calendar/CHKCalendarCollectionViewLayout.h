//
//  CHKCalendarCollectionViewLayout.h
//  Calendar-Demo
//
//  Created by 尊旅环球游 on 2017/6/2.
//  Copyright © 2017年 chk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PrepareLayoutEnd)();

@interface CHKCalendarCollectionViewLayout : UICollectionViewLayout

@property (nonatomic,assign) CGSize itemSize;

@property (nonatomic,copy) PrepareLayoutEnd endAction;

@end
