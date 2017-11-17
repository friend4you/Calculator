//
//  RedViewController.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/16/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "RedViewController.h"
#import "GreenViewController.h"
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

- (IBAction)goToGreenViewControllerButton:(UIButton *)sender {
    GreenViewController *greenController = [self.storyboard instantiateViewControllerWithIdentifier:@"GreenViewController"];
    greenController.modalPresentationStyle = UIModalPresentationCustom;
    greenController.transitioningDelegate = self;
    [self presentViewController:greenController animated:YES completion:nil];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    segue.destinationViewController.modalPresentationStyle = UIModalPresentationCustom;
    segue.destinationViewController.transitioningDelegate = self;
}

@end
