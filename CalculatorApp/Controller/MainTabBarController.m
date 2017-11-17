//
//  MainTabBarController.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/10/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "MainTabBarController.h"
#import "RDLChartViewController.h"
#import "CalculatorViewController.h"
#import "RDLSplitGraphicsViewController.h"
#import "RedViewController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *tabs = [[NSMutableArray alloc] initWithArray:[self viewControllers]];
    
    CalculatorViewController *calculator = [CalculatorViewController instantiateFromStoryboard];
    calculator.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Calculator" image:[UIImage imageNamed:@"calculatorIcon"] tag:1];
    RDLSplitGraphicsViewController *graphics = [RDLSplitGraphicsViewController instantiateFromStoryboard];
    graphics.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Graphics" image:[UIImage imageNamed:@"graphicsIcon"] tag:2];
    RedViewController *red = [RedViewController instantiateFromStoryboard];
    red.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Colors" image:[UIImage imageNamed:@"colorIcon"] tag:3];
    
    [tabs addObject:calculator];
    [tabs addObject:graphics];
    [tabs addObject:red];
    [self setViewControllers:tabs];    
}

@end
