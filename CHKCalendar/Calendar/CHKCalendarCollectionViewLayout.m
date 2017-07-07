//
//  CHKCalendarCollectionViewLayout.m
//  Calendar-Demo
//
//  Created by 尊旅环球游 on 2017/6/2.
//  Copyright © 2017年 chk. All rights reserved.
//

#import "CHKCalendarCollectionViewLayout.h"

@interface CHKCalendarCollectionViewLayout ()

@property (nonatomic,assign) CGSize contentSize;
@property (nonatomic,strong) NSMutableArray <UICollectionViewLayoutAttributes *>*layoutAttributesArray;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;

@end

@implementation CHKCalendarCollectionViewLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    NSInteger sections = [self.collectionView numberOfSections];
    for (int i = 0; i<sections; i++) {
        NSInteger items = [self.collectionView numberOfItemsInSection:i];
        for (int j = 0; j<items; j++) {
            [self.layoutAttributesArray addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:j inSection:i]]];
        }
    }
    self.contentSize = CGSizeMake(self.collectionView.frame.size.width * sections, 0);
    if (self.endAction) {
        self.endAction();
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.size = self.itemSize;
    CGFloat width = self.itemSize.width;
    CGFloat height = self.itemSize.height;
    self.centerX = width * 0.5 + (indexPath.item % 7) * width + indexPath.section * self.collectionView.frame.size.width;
    self.centerY = height * 0.5 + (indexPath.item / 7) * height;
    
    attributes.center = CGPointMake(self.centerX, self.centerY);
    
    return attributes;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.layoutAttributesArray;
}
- (CGSize)collectionViewContentSize {
    return self.contentSize;
}

- (NSMutableArray<UICollectionViewLayoutAttributes *> *)layoutAttributesArray {
    if (_layoutAttributesArray == nil) {
        _layoutAttributesArray = [NSMutableArray array];
    }
    return _layoutAttributesArray;
}


@end
