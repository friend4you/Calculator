//
//  GridLayoutAttributes.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 12/11/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "GridLayoutAttributes.h"

@implementation GridLayoutAttributes

- (id)copyWithZone:(NSZone *)zone {
    GridLayoutAttributes *copy = [super copyWithZone:zone];
    if ([copy isKindOfClass:[GridLayoutAttributes class]]) {
        copy.imageHeight = self.imageHeight;
    }
    return copy;
}

- (BOOL)isEqual:(id)object {
    GridLayoutAttributes *attributes = (GridLayoutAttributes *)object;
    if ([attributes isKindOfClass:[GridLayoutAttributes class]]) {
        if (attributes.imageHeight == self.imageHeight) {
            return [super isEqual:object];
        } else {
            return NO;
        }
    }
    return NO;
}

@end
