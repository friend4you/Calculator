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
#import "SocialSearchTabBarController.h"

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
    NSMutableArray *appMutableList = [NSMutableArray array];
    for (NSInteger i = 0; i < AppListCount; i++) {
        AppModel *model = [[AppModel alloc] init];
        model.image = [self imageNameWithType:i];
        model.title = [self titleWithType:i];
        model.actionBlock = [self actionBlockWithType:i];
        
        [appMutableList addObject:model];
    }
    
    self.appList = appMutableList;
}

- (UIImage *)imageNameWithType:(AppsList)type {
    NSDictionary *sourDict = @{@(AppCalculator) : [UIImage imageNamed:calculatorImageName],
                               @(AppChartView) : [UIImage imageNamed:graphicsImageName],
                               @(AppColors) : [UIImage imageNamed:colorsImageName],
                               @(AppProfiler) : [UIImage imageNamed:profileImageName],
                               @(AppGalaxy) : [UIImage imageNamed:galaxyImageName],
                               @(AppSocial) : [UIImage imageNamed:socialSearchImageName],
                               };
    return sourDict[@(type)];
}

- (NSString *)titleWithType:(AppsList)type {
    NSDictionary *titles = @{@(AppCalculator) : calculatorTitle,
                             @(AppChartView) : graphicsTitle,
                             @(AppColors) : colorsTitle,
                             @(AppProfiler) : profileTitle,
                             @(AppGalaxy) : galaxyTitle,
                             @(AppSocial) : socialSearchTitle,
                             };
    return titles[@(type)];
}

- (AppModelActionBlock)actionBlockWithType:(AppsList)type {
    __weak typeof(self) weakSelf = self;
    NSDictionary *sourDict = @{@(AppCalculator) : ^ {
        CalculatorViewController *calculator = [CalculatorViewController instantiateFromStoryboard];
        [weakSelf.navigationController pushViewController:calculator animated:YES];
    },
                               @(AppChartView) : ^{
                                   RDLSplitGraphicsViewController *chart = [RDLSplitGraphicsViewController instantiateFromStoryboard];
                                   [self presentViewController:chart animated:YES completion:nil];
                               },
                               @(AppColors) : ^{
                                   RedViewController *colors = [RedViewController instantiateFromStoryboard];
                                   [self.navigationController pushViewController:colors animated:YES];
                               },
                               @(AppProfiler) : ^{
                                   AuthController *profile = [AuthController instantiateFromStoryboard];
                                   [self.navigationController pushViewController:profile animated:YES];
                               },
                               @(AppGalaxy) : ^{
                                   GalaxyViewController *galaxy = [GalaxyViewController instantiateFromStoryboard];
                                   [self.navigationController pushViewController:galaxy animated:YES];
                               },
                               @(AppSocial) : ^{
                                   SocialSearchTabBarController *social = [SocialSearchTabBarController instantiateFromStoryboard];
                                   [self presentViewController:social animated:YES completion:nil];
                               }
                               };
    return sourDict[@(type)];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.appList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MainTableViewCell class]) forIndexPath:indexPath];
    AppModel *model = self.appList[indexPath.row];
    [cell updateWithModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AppModel *model = self.appList[indexPath.row];
    if (model.actionBlock) {
        model.actionBlock();
    }
}

@end
