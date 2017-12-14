//
//  TwitterTweet.h
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 12/6/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TwitterKit/TwitterKit.h>
#import "TwitterUser.h"
#import "TwitterTweet.h"
#import "Tweet+CoreDataProperties.h"
#import <Mantle/Mantle.h>

@interface TwitterTweet : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readwrite) NSNumber *likes;
@property (nonatomic, copy, readwrite) NSNumber *retweets;
@property (nonatomic, copy, readwrite) NSString *text;
@property (nonatomic, copy, readwrite) NSString *tweetId;
@property (nonatomic, strong, readwrite) TwitterUser *user;

- (instancetype)initWithCoreDataModel:(Tweet *)model;

@end
