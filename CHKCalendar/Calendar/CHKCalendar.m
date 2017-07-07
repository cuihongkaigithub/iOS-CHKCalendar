//
//  CHKCalendar.m
//  Calendar-Demo
//
//  Created by 尊旅环球游 on 2017/6/1.
//  Copyright © 2017年 chk. All rights reserved.
//

#import "CHKCalendar.h"
#import "CHKCalendarCollectionViewCell.h"
#import "CHKCalendarCollectionViewLayout.h"
#import "CHKCalendarManager.h"


static NSString *kCHKCalendarCollectionViewCell = @"CHKCalendarCollectionViewCell";

@interface CHKCalendar () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) CHKCalendarManager *manager;

@property (nonatomic,strong) CHKCalendarData *calendarData;

@property (nonatomic,strong) NSCalendar *calendar;

@property (nonatomic,strong) NSIndexPath *selectItemPath;

@property (nonatomic,assign) NSInteger currentPage;

@property (nonatomic,strong) UIButton *lastBtn;
@property (nonatomic,strong) UIButton *nextBtn;

@property (nonatomic,strong) UIScrollView *titleScr;

@property (nonatomic,strong) UIView *cutLineView;

@end

@implementation CHKCalendar {
    CGFloat _scrScale;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.backgroundColor = [UIColor whiteColor];
    CHKCalendarManager * manager = [[CHKCalendarManager alloc] init];
    _manager = manager;
    _calendarData = manager.calendarData;
    _calendar = manager.calendarData.calendar;
    [self cgreatePageTurnImageView];
    [self createCollectionView];
    [self addWeekLabel];
    _scrScale = self.titleScr.width / self.collectionView.width;
    self.height = self.cutLineView.maxY;
}

#pragma mark ----------------视图布局
- (void)createCollectionView {
    
    CGFloat itemWidth = self.frame.size.width / 7;
    CHKCalendarCollectionViewLayout *layout = [[CHKCalendarCollectionViewLayout alloc] init];
    layout.itemSize = CGSizeMake(itemWidth, itemWidth);
    weak(self);
    layout.endAction = ^{
        strong(self);
        if (!self.selectItemPath) {
            [self updatePage:NO];
        }
    };
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.lastBtn.maxY + 30, self.frame.size.width, itemWidth*6) collectionViewLayout:layout];
    [self addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerClass:[CHKCalendarCollectionViewCell class] forCellWithReuseIdentifier:kCHKCalendarCollectionViewCell];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    NSDateComponents *components = [self.calendar components:NSCalendarUnitMonth fromDate:self.calendarData.minDate toDate:[NSDate date] options:0];
    self.currentPage = components.month;
    [self titleScr];
}
- (void)addWeekLabel {
    CGFloat x = 0;
    CGFloat width = self.frame.size.width / 7.0;
    NSArray *arr = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    for (int i = 0; i < arr.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, self.lastBtn.maxY, width, 30)];
        label.font = FontSize(18);
        label.textColor = UIColorFromHN(0x4c4c4c);
        label.textAlignment = NSTextAlignmentCenter;
        label.text = arr[i];
        [self addSubview:label];
        x += width;
    }
}
- (void)btnAction:(UIButton *)btn {
    if (btn.tag) {
        [self updateNextPage];
    } else {
        [self updateLastPage];
    }
}
- (void)updateLastPage {
    if (self.currentPage > 0) {
        self.currentPage--;
    }
    [self updatePage:YES];
}
- (void)updateNextPage {
    if (self.currentPage < self.calendarData.numOfMonths - 1) {
        self.currentPage++;
    }
    [self updatePage:YES];
}
- (void)updatePage:(BOOL)animated {
    
    [self.titleScr setContentOffset:CGPointMake(self.titleScr.width * self.currentPage, 0) animated:animated];
    
    [self.collectionView setContentOffset:CGPointMake(self.collectionView.width * self.currentPage, 0) animated:animated];
}


- (UIScrollView *)titleScr {
    if (_titleScr == nil) {
        CGFloat scrWidth = 200;
        _titleScr = [[UIScrollView alloc] initWithFrame:CGRectMake((self.width - scrWidth) / 2, self.lastBtn.y, scrWidth, self.lastBtn.height)];
        _titleScr.userInteractionEnabled = NO;
        [self addTitleLabel:_titleScr];
        
        [self addSubview:_titleScr];
    }
    return _titleScr;
}

