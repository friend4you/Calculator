//
//  TwitterLoginViewController.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/27/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "TwitterLoginViewController.h"
#import "TweetsTableViewController.h"
#import <TwitterKit/TwitterKit.h>

@interface TwitterLoginViewController ()

@end

@implementation TwitterLoginViewController

+ (TwitterLoginViewController *)instantiateFromStoryboard {
    UIStoryboard *socialSearch = [UIStoryboard storyboardWithName:@"SocialSearch" bundle:nil];
    TwitterLoginViewController *controller = [socialSearch instantiateViewControllerWithIdentifier:NSStringFromClass([TwitterLoginViewController class])];
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TWTRSessionStore *store = [[Twitter sharedInstance] sessionStore];
    
    if (store.session) {
        TweetsTableViewController *tweets = [TweetsTableViewController instantiateFromStoryboard];
        [self presentViewController:tweets animated:YES completion:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    TWTRLogInButton *logInButton = [TWTRLogInButton buttonWithLogInCompletion:^(TWTRSession *session, NSError *error) {
        if (session) {
            TweetsTableViewController *tweets = [TweetsTableViewController instantiateFromStoryboard];
            [self presentViewController:tweets animated:YES completion:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            NSLog(@"error: %@", [error localizedDescription]);
        }
    }];
    logInButton.center = self.view.center;
    [self.view addSubview:logInButton];
}

@end
