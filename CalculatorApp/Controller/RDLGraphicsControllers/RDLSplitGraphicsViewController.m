//
//  RDLSplitGraphicsViewController.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/14/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "RDLSplitGraphicsViewController.h"

@interface RDLSplitGraphicsViewController ()

@end

@implementation RDLSplitGraphicsViewController

+ (RDLSplitGraphicsViewController *)instantiateFromStoryboard {
    UIStoryboard *graphicsStoryboard = [UIStoryboard storyboardWithName:@"Graphics" bundle:nil];
    RDLSplitGraphicsViewController *controller = [graphicsStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass([RDLSplitGraphicsViewController class])];
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    return YES;
}

@end
