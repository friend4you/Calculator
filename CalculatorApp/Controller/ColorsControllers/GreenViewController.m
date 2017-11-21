//
//  GreenViewController.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/16/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "GreenViewController.h"
#import "FlipAnimatorTransitioning.h"

@interface GreenViewController()

@property (weak, nonatomic) IBOutlet UIView *cardView;


@end

@implementation GreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cardView.layer.cornerRadius = 20;
    self.cardView.layer.masksToBounds = YES;    
}

@end
