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
        _chartPoints1 = @[@(3), @(2), @(1)];
    }
    return _chartPoints1;
}

- (NSArray *)chartPoints2 {
    if (!_chartPoints2) {
        _chartPoints2 = @[@(1), @(2), @(3)];
    }
    return _chartPoints2;
}

- (NSArray *)chartPoints3 {
    if (!_chartPoints3) {
        _chartPoints3 = @[@(1), @(2), @(3), @(2), @(1)];
    }
    return _chartPoints3;
}

- (NSArray<RDLChartPointProtocol> *)getChartById:(NSString *)identifier {
    if ([identifier isEqualToString:@"chart1"]) {
        return [self setArrayWithDefault:self.chartPoints1];
    } else if ([identifier isEqualToString:@"chart2"]) {
        return [self setArrayWithDefault:self.chartPoints2];
    } else if ([identifier isEqualToString:@"chart3"]) {
        return [self setArrayWithDefault:self.chartPoints3];
    }
    return nil;
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
