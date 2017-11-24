//
//  ProfilesDataSource.m
//  AuthController
//
//  Created by Dmitriy Frolow on 11/16/17.
//  Copyright © 2017 Dmitriy Frolow. All rights reserved.
//

#import "ProfilesDataSource.h"

@interface ProfilesDataSource()

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSArray *profiles;

@end

@implementation ProfilesDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        _currentIndex = 0;
        [self loadProfiles];
    }
    return self;
}

- (ProfileModel *)currentModel {
    return self.profiles[self.currentIndex];
}

- (void)nextModelWithCompletion:(ProfilesSourceCompletion)completion {
    if (self.currentIndex < self.profiles.count-1) {
        self.currentIndex++;
        ProfileModel *profile = self.profiles[self.currentIndex];
        completion(profile,NO);
    } else {
        completion(nil,YES);
    }
}

- (void)previousModelWithCompletion:(ProfilesSourceCompletion)completion {
    if (self.currentIndex > 0) {
        self.currentIndex--;
        ProfileModel *profile = self.profiles[self.currentIndex];
        completion(profile,NO);
    } else {
        completion(nil,YES);
    }
}

- (void)loadProfiles {
    NSMutableArray *generatedProfiles = [NSMutableArray array];
    NSArray *names = @[@"Racoon", @"Dog", @"Hamster", @"Cat"];
    [names enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL * _Nonnull stop) {
        ProfileModel *profile = [[ProfileModel alloc] init];
        NSString *imageName = [NSString stringWithFormat:@"profile%lu", (unsigned long)idx];
        profile.profileImage = [UIImage imageNamed:imageName];
        profile.profileName = name;
        [generatedProfiles addObject:profile];
    }];
    
    self.profiles = generatedProfiles;
}

@end
