//
//  TwitterUser.h
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 12/6/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TwitterKit/TwitterKit.h>

@class User, Tweet;

@interface TwitterUser : NSObject

@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *userId;

- (instancetype)initWithCoreDataModel:(User *)model;
- (instancetype)initWithTwitterModel: (TWTRUser *)model;

@end
