//
//  PinterestLayout.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 12/8/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "GridViewLayout.h"

@interface GridViewLayout ()

@property (nonatomic, assign) CGFloat contentHeight;

@end

@implementation GridViewLayout

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        _contentHeight = 0;
        _numberOfColums = 0;
        _cache = [NSMutableArray array];
    }
    
    return self;
}

+(Class)layoutAttributesClass {
    return [GridLayoutAttributes class];
}

- (CGFloat) width {
    UIEdgeInsets insets = self.collectionView.contentInset;
    return self.collectionView.bounds.size.width - (insets.left + insets.right);
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.width, self.contentHeight);
}

- (void)prepareLayout {
    if (self.cache.count == 0 && self.numberOfColums > 0) {
        CGFloat columnWidth = self.width / self.numberOfColums;
        
        NSMutableArray<NSNumber *> *xOffsets = [NSMutableArray array];
        NSMutableArray<NSNumber *> *yOffsets = [NSMutableArray array];
        
        for (NSInteger i = 0; i < self.numberOfColums; i++) {
            [xOffsets addObject:@(i * columnWidth)];
            [yOffsets addObject:@0];
        }
        
        NSInteger column = 0;
        for (NSInteger i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++) {
            NSIndexPath *path = [NSIndexPath indexPathForItem:i inSection:0];
            CGFloat width = columnWidth - self.padding * 2;
            CGFloat imageHeight = [self.delegate collectionView:self.collectionView heightForImageAtIndexPath:path withWidth:width];
            CGFloat descriptionHeight = [self.delegate collectionView:self.collectionView heightForDescriptionAtIndexPath:path withWidth:width];
            CGFloat height = imageHeight + descriptionHeight + self.padding * 2;
            CGRect frame = CGRectMake(xOffsets[column].floatValue, yOffsets[column].floatValue, columnWidth, height);
            CGRect insetFrame = CGRectInset(frame, self.padding, self.padding);
            GridLayoutAttributes *attributes = [GridLayoutAttributes layoutAttributesForCellWithIndexPath:path];
            attributes.frame = insetFrame;
            attributes.imageHeight = imageHeight;
            [self.cache addObject: attributes];
            
            self.contentHeight = MAX(self.contentHeight, CGRectGetMaxY(frame));
            yOffsets[column] = @(yOffsets[column].floatValue + height);
            column = (column >= (self.numberOfColums - 1)) ? 0 : (column + 1);
        }
        
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray<UICollectionViewLayoutAttributes *> *attributesArray = [NSMutableArray array];
    
    for (UICollectionViewLayoutAttributes *attributes in self.cache) {
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            [attributesArray addObject:attributes];
        }
    }
    
    return attributesArray;
}


@end
