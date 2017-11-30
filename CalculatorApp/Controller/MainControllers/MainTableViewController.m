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

typedef NS_ENUM (NSInteger, AppsList) {
    AppCalculator,
    AppChartView,
    AppColors,
    AppProfiler,
    AppGalaxy,
    AppSocial
};

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

    AppModel *chartView = [[AppModel alloc] init];
    chartView.image = [UIImage imageNamed:graphicsImageName];
    chartView.title = graphicsTitle;
    
    AppModel *color = [[AppModel alloc] init];
    color.image = [UIImage imageNamed:colorsImageName];
    color.title = colorsTitle;

    AppModel *profile = [[AppModel alloc] init];
    profile.image = [UIImage imageNamed:profileImageName];
    profile.title = profileTitle;
    
    AppModel *galaxy = [[AppModel alloc] init];
    galaxy.image = [UIImage imageNamed:galaxyImageName];
    galaxy.title = galaxyTitle;
    
    AppModel *social = [[AppModel alloc] init];
    social.image = [UIImage imageNamed:socialSearchImageName];
    social.title = socialSearchTitle;
    
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
 
    switch (indexPath.row) {
        case AppCalculator:
            [self openCalculatorController];
            break;
        case AppChartView:
            [self openChartController];
            break;
        case AppColors:
            [self openColorsController];
            break;
        case AppProfiler:
            [self openProfileController];
            break;
        case AppGalaxy:
            [self openGalaxyController];
            break;
        case AppSocial:
            [self openSocialController];
            break;
    }    
}

- (void)openCalculatorController {
    CalculatorViewController *calculator = [CalculatorViewController instantiateFromStoryboard];
    [self.navigationController pushViewController:calculator animated:YES];
}

- (void)openChartController {
    RDLSplitGraphicsViewController *chart = [RDLSplitGraphicsViewController instantiateFromStoryboard];
    [self presentViewController:chart animated:YES completion:nil];
}

- (void)openColorsController {
    RedViewController *colors = [RedViewController instantiateFromStoryboard];
    [self.navigationController pushViewController:colors animated:YES];
}

- (void)openGalaxyController {
    GalaxyViewController *galaxy = [GalaxyViewController instantiateFromStoryboard];
    [self.navigationController pushViewController:galaxy animated:YES];
}

- (void)openProfileController {
    AuthController *profile = [AuthController instantiateFromStoryboard];
    [self.navigationController pushViewController:profile animated:YES];    
}

- (void)openSocialController {
    TweetsTableViewController *twitter = [TweetsTableViewController instantiateFromStoryboard];
    [self presentViewController:twitter animated:YES completion:nil];
}

@end
