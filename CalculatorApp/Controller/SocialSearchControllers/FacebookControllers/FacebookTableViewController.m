//
//  FacebookTableViewController.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 12/4/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "FacebookTableViewController.h"
#import "FacebookLoginViewController.h"
#import "FbPostTableViewCell.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface FacebookTableViewController () <FBSDKLoginButtonDelegate>

@property (strong, nonatomic) NSArray *json;

@end

@implementation FacebookTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    loginButton.center = self.view.center;
    loginButton.delegate = self;
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:loginButton]];
}

- (void)viewWillAppear:(BOOL)animated {
    __weak typeof(self) weakSelf = self;
    if ([FBSDKAccessToken currentAccessToken]) {
        FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                      initWithGraphPath:@"/me/feed"
                                      parameters:nil
                                      HTTPMethod:@"GET"];
        [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                              id result,
                                              NSError *error) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (!error) {
                NSError *jsonError;
                strongSelf.json = [NSJSONSerialization JSONObjectWithData:result options:0 error:&jsonError];
                [strongSelf.tableView reloadData];
            }
        }];
    } else {
//        FacebookLoginViewController *login = [FacebookLoginViewController instantiateFromStoryboard];
//        [self presentViewController:login animated:YES completion:nil];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.json.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FbPostTableViewCell class]) forIndexPath:indexPath];
    
    
    
    return cell;
}

#pragma mark - Actions

- (IBAction)backToMainButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)facebookLogoutButton:(UIButton *)sender {
    
}

#pragma mark - FBSDKLoginButtonDelegate

- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
    if (error) {
        NSLog(@"Facebook error occured: %@", error.description);
        return;
    }
//    [CoreDataHelper saveFacebookAuthorizationData:[[FacebookAuthorizationDataModel alloc] initWithFacebookDataModel: result]];
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    [self.tableView reloadData];
//    [CoreDataHelper deleteFacebookAuthorizationData];
}


@end
