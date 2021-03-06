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
- (void)deleteNumeralFromResult:(UISwipeGestureRecognizer *)gestureRecognizer;

@property (assign, nonatomic) BOOL isUserInTheMiddleOfNumber;
@property (assign, nonatomic) double displayValue;
@property (strong, nonatomic) CalculatorModel *model;
@property (assign, nonatomic) BOOL isPointInTheNumber;

@end

@implementation ViewController



- (CalculatorModel *)model {
    if (!_model) {
        _model = [CalculatorModel new];
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
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressDigitButton:(UIButton *)sender {
    if ([self.resultLabel.text length] == 16){
        return;
    }
    if ([sender.titleLabel.text isEqualToString:@"."]) {
        if (_isPointInTheNumber) {
            return;
        } else {
            _isPointInTheNumber = YES;
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

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"showHistory"]) {
//        CalculatorHistoryViewController *history = segue.destinationViewController;
//        history.delegate = self;
//        history.expressionsForHistory = self.model.expressionsForHistory;
//        history.resultsForHistory = self.model.resultsForHistory;
//    }
//}

- (IBAction)showExpressionsHistory:(UIButton *)sender {
    CalculatorHistoryViewController *history = [self.storyboard instantiateViewControllerWithIdentifier:@"historyViewController"];
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
