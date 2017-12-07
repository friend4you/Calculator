//
//  CoreDataHelper.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 12/7/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "CoreDataHelper.h"
#import "AppDelegate.h"
#import "User+CoreDataProperties.h"
#import "Tweet+CoreDataProperties.h"
#import "TwitterUser.h"
#import "TwitterTweet.h"

static NSString *tweetLikesKey = @"likes";
static NSString *tweetRetweetsKey = @"retweets";
static NSString *tweetTextKey = @"text";
static NSString *tweetIdKey = @"tweetId";
static NSString *tweetUserKey = @"user";

static NSString *userImageKey = @"image";
static NSString *userNameKey = @"name";
static NSString *userIdKey = @"userId";

@implementation CoreDataHelper

#pragma mark - Tweet CoreData Helper

+ (NSError *)saveTweetsData:(NSArray<TwitterTweet *> *)tweets {
    NSError *error = nil;
    [self deleteAllTweets];
    for (TwitterTweet *tweet in tweets) {
        error = [self saveTweetData:tweet];
        if (error) {
            return error;
        }
    }
    return error;
}

+ (NSError *)saveTweetData:(TwitterTweet *)data {
    NSManagedObjectContext *context = [CoreDataHelper getManagedObjectContext];
    NSManagedObject *inputData = [NSEntityDescription insertNewObjectForEntityForName:@"Tweet" inManagedObjectContext:context];
    
    [inputData setValue:data.likes forKey:tweetLikesKey];
    [inputData setValue:data.retweets forKey:tweetRetweetsKey];
    [inputData setValue:data.text forKey:tweetTextKey];
    [inputData setValue:data.tweetId forKey:tweetIdKey];
    User *user = [self getUserWithId:data.user.userId];
    if (!user) {
        NSError *error = [self saveUserData:data.user];
        if (!error) {
            user = [self getUserWithId:data.user.userId];
        }
    }
    [inputData setValue:user forKey:tweetUserKey];
    
    NSError *error = nil;
    if(![context save:&error]) {
        
    }
    return error;
}

+ (NSArray *)getTweetsFromContextWithPredicate:(NSPredicate *)predicate {
    NSManagedObjectContext *context = [self getManagedObjectContext];
    NSFetchRequest *fetchRequest = [Tweet fetchRequest];
    if (predicate) {
        [fetchRequest setPredicate:predicate];
    }
    NSError *error = nil;
    NSArray *requestResult = [[context executeFetchRequest:fetchRequest error:&error] mutableCopy];
    if(!error && [requestResult count] != 0) {
        return requestResult;
    }
    return nil;
}

+ (TwitterTweet *)getTweetWithId:(NSString *)tweetId {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tweetId == %@", tweetId];
    NSArray *requestResult = [self getTweetsFromContextWithPredicate:predicate];
    if(requestResult){
        return [[TwitterTweet alloc] initWithCoreDataModel:requestResult[0]];
    }
    return nil;
}

+ (NSArray<TwitterTweet *> *)getAllTweets {
    NSMutableArray *tweets = [[NSMutableArray alloc] init];
    NSArray *requestResult = [self getTweetsFromContextWithPredicate:nil];
    
    if(requestResult) {
        for (Tweet *t in requestResult) {
            TwitterTweet *tweet = [[TwitterTweet alloc] initWithCoreDataModel:t];
            [tweets addObject:tweet];
        }
    }
    
    return [tweets copy];
}

+ (void)deleteAllTweets {
    NSManagedObjectContext *context = [self getManagedObjectContext];
    NSError *error = nil;
    NSArray *requestResult = [self getTweetsFromContextWithPredicate:nil];
    for (NSManagedObject *object in requestResult) {
        [context deleteObject:object];
    }
    if(![context save:&error]){
        
    }
}

#pragma mark - User CoreData Helper

+ (NSError *)saveUserData:(TwitterUser *)data {
    NSManagedObjectContext *context = [CoreDataHelper getManagedObjectContext];
    NSManagedObject *inputData = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    [inputData setValue:data.image forKey:userImageKey];
    [inputData setValue:data.name forKey:userNameKey];
    [inputData setValue:data.userId forKey:userIdKey];
    
    NSError *error = nil;
    if(![context save:&error]) {
        
    }
    return error;
}

+ (NSArray *)getUsersFromContextWithPredicate:(NSPredicate *)predicate {
    NSManagedObjectContext *context = [self getManagedObjectContext];
    NSFetchRequest *fetchRequest = [User fetchRequest];
    if (predicate) {
        [fetchRequest setPredicate:predicate];
    }
    NSError *error = nil;
    NSArray *requestResult = [[context executeFetchRequest:fetchRequest error:&error] mutableCopy];
    if(!error && [requestResult count] != 0) {
        return requestResult;
    }
    return nil;
}

+ (User *)getUserWithId:(NSString *)userId {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId == %@", userId];
    NSArray *requestResult = [self getUsersFromContextWithPredicate:predicate];
    if(requestResult) {
        return requestResult[0];
    }
    return nil;
}

+ (void)deleteUserWithId:(NSNumber *)userId {
    NSManagedObjectContext *context = [self getManagedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId == %@", userId];
    NSError *error = nil;
    NSArray *requestResult = [self getUsersFromContextWithPredicate:predicate];
    for (NSManagedObject *object in requestResult) {
        [context deleteObject:object];
    }
    [context save:&error];
}

+ (NSManagedObjectContext *)getManagedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

@end
