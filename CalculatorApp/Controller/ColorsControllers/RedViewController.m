//
//  RedViewController.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/16/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "RedViewController.h"
#import "Animator.h"

@implementation RedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    Animator *animator = [[Animator alloc] initWithFrame:self.view.frame];
    return animator;
}

+ (RedViewController *)instantiateFromStoryboard {
    UIStoryboard *colorsStoryboard = [UIStoryboard storyboardWithName:@"Colors" bundle:nil];
    RedViewController *controller = [colorsStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass([RedViewController class])];
    return controller;
}

- (IBAction)unwintToRedViewController:(UIStoryboardSegue *)unwindSegue {
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    segue.destinationViewController.transitioningDelegate = self;
}

@end
