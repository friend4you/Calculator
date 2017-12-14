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

static NSString *imagePropertyKey = @"image";
static NSString *userNamePropertyKey = @"name";
static NSString *userIdPropertyKey = @"userId";


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

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             imagePropertyKey : profileImageUrlJsonKey,
             userNamePropertyKey : userNameJsonKey,
             userIdPropertyKey : userIdJsonKey
             };
}

@end
