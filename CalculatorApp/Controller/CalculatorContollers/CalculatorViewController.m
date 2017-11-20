//
//  ViewController.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 10/27/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "CalculatorViewController.h"
#import "Calculator.h"

@interface CalculatorViewController ()

@property (assign, nonatomic) BOOL isUserInTheMiddleOfNumber;
@property (assign, nonatomic) double displayValue;
@property (strong, nonatomic) Calculator *model;
@property (assign, nonatomic) BOOL isPointInTheNumber;
@property (weak, nonatomic) IBOutlet UIButton *dotButton;

@end

@implementation CalculatorViewController

+ (CalculatorViewController *)instantiateFromStoryboard {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CalculatorViewController *controller = [mainStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass([CalculatorViewController class])];
    return controller;
}

- (Calculator *)model {
    
    if (!_model) {
        _model = [Calculator new];
    }
    
    return _model;
}

- (double)displayValue {
    return self.resultLabel.text.doubleValue;
}


- (void)setDisplayValue:(double)displayValue {
    self.resultLabel.text = @(displayValue).stringValue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isUserInTheMiddleOfNumber = NO;
    
    UISwipeGestureRecognizer *deleteNumeralRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(deleteNumeralFromResult:)];
    deleteNumeralRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.resultLabel setUserInteractionEnabled:YES];
    deleteNumeralRecognizer.delegate = self;
    [self.resultLabel addGestureRecognizer:deleteNumeralRecognizer];
    
    
}

- (IBAction)pressDigitButton:(UIButton *)sender {
    if ([self.resultLabel.text length] >= 16){
        return;
    }
    
    if(sender == self.dotButton)
    {
        if (self.isPointInTheNumber) {
            return;
        } else {
            self.isPointInTheNumber = YES;
        }
    }
    
    if (self.isUserInTheMiddleOfNumber) {
        self.resultLabel.text = [self.resultLabel.text stringByAppendingString:sender.titleLabel.text];
    } else {
        self.displayValue = sender.titleLabel.text.doubleValue;
        self.isUserInTheMiddleOfNumber = YES;
    }
}

- (IBAction)pressOperationButton:(UIButton *)sender {
    self.model.operand = self.displayValue;
    [self.model performOperation:sender.titleLabel.text];
    self.displayValue = self.model.result;
    
    self.isUserInTheMiddleOfNumber = NO;
    self.isPointInTheNumber = NO;
}

- (IBAction)showExpressionsHistory:(UIButton *)sender {
    CalculatorHistoryViewController *history = [self.storyboard instantiateViewControllerWithIdentifier:@"CalculatorHistoryViewController"];
    history.delegate = self;
    history.expressionsForHistory = self.model.expressionsForHistory;
    history.resultsForHistory = self.model.resultsForHistory;
    
    
    [self.navigationController pushViewController:history animated:YES];
}


- (void)addItemViewController:(CalculatorHistoryViewController *)controller didFinishEnteringItem:(NSString *)item {
    self.displayValue = [item doubleValue];
    self.isUserInTheMiddleOfNumber = NO;
}

- (void)deleteNumeralFromResult:(UISwipeGestureRecognizer *)gestureRecognizer {
    self.displayValue = [[self.resultLabel.text substringWithRange:NSMakeRange(0, self.resultLabel.text.length - 1)] doubleValue];
}

@end
