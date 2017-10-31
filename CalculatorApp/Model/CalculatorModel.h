//
//  CalculatorModel.h
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 10/31/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorModel : NSObject

@property (assign, nonatomic) NSString *operand;
@property (assign, nonatomic) double firstNumberInExpression;
@property (assign, nonatomic, readonly) double result;
@end
