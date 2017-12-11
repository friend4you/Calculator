//
//  LineViewLayout.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 12/8/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "LineViewLayout.h"

static CGFloat standartItemAlpha = 0.1;
static CGFloat standartItemScale = 0.2;

@interface LineViewLayout () <UICollectionViewDelegateFlowLayout>

@end

@implementation LineViewLayout


- (void)changeAttribute:(UICollectionViewLayoutAttributes *) attributes {
    CGFloat center = self.collectionView.bounds.size.width / 2.0;
    CGFloat offset = self.collectionView.contentOffset.x;
    CGFloat normalizedCenter = attributes.center.x - offset;
    CGFloat maxDistance = self.itemSize.width + self.minimumLineSpacing;
    CGFloat distance = MIN(fabs(center - normalizedCenter), maxDistance);
    
    CGFloat ratio = (maxDistance - distance) / maxDistance;
    CGFloat alpha = ratio * (1 - standartItemAlpha) + standartItemAlpha;
    CGFloat scale = ratio * (1 - standartItemScale) + standartItemScale;
    
    attributes.alpha = alpha;
    attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1);
    attributes.zIndex = alpha * 10;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    NSArray<UICollectionViewLayoutAttributes *> *attributes = [self layoutAttributesForElementsInRect:self.collectionView.bounds];
    
    CGFloat center = self.collectionView.bounds.size.width / 2;
    CGFloat proposedContentOffsetCenterOrigin = proposedContentOffset.x + center;
    
    NSArray<UICollectionViewLayoutAttributes *> *sorted = [attributes sortedArrayUsingComparator:^NSComparisonResult(UICollectionViewLayoutAttributes *obj1, UICollectionViewLayoutAttributes *obj2) {
        return fabs(obj1.center.x - proposedContentOffsetCenterOrigin) > fabs(obj2.center.x - proposedContentOffsetCenterOrigin);
    }];
    
    UICollectionViewLayoutAttributes *closest = sorted.firstObject;
    
    CGPoint targetContentOffset = CGPointMake(floorf(closest.center.x - center), proposedContentOffset.y);
    return targetContentOffset;
}

- (void)setupCollectionView {
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    
    CGSize collectionSize = self.collectionView.bounds.size;
    CGFloat xInset = (collectionSize.width - self.itemSize.width) / 2.0;
    CGFloat yInset = (collectionSize.height - self.itemSize.height) / 2.0;
    
    self.sectionInset = UIEdgeInsetsMake(yInset, xInset, yInset, xInset);
}

- (void)prepareLayout {
    [super prepareLayout];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self setupCollectionView];
    });
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *changedAttributes = [[NSMutableArray alloc] initWithCapacity:attributes.count];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        UICollectionViewLayoutAttributes *copy = attribute.copy;
        [self changeAttribute:copy];
        [changedAttributes addObject:copy];
    }
    return [changedAttributes copy];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}


@end
