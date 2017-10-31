//
//  CalculatorModel.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 10/31/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "CalculatorModel.h"

typedef enum operatorType: NSUInteger{
    OperatorUndefined,
    OperatorUnary,
    OperatorBinary,
    OperatorEqual
}Operator;

@interface CalculatorModel()

@property (assign, nonatomic, readwrite) double result;
@property (assign, nonatomic) double firstValueOfOperations;
@property (assign, nonatomic) Operator typeOfOperator;
@property (strong, nonatomic) NSDictionary *unaryOperations;
@property (strong, nonatomic) NSDictionary *binaryOperations;
@property (copy) double (^Unary)(double);
@property (copy) double (^Binary)(double, double);


@end


@implementation CalculatorModel

-(double)result{
    switch(self.typeOfOperator){
        case OperatorUndefined:
            break;
        case OperatorUnary:
            return self.Unary(self.firstValueOfOperations);
            break;
        case OperatorBinary:
            break;
        case OperatorEqual:
            break;
    }
    return 0;
}

-(NSDictionary *)unaryOperations{
    return @{
             @"√": ^(double value){
                 return sqrt(value);
             },
             @"𝞹": ^(double value){
                 return M_PI;
             },
             @"x²": ^(double value){
                 return pow(value, 2);
             },
             @"log₂": ^(double value){
                 return log2(value);
             }
             };
}

-(NSDictionary *)binaryOperations{
    return @{
             @"+": ^(double value1, double value2){
                 return value1 + value2;
             },
             @"-": ^(double value1, double value2){
                 return value1 - value2;
             },
             @"÷": ^(double value1, double value2){
                 return value1 / value2;
             },
             @"×": ^(double value1, double value2){
                 return value1 * value2;
             }
             };
}




-(void)setOperand:(NSString *)operand{
    Operator op;
    if(self.unaryOperations[operand]){
        self.typeOfOperator = OperatorUnary;
        op = OperatorUnary;
        self.Unary = self.unaryOperations[operand];
    }else if(self.binaryOperations[operand]){
        op = OperatorBinary;
        self.Binary = self.binaryOperations[operand];
    }else if([operand isEqualToString:@"="]){
        
    }
}


@end
