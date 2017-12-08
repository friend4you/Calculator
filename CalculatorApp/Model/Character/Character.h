//
//  Character.h
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 12/8/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Character : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, assign) NSInteger hitPoints;
@property (nonatomic, strong) NSString *attack;
@property (nonatomic, strong) NSString *damage;

- (instancetype) initWithDictionary: (NSDictionary *) info;

@end
