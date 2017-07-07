//
//  CHKCalendarCollectionViewCell.h
//  Calendar-Demo
//
//  Created by 尊旅环球游 on 2017/6/2.
//  Copyright © 2017年 chk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"
#import "UIView+VIewFrame.h"

typedef NS_ENUM(NSInteger, CHKCalendarCollectionViewCellBgViewStyle) {
    CHKCalendarCollectionViewCellBgViewStyleNone = 0,
    CHKCalendarCollectionViewCellBgViewStyleRing,
    CHKCalendarCollectionViewCellBgViewStyleCircle
};
typedef NS_ENUM(NSInteger, CHKCalendarCollectionViewCellFlagViewStyle) {
    CHKCalendarCollectionViewCellFlagViewStyleNone = 0,
    CHKCalendarCollectionViewCellFlagViewStyleSelected,
    CHKCalendarCollectionViewCellFlagViewStyleDisSelect
};

@interface CHKCalendarCollectionViewCell : UICollectionViewCell

@property (nonatomic,assign) CHKCalendarCollectionViewCellBgViewStyle bgStyle;

@property (nonatomic,assign) CHKCalendarCollectionViewCellFlagViewStyle flagStyle;

@property (nonatomic,assign) BOOL isThisMonth;

@property (nonatomic,strong) UIView *bgView;

@property (nonatomic,strong) UIView *flagView;

@property (nonatomic,strong) UILabel *titleLabel_num;

@property (nonatomic,strong) UILabel *titleLabel_ch;


@end
