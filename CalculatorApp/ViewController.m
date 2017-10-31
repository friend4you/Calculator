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
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    [self setUpViewForOrientation:interfaceOrientation];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self setUpViewForOrientation:toInterfaceOrientation];
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
    self.model.operand = sender.titleLabel.text;
    
    
    if([sender.titleLabel.text isEqualToString:@"√"]){
        self.displayValue = sqrt(self.displayValue);
    }else if ([sender.titleLabel.text isEqualToString:@"𝞹"]){
        self.displayValue = M_PI;
    }else if ([sender.titleLabel.text isEqualToString:@"x²"]){
        self.displayValue = pow(self.displayValue, 2);
    }else if ([sender.titleLabel.text isEqualToString:@"log₂"]){
        self.displayValue = log2(self.displayValue);
    }
    self.isUserInTheMiddleOfNumber = NO;
}

-(void)setUpViewForOrientation:(UIInterfaceOrientation)orientation
{
    [_currentView removeFromSuperview];
    if(UIInterfaceOrientationIsLandscape(orientation))
    {
        [self.view addSubview:_landscapeView];
        _currentView = _landscapeView;
    }
    else
    {
        [self.view addSubview:_portraitView];
        _currentView = _portraitView;
    }
}

@end
