//
//  Graphics.h
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/14/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RDLChartPointProtocol.h"

@interface Graphics : NSObject

@property (nonatomic, strong) NSArray<RDLChartPointProtocol> *chart1;
@property (nonatomic, strong) NSArray<RDLChartPointProtocol> *chart2;
@property (nonatomic, strong) NSArray<RDLChartPointProtocol> *chart3;

@end
