//
//  TweetsLoadOperation.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/28/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "TweetsLoadOperation.h"
#import <TwitterKit/TwitterKit.h>

typedef NS_ENUM (NSUInteger, OperationState) {
    ReadyState,
    ExecutingState,
    FinishedState
};

static NSString *operationReady = @"isReady";
static NSString *operationExecuting = @"isExecuting";
static NSString *operationFinished = @"isFinished";

@interface TweetsLoadOperation ()

@property (assign, nonatomic) OperationState state;
@property (strong, nonatomic) NSURLSessionTask *loadTask;
@property (strong, nonatomic) NSString *searchText;

@end

@implementation TweetsLoadOperation

-(instancetype)initWithSearchText:(NSString *)text {
    self = [super init];
    if (self) {
        self.searchText = text;
        _state = ReadyState;
    }
    return self;
}

-(BOOL)isReady {
    if (self.state == ReadyState) {
        return YES;
    }
    return NO;
}

-(BOOL)isExecuting {
    if (self.state == ExecutingState) {
        return YES;
    }
    return NO;
}

- (BOOL)isFinished {
    if (self.state == FinishedState) {
        return YES;
    }
    return NO;
}

- (void)cancel {
    [super cancel];
    
    [self.loadTask cancel];
}

- (void)start {
    [self setExecutingState];
    __weak typeof(self) weakSelf = self;
    
    TWTRSessionStore *store = [[Twitter sharedInstance] sessionStore];
    TWTRAPIClient *client = [[TWTRAPIClient alloc] initWithUserID:store.session.userID];
    
    NSString *statusesShowEndpoint = @"https://api.twitter.com/1.1/search/tweets.json";
    NSDictionary *params = @{@"q" : self.searchText};
    NSError *clientError;
    
    NSURLRequest *request = [client URLRequestWithMethod:@"GET" URL:statusesShowEndpoint parameters:params error:&clientError];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (request) {
            [client sendTwitterRequest:request completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                if (data) {
                    __strong typeof(weakSelf) strongSelf = weakSelf;
                    NSError *jsonError;
                    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                    
                    strongSelf.loadCompilation(json);
                    [strongSelf setFinishedState];
                }
            }];
        }        
    });
}

- (void)setExecutingState {
    [self willChangeValueForKey:operationReady];
    [self willChangeValueForKey:operationExecuting];
    self.state = ExecutingState;
    [self didChangeValueForKey:operationReady];
    [self didChangeValueForKey:operationExecuting];
}

- (void)setFinishedState {
    [self willChangeValueForKey:operationExecuting];
    [self willChangeValueForKey:operationFinished];
    self.state = FinishedState;
    [self didChangeValueForKey:operationExecuting];
    [self didChangeValueForKey:operationFinished];
}

@end
