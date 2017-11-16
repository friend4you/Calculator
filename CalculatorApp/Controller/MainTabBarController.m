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
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIStoryboard *graphicsStoryboard = [UIStoryboard storyboardWithName:@"Graphics" bundle:nil];
    UIStoryboard *colorsStroyboard = [UIStoryboard storyboardWithName:@"Colors" bundle:nil];
    NSMutableArray *tabs = [[NSMutableArray alloc] init];
    
    
    CalculatorViewController *calculator = [mainStoryboard instantiateViewControllerWithIdentifier:@"CalculatorViewController"];
    calculator.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Calculator" image:[UIImage imageNamed:@"calculatorIcon"] tag:1];
    RDLSplitGraphicsViewController *graphics = [graphicsStoryboard instantiateViewControllerWithIdentifier:@"RDLSplitGraphicsViewController"];
    graphics.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Graphics" image:[UIImage imageNamed:@"graphicsIcon"] tag:2];
    RedViewController *red = [colorsStroyboard instantiateViewControllerWithIdentifier:@"RedViewController"];
    red.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Colors" image:[UIImage imageNamed:@"graphicsIcon"] tag:3];
    [tabs addObject:calculator];
    [tabs addObject:graphics];
    [tabs addObject:red];
    [self setViewControllers:tabs];
    
}

@end
