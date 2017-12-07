//
//  TwitterHelper.h
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 12/7/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^GetTweets)(NSArray *tweets);

@interface TwitterHelper : NSObject

- (void)fetchHomeTweetsFromTwitter;
- (void)searchInTwitterWithQuery:(NSString *)query;

@property (nonatomic, copy) GetTweets getTweets;

@end
