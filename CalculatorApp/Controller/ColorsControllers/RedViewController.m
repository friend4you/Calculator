//
//  RedViewController.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/16/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "RedViewController.h"

@implementation RedViewController

+ (RedViewController *)instantiateFromStoryboard {
    UIStoryboard *colorsStoryboard = [UIStoryboard storyboardWithName:@"Colors" bundle:nil];
    RedViewController *controller = [colorsStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass([RedViewController class])];
    return controller;
}

- (IBAction)unwintToRedViewController:(UIStoryboardSegue *)unwindSegue {
    
}

@end
