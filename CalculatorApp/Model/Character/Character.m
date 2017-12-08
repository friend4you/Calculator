//
//  Character.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 12/8/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "Character.h"

@implementation Character

- (instancetype) initWithDictionary: (NSDictionary *) info {
    self = [super init];
    
    if (self) {
        self.name = info[@"name"];
        self.title = info[@"title"];
        self.info = info[@"description"];
        self.hitPoints = [info[@"hitPoints"] integerValue];
        self.attack = info[@"attack"];
        self.damage = info[@"damage"];
    }
    
    return self;
}

@end
