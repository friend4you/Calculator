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

static NSString *likesPropertyKey = @"likes";
static NSString *retweetPropertyKey = @"retweets";
static NSString *textPropertyKey = @"text";
static NSString *tweetIdPropertyKey = @"tweetId";
static NSString *userPropertyKey = @"user";

@class User;

@interface TwitterTweet ()

@end

@implementation TwitterTweet

- (instancetype)initWithCoreDataModel:(Tweet *)model {
    self = [super init];
    if (self) {
        self.likes = [NSNumber numberWithInt:model.likes];
        self.retweets = [NSNumber numberWithInt:model.retweets];
        self.text = model.text;
        self.tweetId = model.tweetId;
        self.user = [[TwitterUser alloc] initWithCoreDataModel:model.user];
    }
    return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{likesPropertyKey : favoriteCountJsonKey,
             retweetPropertyKey : retweetCountJsonKey,
             textPropertyKey : tweetTextJsonKey,
             tweetIdPropertyKey : tweetIdJsonKey,
             userPropertyKey : userJsonKey             
             };
}

#pragma mark - JSON Transformer

+ (NSValueTransformer *)userJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:TwitterUser.class];
}

@end
