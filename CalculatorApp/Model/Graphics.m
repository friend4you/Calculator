//
//  Graphics.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/14/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "Graphics.h"
#import "RDLPushUpsModel.h"

@interface Graphics()

@property (nonatomic, strong) NSArray *chartPoints1;
@property (nonatomic, strong) NSArray *chartPoints2;
@property (nonatomic, strong) NSArray *chartPoints3;

@end

@implementation Graphics

- (NSArray *)chartPoints1 {
    if (!_chartPoints1) {
        _chartPoints1 = @[@(1), @(2), @(3)];
    }
    return _chartPoints1;
}

- (NSArray *)chartPoints2 {
    if (!_chartPoints2) {
        _chartPoints2 = @[@(4), @(5), @(6)];
    }
    return _chartPoints2;
}

- (NSArray *)chartPoints3 {
    if (!_chartPoints3) {
        _chartPoints3 = @[@(1), @(4), @(2)];
    }
    return _chartPoints3;
}

- (NSArray<RDLChartPointProtocol> *)chart1 {
    return [self setArrayWithDefault:_chartPoints1];
}

- (NSArray<RDLChartPointProtocol> *)chart2 {
    return [self setArrayWithDefault:_chartPoints2];
}

- (NSArray<RDLChartPointProtocol> *)chart3 {
    return [self setArrayWithDefault:_chartPoints3];
}

- (NSArray<RDLChartPointProtocol> *) setArrayWithDefault: (NSArray *)array {
    NSMutableArray *pointsArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < array.count; i++) {
        NSNumber *num = array[i];
        RDLPushUpsModel *item = [[RDLPushUpsModel alloc] initWithDay:i withPushUpsAmount:num.integerValue];
        [pointsArray addObject:item];
    }
    return [pointsArray copy];
}



@end
