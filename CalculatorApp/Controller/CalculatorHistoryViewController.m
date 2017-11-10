//
//  CalculatorHistoryViewController.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/6/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "CalculatorHistoryViewController.h"
#import "HistoryTableViewCell.h"

@implementation CalculatorHistoryViewController

- (NSMutableArray *)expressionsForHistory {
    if (!_expressionsForHistory) {
        _expressionsForHistory = [[NSMutableArray alloc] init];
    }
    return _expressionsForHistory;
}

- (NSMutableArray *)resultsForHistory {
    if (!_resultsForHistory) {
        _resultsForHistory = [[NSMutableArray alloc] init];
    }    
    return _resultsForHistory;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.expressionsForHistory.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *item = [self.resultsForHistory objectAtIndex:indexPath.row];
    [self.delegate addItemViewController:self didFinishEnteringItem:item];
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExpressionCell" forIndexPath:indexPath];
    
    cell.expressionLabel.text = [self.expressionsForHistory objectAtIndex:indexPath.row];
    cell.resultLabel.text = [self.resultsForHistory objectAtIndex:indexPath.row];
    
    return cell;
}

@end
