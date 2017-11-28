//
//  TweetsLoadOperation.h
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/28/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TweetsLoadComplition)(NSDictionary *json);

@interface TweetsLoadOperation : NSOperation

@property (copy, nonatomic) TweetsLoadComplition loadCompilation;

@end
