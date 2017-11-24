//
//  ImageLoadOperation.h
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/24/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^LoadComplition)(UIImage *image);

@interface ImageLoadOperation : NSOperation

- (instancetype)initWithUrl:(NSURL *)imageUrl NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@property (copy, nonatomic) LoadComplition loadCompilation;

@end
