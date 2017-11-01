//
//  ViewController.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 10/27/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorModel.h"

@interface ViewController ()

- (IBAction)pressDigitButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (assign, nonatomic) BOOL isUserInTheMiddleOfNumber;
@property (assign, nonatomic) double displayValue;
@property (strong, nonatomic) CalculatorModel *model;
@property (strong, nonatomic) IBOutlet UIView *currentView;
@property (strong, nonatomic) IBOutlet UIView *landscapeView;
@property (strong, nonatomic) IBOutlet UIView *portraitView;


@end

@implementation ViewController

-(CalculatorModel *)model{
    if(!_model) _model = [CalculatorModel new];
    return _model;
}

-(double)displayValue{
    return self.resultLabel.text.doubleValue;
    
}

-(void)setDisplayValue:(double)displayValue{
    self.resultLabel.text = @(displayValue).stringValue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isUserInTheMiddleOfNumber = NO;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressDigitButton:(UIButton *)sender {
    if([self.resultLabel.text length] == 16) return;
    if(self.isUserInTheMiddleOfNumber){
        self.resultLabel.text = [self.resultLabel.text stringByAppendingString:sender.titleLabel.text];
    }else{
        self.displayValue = sender.titleLabel.text.doubleValue;
        self.isUserInTheMiddleOfNumber = YES;
    }
}

- (IBAction)pressOperationButton:(UIButton *)sender {
    
    self.model.operand = self.displayValue;
    [self.model performOperation:sender.titleLabel.text];
    self.displayValue = self.model.result;
    
    self.isUserInTheMiddleOfNumber = NO;
}


@end
