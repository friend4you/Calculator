//
//  CalculatorModel.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 10/31/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "CalculatorModel.h"

typedef NS_ENUM(NSUInteger, Operator) {
    OperatorUndefined,
    OperatorUnary,
    OperatorBinary,
    OperatorEqual,
    OperatorConst
};

typedef double(^Unary)(double);
typedef double(^Binary)(double, double);

@interface CalculatorModel()

@property (assign, nonatomic) double result;
@property (assign, nonatomic) double firstNumberInExpression;
@property (assign, nonatomic) double accumulate;
@property (strong, nonatomic) NSDictionary *constanseOperations;
@property (strong, nonatomic) NSDictionary<NSString *, Unary> *unaryOperations;
@property (strong, nonatomic) NSDictionary *binaryOperations;
@property (copy, nonatomic) Binary pendingBinaryOperation;
@property (strong, nonatomic) NSString *operation;

@end

@implementation CalculatorModel

- (double)result {
    return self.accumulate;
}

- (Operator)operationType:(NSString *)mathematicalSymbol {
    NSArray *constants = @[@"𝞹"];
    NSArray *unaryOperations = @[@"√", @"x²", @"log₂", @"±", @"C"];
    NSArray *binaryOperations = @[@"+", @"-", @"×", @"÷", @"^", @"%"];
    NSArray *equalOperation = @[@"="];
    
    if ([constants containsObject:mathematicalSymbol]) {
        return OperatorConst;
    } else if ([unaryOperations containsObject:mathematicalSymbol]) {
        return OperatorUnary;
    } else if ([binaryOperations containsObject:mathematicalSymbol]) {
        return OperatorBinary;
    } else if ([equalOperation containsObject:mathematicalSymbol]) {
        return OperatorEqual;
    }
    return OperatorUndefined;
}

- (void)performOperation:(NSString *)mathematicalSymbol {
    if (!mathematicalSymbol) {
        return;
    }
    
    Operator op = [self operationType:mathematicalSymbol];
    if(op != OperatorUndefined){
        self.operation = mathematicalSymbol;
    }
    switch (op) {
        case OperatorUnary: {
            [self calculateOperation];
            self.accumulate = [self unaryOperation:mathematicalSymbol operand:self.accumulate];
            break;
        }
        case OperatorBinary: {
            [self calculateOperation];
            self.firstNumberInExpression = self.accumulate;
            self.pendingBinaryOperation = self.binaryOperations[mathematicalSymbol];            
            break;
        }
        case OperatorConst:
            self.accumulate = [self.constanseOperations[mathematicalSymbol] doubleValue];
            break;
        case OperatorEqual:
            [self calculateOperation];
            break;
        case OperatorUndefined:
            self.accumulate = 0;
            break;
    }
}

- (void)calculateOperation {
    if (self.pendingBinaryOperation) {
        double secondValue = (double)self.accumulate;
        self.accumulate = self.pendingBinaryOperation(self.firstNumberInExpression, self.accumulate);
        [self.expressionHistory setValue:@(self.accumulate) forKey:[NSString stringWithFormat:@"%f %@ %f", _firstNumberInExpression, _operation, secondValue]];
        self.pendingBinaryOperation = nil;
    }
}


- (NSMutableDictionary<NSString *, NSString *> *)expressionHistory {
    if (!_expressionHistory) {
        _expressionHistory = [NSMutableDictionary new];
    }
    return _expressionHistory;
}

- (NSDictionary<NSString*, NSNumber *> *)constanseOperations {
    if (!_constanseOperations) {
        _constanseOperations = @{
                                @"𝞹": @(M_PI)
                                };
    }
    return _constanseOperations;
}

- (NSDictionary<NSString *, Unary> *)unaryOperations {
    if (!_unaryOperations) {
        _unaryOperations = @{
                            @"√": ^(double value) {
                                return sqrt(value);
                            },
                            @"x²": ^(double value) {
                                return pow(value, 2);
                            },
                            @"log₂": ^(double value) {
                                return log2(value);
                            },
                            @"±": ^(double value) {
                                return value * -1;
                            },
                            @"C": ^(double value) {
                                self.firstNumberInExpression = 0;
                                return 0;
                            }
                            };
    }
    return _unaryOperations;
}

- (NSDictionary<NSString *, Binary> *)binaryOperations {
    if (!_binaryOperations) {
        _binaryOperations = @{
                              @"+": ^(double value1, double value2) {
                                  return value1 + value2;
                              },
                              @"-": ^(double value1, double value2) {
                                  return value1 - value2;
                              },
                              @"÷": ^(double value1, double value2) {
                                  return value1 / value2;
                              },
                              @"×": ^(double value1, double value2) {
                                  return value1 * value2;
                              },
                              @"^": ^(double value1, double value2) {
                                  return pow(value1, value2);
                              },
                              @"%": ^(double value1, double value2) {
                                  return (double)((int)value1 % (int)value2);
                              }
                              };
    }
    return _binaryOperations;
}


- (void)setOperand:(double)operand {
    self.accumulate = operand;
}

- (double)unaryOperation:(NSString *)operation operand:(double)operand {
    Unary unary = self.unaryOperations[operation];
    return unary(operand);
}

- (double)binaryOperation:(NSString *)operation operand:(double)operand {
    Binary binary = self.binaryOperations[operation];
    return binary(self.firstNumberInExpression, operand);
}

@end