- (void)addTitleLabel:(UIScrollView *)titleScr {
    CGFloat x = 0;
    NSDate *date = self.calendarData.minDate;
    for (int i = 0; i < self.calendarData.numOfMonths; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, titleScr.width, titleScr.height)];
        label.font = FontSize(18);
        label.textColor = UIColorFromHN(0x4c4c4c);
        label.textAlignment = NSTextAlignmentCenter;
        [titleScr addSubview:label];
        
        x += titleScr.width;
        
        NSDateComponents *components = [self.calendar components:NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
        label.text = [NSString stringWithFormat:@"%zd月  %zd",components.month ,components.year];
        
        date = [self.calendar dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:date options:0];
    }
    titleScr.contentOffset = CGPointMake(titleScr.width * self.currentPage, 0);
}

- (UIButton *)lastBtn {
    if (_lastBtn == nil) {
        CGFloat width = self.frame.size.width / 7.0;
        _lastBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _lastBtn.frame = CGRectMake(0, 0, 60, width + 10);
        _lastBtn.tag = 0;
        [_lastBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_lastBtn];
    }
    return _lastBtn;
}
- (UIButton *)nextBtn {
    if (_nextBtn == nil) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.frame = CGRectMake(self.width - 60, self.lastBtn.y, self.lastBtn.width, self.lastBtn.height);
        _nextBtn.tag = 1;
        [_nextBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_nextBtn];
    }
    return _nextBtn;
}
- (void)cgreatePageTurnImageView {
    CGFloat x, y, width, height;
    NSString *imageName ;
    for (int i = 0; i < 2; i++) {
        x = i == 0 ? self.lastBtn.width - 15 : 0;
        y = 15;
        width = 15;
        height = 15;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        imageView.centerY = self.lastBtn.centerY;
        if (i == 0) {
            [self.lastBtn addSubview:imageView];
            imageName = @"_calendar_left";
        } else {
            [self.nextBtn addSubview:imageView];
            imageName = @"_calendar_right";
        }
        imageView.image = [UIImage imageNamed:imageName];
    }
}



- (UIView *)cutLineView {
    if (_cutLineView == nil) {
        _cutLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.collectionView.maxY + 10, self.width, 0.5)];
        _cutLineView.backgroundColor = UIColorFromHN(0xc8c7cc);
        [self addSubview:_cutLineView];
    }
    return _cutLineView;
}


#pragma mark -------------------UICollectionViewDelegate/UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.calendarData.numOfMonths;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 42;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CHKCalendarCollectionViewCell *cell = (CHKCalendarCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCHKCalendarCollectionViewCell forIndexPath:indexPath];
    
    [self updateCellStyle:cell indexPath:indexPath];
    
    return cell;
}

- (void)updateCellStyle:(CHKCalendarCollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    NSDate *date = [self.manager dateForIndexPath:indexPath];
    NSInteger checkResult = [self checkDateMonth:date indexPath:indexPath];
    
    if ([self.calendar isDateInToday:date] && ![self.selectItemPath isEqual:indexPath] && checkResult == 1) {
        cell.bgStyle = CHKCalendarCollectionViewCellBgViewStyleRing;
    } else {
        cell.bgStyle = CHKCalendarCollectionViewCellFlagViewStyleNone;
    }
    
    if (checkResult != 1) {
        cell.isThisMonth = NO;
    } else {
        cell.isThisMonth = YES;
    }
    
    if ([self.selectItemPath isEqual:indexPath]) {
        cell.bgStyle = CHKCalendarCollectionViewCellBgViewStyleCircle;
    }
    
    NSString *titleNum = [self.manager titleNumForDate:date];
    NSString *titleCh = [self.manager titleChForFate:date];
    
    cell.titleLabel_num.text = titleNum;
    cell.titleLabel_ch.text = titleCh;
}
//0代表上个月、1本月、2下个月
- (NSInteger)checkDateMonth:(NSDate *)date indexPath:(NSIndexPath *)indexPath {
    NSDateComponents *components = [self.calendar components:NSCalendarUnitMonth fromDate:self.calendarData.minDate toDate:date options:0];
    if (components.month < indexPath.section) {
        return 0;
    } else if (components.month == indexPath.section) {
        return 1;
    } else {
        return 2;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDate *date = [self.manager dateForIndexPath:indexPath];
    NSInteger checkResult = [self checkDateMonth:date indexPath:indexPath];
    
    switch (checkResult) {
        case 0:
        {
            [self updateLastPage];
        }
            return;
        case 2:
        {
            [self updateNextPage];
        }
            return;
        default:
            break;
    }
    
    self.selectItemPath = indexPath;
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
    if (self.delegate) {
        [self.delegate chk_calendarItemSelectedCollectionView:collectionView indexPath:indexPath];
    }
}

#pragma mark --------------UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / scrollView.width;
    if (self.currentPage != page) {
        self.currentPage = page;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.titleScr.contentOffset = CGPointMake(scrollView.contentOffset.x * _scrScale, 0);
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / scrollView.width;
    if (self.currentPage != page) {
        self.currentPage = page;
      
    }
}



- (void)dealloc {
    NSLog(@"日历释放");
}



@end
