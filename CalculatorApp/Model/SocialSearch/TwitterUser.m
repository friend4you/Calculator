//
//  TwitterUser.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 12/6/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "TwitterUser.h"
#import "Tweet+CoreDataProperties.h"
#import "User+CoreDataProperties.h"
#import "CoreDataHelper.h"

static NSString *profileImageUrlJsonKey = @"profile_image_url_https";
static NSString *userNameJsonKey = @"name";
static NSString *userIdJsonKey = @"id_str";

@interface TwitterUser ()

@end

@implementation TwitterUser

- (instancetype)initWithCoreDataModel:(User *)model {
    self = [super init];
    if (self) {
        self.image = model.image;
        self.name = model.name;
        self.userId = model.userId;
    }
    return self;
}

- (instancetype)initWithTwitterModel: (TWTRUser *)model {
    self = [super init];
    if (self) {
        self.image = [model valueForKey:profileImageUrlJsonKey];
        self.name = [model valueForKey:userNameJsonKey];
        self.userId = [model valueForKey:userIdJsonKey];
    }
    return self;
}

- (NSSet<Tweet *> *)tweets {
    if (!_tweets) {
        _tweets = [[NSSet alloc] init];
    }
    return _tweets;
}

@end
