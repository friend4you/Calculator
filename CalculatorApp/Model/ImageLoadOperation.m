//
//  ImageLoadOperation.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/24/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "ImageLoadOperation.h"

typedef enum : NSUInteger {
    ReadyState,
    ExecutingState,
    FinishedState
} OperationState;

@interface ImageLoadOperation ()

@property (strong, nonatomic) NSURL *imageUrl;
@property (assign, nonatomic) OperationState state;

@end

@implementation ImageLoadOperation

-(instancetype)initWithUrl:(NSURL *)imageUrl {
    self = [super init];
    if (self) {
        _imageUrl = imageUrl;
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

- (void)start {
    [self setExecutingState];
    
    __weak typeof(self) weakSelf = self;
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:self.imageUrl
                                                         completionHandler:^(NSData * _Nullable data,
                                                                             NSURLResponse * _Nullable response,
                                                                             NSError * _Nullable error) {
                                                             __strong typeof(weakSelf) strongSelf = weakSelf;
                                                             if (!error) {
                                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                                     strongSelf.loadCompilation([UIImage imageWithData:data]);
                                                                     [self setFinishedState];
                                                                 });
                                                             }
                                                         }];
    [task resume];
}

- (void)setExecutingState {
    [self willChangeValueForKey:@"isReady"];
    [self willChangeValueForKey:@"isExecuting"];
    self.state = ExecutingState;
    [self didChangeValueForKey:@"isReady"];
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)setFinishedState {
    [self willChangeValueForKey:@"isReady"];
    [self willChangeValueForKey:@"isExecuting"];
    self.state = ExecutingState;
    [self didChangeValueForKey:@"isReady"];
    [self didChangeValueForKey:@"isExecuting"];
}

@end
