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

@interface TwitterTweet : NSObject

@property (nonatomic, copy) NSString *likes;
@property (nonatomic, copy) NSString *retweets;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *tweetId;
@property (nonatomic, strong) TwitterUser *user;

- (instancetype)initWithCoreDataModel:(Tweet *)model;
- (instancetype)initWithTwitterModel: (TWTRTweet *)model;

@end
