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
