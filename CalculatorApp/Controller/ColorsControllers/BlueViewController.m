//
//  BlueViewController.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/16/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "BlueViewController.h"

@interface BlueViewController()

@property (weak, nonatomic) IBOutlet UIView *cardView;

@end

@implementation BlueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cardView.layer.cornerRadius = 20;
    self.cardView.layer.masksToBounds = YES;    
}

@end
