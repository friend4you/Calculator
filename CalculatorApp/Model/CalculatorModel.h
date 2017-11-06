//
//  CalculatorModel.h
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 10/31/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorModel : NSObject

- (void)performOperation:(NSString *)mathematicalSymbol;

@property (assign, nonatomic) double operand;
@property (assign, nonatomic, readonly) double result;
@property (strong, nonatomic) NSMutableDictionary *expressionHistory;


@end
