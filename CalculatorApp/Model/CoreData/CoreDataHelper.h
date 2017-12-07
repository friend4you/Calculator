//
//  CoreDataHelper.h
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 12/7/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TwitterKit/TwitterKit.h>
#import "User+CoreDataProperties.h"
#import "Tweet+CoreDataProperties.h"
#import "TwitterUser.h"
#import "TwitterTweet.h"

@interface CoreDataHelper : NSObject

+ (NSError *)saveTweetsData:(NSArray *)tweets;
+ (NSError *)saveTweetData:(TwitterTweet *)data;
+ (TwitterTweet *)getTweetWithId:(NSString *)tweetId;
+ (void)deleteAllTweets;
+ (NSArray<TwitterTweet *> *)getAllTweets;


+ (NSError *)saveUserData:(TwitterUser *)data;
+ (User *)getUserWithId:(NSString *)userId;
+ (void)deleteUserWithId:(NSString *)userId;

@end
