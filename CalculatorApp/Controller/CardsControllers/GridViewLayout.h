//
//  PinterestLayout.h
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 12/8/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GridLayoutAttributes.h"

@class GridLayoutAttributes;

@protocol GridViewLayoutDelegate <NSObject>

- (CGFloat) collectionView: (UICollectionView *) collectionView heightForImageAtIndexPath: (NSIndexPath *) indexPath withWidth: (CGFloat) width;

- (CGFloat) collectionView: (UICollectionView *) collectionView heightForDescriptionAtIndexPath: (NSIndexPath *) indexPath withWidth: (CGFloat) width;

@end

@interface GridViewLayout : UICollectionViewLayout

@property (nonatomic, weak) id<GridViewLayoutDelegate> delegate;
@property (nonatomic, assign) NSInteger numberOfColums;
@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, strong) NSMutableArray<GridLayoutAttributes *> *cache;

@end
