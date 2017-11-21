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
#import "AuthController.h"
#import "GalaxyViewController.h"


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
    AuthController *auth = [AuthController instantiateFromStoryboard];
    auth.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Profile" image:[UIImage imageNamed:@"profileIcon"] tag:4];
    GalaxyViewController *galaxy = [GalaxyViewController instantiateFromStoryboard];
    galaxy.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Galaxy" image:[UIImage imageNamed:@""] tag:5];
    
    
    [tabs addObject:calculator];
    [tabs addObject:graphics];
    [tabs addObject:red];
    [tabs addObject:auth];
    [tabs addObject:galaxy];
    [self setViewControllers:tabs];    
}

@end
