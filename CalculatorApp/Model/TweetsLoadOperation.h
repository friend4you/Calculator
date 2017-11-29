//
//  TweetsLoadOperation.h
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/28/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TweetsLoadComplition)(NSArray *json);

@interface TweetsLoadOperation : NSOperation

- (instancetype)initWithSearchText:(NSString *)text NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@property (copy, nonatomic) TweetsLoadComplition loadCompilation;

@end
