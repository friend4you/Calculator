//
//  TwitterTweet.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 12/6/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "TwitterTweet.h"
#import "Tweet+CoreDataProperties.h"
#import "CoreDataHelper.h"

static NSString *userJsonKey = @"user";
static NSString *favoriteCountJsonKey = @"favorite_count";
static NSString *retweetCountJsonKey = @"retweet_count";
static NSString *tweetTextJsonKey = @"text";
static NSString *tweetIdJsonKey = @"id_str";
@class User;

@interface TwitterTweet ()

@end

@implementation TwitterTweet

- (instancetype)initWithCoreDataModel:(Tweet *)model {
    self = [super init];
    if (self) {
        self.likes = model.likes;
        self.retweets = model.retweets;
        self.text = model.text;
        self.tweetId = model.tweetId;
        self.user = [[TwitterUser alloc] initWithCoreDataModel:model.user];
    }
    return self;
}

- (instancetype)initWithTwitterModel: (TWTRTweet *)model {
    TWTRUser *user = [model valueForKey:userJsonKey];
    self.likes = [[model valueForKey:favoriteCountJsonKey] stringValue];
    self.retweets = [[model valueForKey:retweetCountJsonKey] stringValue];
    self.text = [model valueForKey:tweetTextJsonKey];
    self.tweetId = [model valueForKey:tweetIdJsonKey];
    self.user = [[TwitterUser alloc] initWithTwitterModel:user];

    return self;
}


@end
