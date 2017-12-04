//
//  FacebookLoginViewController.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 12/4/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "FacebookLoginViewController.h"
//#import <FBSDKCoreKit/FBSDKCoreKit.h>
//#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface FacebookLoginViewController ()

@end

@implementation FacebookLoginViewController

+ (FacebookLoginViewController *)instantiateFromStoryboard {
    UIStoryboard *socialSearch = [UIStoryboard storyboardWithName:@"SocialSearch" bundle:nil];
    FacebookLoginViewController *controller = [socialSearch instantiateViewControllerWithIdentifier:NSStringFromClass([FacebookLoginViewController class])];
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
//    loginButton.readPermissions = @[@"public_profile"];
//    loginButton.center = self.view.center;
//    [self.view addSubview:loginButton];
}

- (void)viewWillAppear:(BOOL)animated {
//    if ([FBSDKAccessToken currentAccessToken]) {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
}

@end
