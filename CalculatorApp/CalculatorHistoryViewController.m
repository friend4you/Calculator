//
//  CalculatorHistoryViewController.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/6/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "CalculatorHistoryViewController.h"

@interface CalculatorHistoryViewController ()

@end

@implementation CalculatorHistoryViewController

- (NSMutableArray *)expressionsForHistory {
    if (!_expressionsForHistory) {
        _expressionsForHistory = [NSMutableArray new];
    }
    return _expressionsForHistory;
}

- (NSMutableArray *)resultsForHistory {
    if (!_resultsForHistory) {
        _resultsForHistory = [NSMutableArray new];
    }
    return _resultsForHistory;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.expressionsForHistory.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate addItemViewController:self didFinishEnteringItem:[self.resultsForHistory objectAtIndex:indexPath.row]];
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExpressionCell" forIndexPath:indexPath];
    
    UILabel *exp = [cell viewWithTag:5];
    UILabel *result = [cell viewWithTag:10];
    
    exp.text = [self.expressionsForHistory objectAtIndex:indexPath.row];
    result.text = [self.resultsForHistory objectAtIndex:indexPath.row];
    
    return cell;
}

@end
