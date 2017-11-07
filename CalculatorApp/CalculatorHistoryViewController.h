//
//  CalculatorHistoryViewController.h
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/6/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CalculatorHistoryViewController;
@protocol CalculatorHistoryDelegate <NSObject>
- (void)addItemViewController:(CalculatorHistoryViewController *)controller didFinishEnteringItem:(NSString *)item;
@end

@interface CalculatorHistoryViewController : UITableViewController

@property (nonatomic, weak) id <CalculatorHistoryDelegate> delegate;

@property (retain, nonatomic) NSMutableArray *expressionsForHistory;
@property (retain, nonatomic) NSMutableArray *resultsForHistory;
@end
