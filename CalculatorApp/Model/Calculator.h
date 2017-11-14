//
//  CalculatorModel.h
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 10/31/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculator : NSObject

- (void)performOperation:(NSString *)mathematicalSymbol;

@property (assign, nonatomic) double operand;
@property (assign, nonatomic, readonly) double result;

@property (strong, nonatomic, readonly) NSMutableArray *expressionsForHistory;
@property (strong, nonatomic, readonly) NSMutableArray *resultsForHistory;


@end
