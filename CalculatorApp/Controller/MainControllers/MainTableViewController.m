//
//  MainTableViewController.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/27/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "MainTableViewController.h"
#import "MainTableViewCell.h"
#import "AppModel.h"

#import "RDLChartViewController.h"
#import "CalculatorViewController.h"
#import "RDLSplitGraphicsViewController.h"
#import "RedViewController.h"
#import "AuthController.h"
#import "GalaxyViewController.h"
#import "TwitterLoginViewController.h"

static NSString *calculatorTitle = @"Calculator";
static NSString *graphicsTitle = @"Graphics";
static NSString *colorsTitle = @"Colors";
static NSString *profileTitle = @"Profile";
static NSString *galaxyTitle = @"Galaxy";
static NSString *socialSearchTitle = @"SocialSearch";

static NSString *calculatorImageName = @"calculatorIcon";
static NSString *graphicsImageName = @"graphicsIcon";
static NSString *colorsImageName = @"colorsIcon";
static NSString *profileImageName = @"profileIcon";
static NSString *galaxyImageName = @"galaxyIcon";
static NSString *socialSearchImageName = @"twitterIcon";

@interface MainTableViewController ()

@property (strong, nonatomic) NSMutableArray<AppModel *> *appList;
@property (weak, nonatomic) IBOutlet UIView *footerView;


@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setFooterView:self.footerView];
    
    [self fetchAppList];
}

- (void)fetchAppList {
    self.appList = [[NSMutableArray alloc] init];
    AppModel *calculator = [[AppModel alloc] init];
    calculator.image = [UIImage imageNamed:calculatorImageName];
    calculator.title = calculatorTitle;
    calculator.controller = [CalculatorViewController instantiateFromStoryboard];

    AppModel *chartView = [[AppModel alloc] init];
    chartView.image = [UIImage imageNamed:graphicsImageName];
    chartView.title = graphicsTitle;
    chartView.controller = [RDLSplitGraphicsViewController instantiateFromStoryboard];
    
    AppModel *color = [[AppModel alloc] init];
    color.image = [UIImage imageNamed:colorsImageName];
    color.title = colorsTitle;
    color.controller = [RedViewController instantiateFromStoryboard];

    AppModel *profile = [[AppModel alloc] init];
    profile.image = [UIImage imageNamed:profileImageName];
    profile.title = profileTitle;
    profile.controller = [AuthController instantiateFromStoryboard];
    
    AppModel *galaxy = [[AppModel alloc] init];
    galaxy.image = [UIImage imageNamed:galaxyImageName];
    galaxy.title = galaxyTitle;
    galaxy.controller = [GalaxyViewController instantiateFromStoryboard];
    
    AppModel *social = [[AppModel alloc] init];
    social.image = [UIImage imageNamed:socialSearchImageName];
    social.title = socialSearchTitle;
    social.controller = [TwitterLoginViewController instantiateFromStoryboard];
    
    [self.appList addObject:calculator];
    [self.appList addObject:chartView];
    [self.appList addObject:color];
    [self.appList addObject:profile];
    [self.appList addObject:galaxy];
    [self.appList addObject:social];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.appList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MainTableViewCell class]) forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[MainTableViewCell class]]) {
        MainTableViewCell *mainCell = (MainTableViewCell *)cell;
        mainCell.appImage = self.appList[indexPath.row].image;
        mainCell.appName = self.appList[indexPath.row].title;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *controller = self.appList[indexPath.row].controller;
    if ([controller isKindOfClass:[UISplitViewController class]]) {
        [self presentViewController:controller animated:YES completion:nil];
    } else {
        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end
