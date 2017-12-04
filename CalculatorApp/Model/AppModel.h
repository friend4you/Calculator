//
//  AppsListModel.h
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/27/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, AppsList) {
    AppCalculator,
    AppChartView,
    AppColors,
    AppProfiler,
    AppGalaxy,
    AppSocial,
    AppListCount
};

typedef void(^AppModelActionBlock)(void);

@interface AppModel : NSObject

@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *title;
@property (assign, nonatomic) AppsList type;
@property (nonatomic, copy) AppModelActionBlock actionBlock;

@end
