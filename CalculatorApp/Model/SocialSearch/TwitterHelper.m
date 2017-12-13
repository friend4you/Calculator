//
//  TwitterHelper.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 12/7/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "TwitterHelper.h"
#import "Reachability.h"
#import <TwitterKit/TwitterKit.h>
#import "CoreDataHelper.h"

static NSString *requestMethodGET = @"GET";
static NSString *homeTimeLine = @"https://api.twitter.com/1.1/statuses/home_timeline.json";
static NSString *searchUrl = @"https://api.twitter.com/1.1/search/tweets.json";

static NSString *statusesJsonKey = @"statuses";
static NSString *userIdRequestKey = @"user_id";
static NSString *countRequestKey = @"count";
static NSString *queryRequestKey = @"q";
static NSString *cursorRequestKey = @"cursor";

@interface TwitterHelper ()

@property (nonatomic, strong) NSDictionary *homeTimeLineParams;

@end

@implementation TwitterHelper

- (void)fetchHomeTweetsFromTwitter{

    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus] == NotReachable) {
        self.getTweets([CoreDataHelper getAllTweets]);
    }
    
    TWTRSessionStore *store = [[Twitter sharedInstance] sessionStore];
    TWTRAPIClient *client = [[TWTRAPIClient alloc] initWithUserID:store.session.userID];
    
    NSError *clientError;
    NSURLRequest *request = [client URLRequestWithMethod:requestMethodGET URL:homeTimeLine parameters:nil error:&clientError];
    
    if (request) {
        [client sendTwitterRequest:request completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (data) {
                NSError *jsonError;
                NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                NSMutableArray *tweets = [[NSMutableArray alloc] init];
                for (int i = 0; i < json.count; i++) {
                    TwitterTweet *obj = [[TwitterTweet alloc] initWithTwitterModel:json[i]];
                    [tweets addObject:obj];
                }
                self.getTweets([tweets copy]);
                [CoreDataHelper saveTweetsData:[tweets copy]];
            }
        }];
    }
}

- (void)searchInTwitterWithQuery:(NSString *)query {
    
    TWTRSessionStore *store = [[Twitter sharedInstance] sessionStore];
    TWTRAPIClient *client = [[TWTRAPIClient alloc] initWithUserID:store.session.userID];
    
    NSDictionary *params = @{queryRequestKey : query};
    NSError *clientError;
    
    NSURLRequest *request = [client URLRequestWithMethod:requestMethodGET URL:searchUrl parameters:params error:&clientError];
    
    if (request) {
        [client sendTwitterRequest:request completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (data) {
                NSError *jsonError;
                NSDictionary *searchJson = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                NSArray *json = [searchJson objectForKey:statusesJsonKey];
                NSMutableArray *tweets = [[NSMutableArray alloc] init];
                for (int i = 0; i < json.count; i++) {
                    TwitterTweet *obj = [[TwitterTweet alloc] initWithTwitterModel:json[i]];
                    [tweets addObject:obj];
                }
                self.getTweets([tweets copy]);
            }
        }];
    }
}

@end
