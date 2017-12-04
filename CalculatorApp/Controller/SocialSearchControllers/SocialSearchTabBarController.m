//
//  SocialSearchTabBarController.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 12/4/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "SocialSearchTabBarController.h"

@interface SocialSearchTabBarController ()

@end

@implementation SocialSearchTabBarController

+ (instancetype)instantiateFromStoryboard {
    UIStoryboard *social = [UIStoryboard storyboardWithName:@"SocialSearch" bundle:nil];
    SocialSearchTabBarController *controller = [social instantiateViewControllerWithIdentifier:NSStringFromClass([SocialSearchTabBarController class])];
    return controller;
}

@end
