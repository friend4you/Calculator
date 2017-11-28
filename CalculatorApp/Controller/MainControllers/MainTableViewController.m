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
#import "TweetsTableViewController.h"

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
    calculator.identifier = NSStringFromClass([CalculatorViewController class]);

    AppModel *chartView = [[AppModel alloc] init];
    chartView.image = [UIImage imageNamed:graphicsImageName];
    chartView.title = graphicsTitle;
    chartView.identifier = NSStringFromClass([RDLSplitGraphicsViewController class]);
    
    AppModel *color = [[AppModel alloc] init];
    color.image = [UIImage imageNamed:colorsImageName];
    color.title = colorsTitle;
    color.identifier = NSStringFromClass([RedViewController class]);

    AppModel *profile = [[AppModel alloc] init];
    profile.image = [UIImage imageNamed:profileImageName];
    profile.title = profileTitle;
    profile.identifier = NSStringFromClass([AuthController class]);
    
    AppModel *galaxy = [[AppModel alloc] init];
    galaxy.image = [UIImage imageNamed:galaxyImageName];
    galaxy.title = galaxyTitle;
    galaxy.identifier = NSStringFromClass([GalaxyViewController class]);
    
    AppModel *social = [[AppModel alloc] init];
    social.image = [UIImage imageNamed:socialSearchImageName];
    social.title = socialSearchTitle;
    social.identifier = NSStringFromClass([TweetsTableViewController class]);
    
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
    if ([self.appList[indexPath.row].identifier isEqualToString:NSStringFromClass([CalculatorViewController class])]) {
        CalculatorViewController *calculator = [CalculatorViewController instantiateFromStoryboard];
        [self.navigationController pushViewController:calculator animated:YES];
    } else if ([self.appList[indexPath.row].identifier isEqualToString:NSStringFromClass([RDLSplitGraphicsViewController class])]) {
        RDLSplitGraphicsViewController *chart = [RDLSplitGraphicsViewController instantiateFromStoryboard];
        [self presentViewController:chart animated:YES completion:nil];
    } else if ([self.appList[indexPath.row].identifier isEqualToString:NSStringFromClass([RedViewController class])]) {
        RedViewController *colors = [RedViewController instantiateFromStoryboard];
        [self.navigationController pushViewController:colors animated:YES];
    } else if ([self.appList[indexPath.row].identifier isEqualToString:NSStringFromClass([AuthController class])]) {
        AuthController *profile = [AuthController instantiateFromStoryboard];
        [self.navigationController pushViewController:profile animated:YES];
    } else if ([self.appList[indexPath.row].identifier isEqualToString:NSStringFromClass([GalaxyViewController class])]) {
        GalaxyViewController *galaxy = [GalaxyViewController instantiateFromStoryboard];
        [self.navigationController pushViewController:galaxy animated:YES];
    } else if ([self.appList[indexPath.row].identifier isEqualToString:NSStringFromClass([TweetsTableViewController class])]) {
        TweetsTableViewController *twitter = [TweetsTableViewController instantiateFromStoryboard];
        [self presentViewController:twitter animated:YES completion:nil];
    }
}

@end
