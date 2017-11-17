//
//  MyCoolSegue.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/17/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "MyCoolSegue.h"

@implementation MyCoolSegue

- (void)perform {
    UIViewController *fromVC = [self sourceViewController];
    UIViewController *toVC = [self destinationViewController];
    
    NSMutableArray *vcs = [NSMutableArray arrayWithArray:fromVC.navigationController.viewControllers];
    [vcs removeLastObject];
    [vcs addObject:toVC];
    [fromVC.navigationController setViewControllers:vcs animated:YES];
}

@end
