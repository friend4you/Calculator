//
//  ViewController.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 10/27/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (IBAction)pressDigitButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (assign, nonatomic) BOOL isUserInTheMiddleOfNumber;
@property (assign, nonatomic) BOOL isFirstNumberInExpression;
@property (assign, nonatomic) double displayValue;
@property (assign, nonatomic) double firstPartOfExpression;
@property (assign, nonatomic) double secondPartOfExpression;
@property (assign, nonatomic) BOOL isPlus;
@property (assign, nonatomic) BOOL isMinus;
@property (assign, nonatomic) BOOL isMultiple;
@property (assign, nonatomic) BOOL isDivide;

@end

@implementation ViewController

-(double)displayValue{
    return self.resultLabel.text.doubleValue;
}

-(void)setDisplayValue:(double)displayValue{
    self.resultLabel.text = @(displayValue).stringValue;
}

-(void)resetDisplayValue{
    self.isUserInTheMiddleOfNumber = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isUserInTheMiddleOfNumber = NO;
    self.isFirstNumberInExpression = YES;
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressDigitButton:(UIButton *)sender {
    if([self.resultLabel.text length] == 16){
        return;
    }
    if(self.isUserInTheMiddleOfNumber){
        self.resultLabel.text = [self.resultLabel.text stringByAppendingString:sender.titleLabel.text];
    }else{
        self.displayValue = sender.titleLabel.text.doubleValue;
        self.isUserInTheMiddleOfNumber = YES;
    }
}

- (IBAction)pressOperationButton:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"C"]){
        [self resetDisplayValue];
        self.isFirstNumberInExpression = YES;
    }else if([sender.titleLabel.text isEqualToString:@"√"]){
        self.displayValue = sqrt(self.displayValue);
        self.isUserInTheMiddleOfNumber = NO;
    }else if ([sender.titleLabel.text isEqualToString:@"𝞹"]){
        self.displayValue = M_PI;
        self.isUserInTheMiddleOfNumber = NO;
    }else if ([sender.titleLabel.text isEqualToString:@"x²"]){
        self.displayValue = pow(self.displayValue, 2);
        self.isUserInTheMiddleOfNumber = NO;
    }else if ([sender.titleLabel.text isEqualToString:@"log₂"]){
        self.displayValue = log2(self.displayValue);
        self.isUserInTheMiddleOfNumber = NO;
    }/*else if ([sender.titleLabel.text isEqualToString:@"+"]){
        self.isPlus = YES;
        NSLog(@"Before plus %@", @(temp));
        temp += self.displayValue;
        [self resetDisplayValue];
        NSLog(@"After plus %@", @(temp));
    }else if ([sender.titleLabel.text isEqualToString:@"-"]){
        temp -= self.displayValue;
        [self resetDisplayValue];
    }else if ([sender.titleLabel.text isEqualToString:@"*"]){
        
        temp *= self.displayValue;
        [self resetDisplayValue];
    }else if ([sender.titleLabel.text isEqualToString:@"/"]){
        temp /= self.displayValue;
        [self resetDisplayValue];
    }else if ([sender.titleLabel.text isEqualToString:@"="]){
        self.displayValue = temp;
    }
    self.displayValue = temp;*/
}
@end
