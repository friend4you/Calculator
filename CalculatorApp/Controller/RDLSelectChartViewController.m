//
//  RDLSelectChartViewController.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/14/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "RDLSelectChartViewController.h"
#import "RDLChartViewController.h"
#import "Graphics.h"
#import "UIStoryboardSegue+ContentViewController.h"

@interface RDLSelectChartViewController ()

@end

@implementation RDLSelectChartViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {    
    UIViewController *viewController = segue.contentViewController;
    
    if ([viewController isKindOfClass:[RDLChartViewController class]]) {
        RDLChartViewController *chartViewController = (RDLChartViewController *)viewController;
        Graphics *graphics = [[Graphics alloc] init];
        
        if ([sender isKindOfClass:[UIButton class]]) {
            UIButton *chartButton = sender;
            chartViewController.navigationItem.title = chartButton.currentTitle;
        }
        chartViewController.model = [graphics getChartById:segue.identifier];
    }    
}

@end
