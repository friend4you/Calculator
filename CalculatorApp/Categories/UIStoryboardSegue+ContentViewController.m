//
//  UIStoryboardSegue+ContentViewController.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/14/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "UIStoryboardSegue+ContentViewController.h"

@implementation UIStoryboardSegue (ContentViewController)

- (UIViewController *)contentViewController {
    
    UIViewController *viewController = self.destinationViewController;
    
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        viewController = ((UINavigationController *)viewController).visibleViewController;
    }
    
    return viewController;
}

@end
