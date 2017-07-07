//
//  CHKCalendarCollectionViewCell.m
//  Calendar-Demo
//
//  Created by 尊旅环球游 on 2017/6/2.
//  Copyright © 2017年 chk. All rights reserved.
//

#import "CHKCalendarCollectionViewCell.h"


@implementation CHKCalendarCollectionViewCell


- (void)setBgStyle:(CHKCalendarCollectionViewCellBgViewStyle)bgStyle {
    _bgStyle = bgStyle;
    switch (bgStyle) {
        case CHKCalendarCollectionViewCellBgViewStyleNone:
        {
            self.bgView.backgroundColor = [UIColor clearColor];
            self.bgView.layer.borderWidth = 0;
            self.titleLabel_num.textColor = UIColorFromHN(0x4c4c4c);
            self.titleLabel_ch.textColor = UIColorFromHN(0xb2b2b2);
        }
            break;
        case CHKCalendarCollectionViewCellBgViewStyleCircle:
        {
            self.bgView.backgroundColor = [UIColor redColor];
            self.bgView.layer.borderWidth = 0;
            self.titleLabel_ch.textColor = [UIColor whiteColor];
            self.titleLabel_num.textColor = [UIColor whiteColor];
        }
            break;
        case CHKCalendarCollectionViewCellBgViewStyleRing:
        {
            self.bgView.backgroundColor = [UIColor clearColor];
            self.bgView.layer.borderWidth = 2;
            self.bgView.layer.borderColor = [UIColor redColor].CGColor;
            self.bgView.backgroundColor = [UIColor clearColor];
            self.titleLabel_num.textColor = UIColorFromHN(0x4c4c4c);
            self.titleLabel_ch.textColor = UIColorFromHN(0xb2b2b2);
        }
            break;
        default:
            break;
    }
}

- (void)setFlagStyle:(CHKCalendarCollectionViewCellFlagViewStyle)flagStyle {
    _flagStyle = flagStyle;
    
    switch (flagStyle) {
        case CHKCalendarCollectionViewCellFlagViewStyleNone:
        {
            self.flagView.backgroundColor = [UIColor clearColor];
        }
            break;
        case CHKCalendarCollectionViewCellFlagViewStyleSelected:
        {
            self.flagView.backgroundColor = UIColorFromHN(0xffffff);
        }
            break;
        case CHKCalendarCollectionViewCellFlagViewStyleDisSelect:
        {
            self.flagView.backgroundColor = self.titleLabel_ch.textColor;
        }
            break;
        default:
            break;
    }
}

- (void)setIsThisMonth:(BOOL)isThisMonth {
    _isThisMonth = isThisMonth;
    if (isThisMonth) {
        self.titleLabel_num.textColor = UIColorFromHN(0x4c4c4c);
    } else {
        self.titleLabel_num.textColor = UIColorFromHN(0xb2b2b2);
    }
}


- (UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:self.contentView.frame];
        _bgView.backgroundColor = [UIColor redColor];
        _bgView.layer.cornerRadius = self.contentView.width / 2.f;
        _bgView.clipsToBounds = YES;
        [self.contentView addSubview:_bgView];
    }
    return _bgView;
}


- (UILabel *)titleLabel_num {
    if (_titleLabel_num == nil) {
        CGFloat y = self.bgView.height / 2.0 - 15;
        _titleLabel_num = [[UILabel alloc] initWithFrame:CGRectMake(0, y, self.bgView.width, 17)];
        _titleLabel_num.font = FontSize(18);
        _titleLabel_num.textColor = UIColorFromHN(0x4c4c4c);
        _titleLabel_num.centerX = self.bgView.centerX;
        _titleLabel_num.textAlignment = NSTextAlignmentCenter;
        [self.bgView addSubview:_titleLabel_num];
    }
    return _titleLabel_num;
}
- (UILabel *)titleLabel_ch {
    if (_titleLabel_ch == nil) {
        _titleLabel_ch = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel_num.x, self.titleLabel_num.maxY, self.titleLabel_num.width, self.titleLabel_num.height)];
        _titleLabel_ch.centerX = self.bgView.centerX;
        _titleLabel_ch.font = FontSize(12);
        _titleLabel_ch.textColor = UIColorFromHN(0xb2b2b2);
        _titleLabel_ch.textAlignment = self.titleLabel_num.textAlignment;
        [self.bgView addSubview:_titleLabel_ch];
    }
    return _titleLabel_ch;
}
- (UIView *)flagView {
    if (_flagView == nil) {
        CGFloat flagWidth = 4;
        _flagView = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleLabel_ch.maxY, flagWidth, flagWidth)];
        _flagView.centerX = self.titleLabel_ch.centerX;
        _flagView.backgroundColor = UIColorFromHN(0x4c4c4c);
        _flagView.layer.cornerRadius = flagWidth / 2.f;
        _flagView.clipsToBounds = YES;
        [self.bgView addSubview:_flagView];
    }
    return _flagView;
}


@end
