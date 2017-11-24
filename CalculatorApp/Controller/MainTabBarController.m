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

static NSString *calculatorTitle = @"Calculator";
static NSString *graphicsTitle = @"Graphics";
static NSString *colorsTitle = @"Colors";
static NSString *profileTitle = @"Profile";
static NSString *galaxyTitle = @"Galaxy";

static NSString *calculatorImageName = @"calculatorIcon";
static NSString *graphicsImageName = @"graphicsIcon";
static NSString *colorsImageName = @"colorsIcon";
static NSString *profileImageName = @"profileIcon";
static NSString *galaxyImageName = @"galaxyIcon";

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *tabs = [[NSMutableArray alloc] initWithArray:[self viewControllers]];
    
    CalculatorViewController *calculator = [CalculatorViewController instantiateFromStoryboard];
    calculator.tabBarItem = [[UITabBarItem alloc] initWithTitle:calculatorTitle
                                                          image:[UIImage imageNamed:calculatorImageName]
                                                            tag:1];
    RDLSplitGraphicsViewController *graphics = [RDLSplitGraphicsViewController instantiateFromStoryboard];
    graphics.tabBarItem = [[UITabBarItem alloc] initWithTitle:graphicsTitle
                                                        image:[UIImage imageNamed:graphicsImageName]
                                                          tag:2];
    RedViewController *red = [RedViewController instantiateFromStoryboard];
    red.tabBarItem = [[UITabBarItem alloc] initWithTitle:colorsTitle
                                                   image:[UIImage imageNamed:colorsImageName]
                                                     tag:3];
    AuthController *profile = [AuthController instantiateFromStoryboard];
    profile.tabBarItem = [[UITabBarItem alloc] initWithTitle:profileTitle
                                                    image:[UIImage imageNamed:profileImageName]
                                                      tag:4];
    GalaxyViewController *galaxy = [GalaxyViewController instantiateFromStoryboard];
    galaxy.tabBarItem = [[UITabBarItem alloc] initWithTitle:galaxyTitle
                                                      image:[UIImage imageNamed:galaxyImageName]
                                                        tag:5];
    
    [tabs addObject:calculator];
    [tabs addObject:graphics];
    [tabs addObject:red];
    [tabs addObject:profile];
    [tabs addObject:galaxy];
    [self setViewControllers:tabs];    
}

@end
