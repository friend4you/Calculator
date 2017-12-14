//
//  TwitterUser.h
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 12/6/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TwitterKit/TwitterKit.h>
#import <Mantle/Mantle.h>

@class User, Tweet;

@interface TwitterUser : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong, readwrite) NSString *image;
@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong, readwrite) NSString *userId;

- (instancetype)initWithCoreDataModel:(User *)model;

@end
