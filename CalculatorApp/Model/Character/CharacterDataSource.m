//
//  CharacterDataSource.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 12/8/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "CharacterDataSource.h"

@implementation CharacterDataSource

+ (NSArray<Character *> *) characters {
    NSMutableArray *characters = [NSMutableArray arrayWithCapacity: 30];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Character_Data" ofType:@"plist"];
    
    NSArray<NSDictionary *> *dicts = [NSArray arrayWithContentsOfFile:path];
    for (NSDictionary *dict in dicts) {
        Character *character = [[Character alloc] initWithDictionary: dict];
        [characters addObject: character];
    }
    
    return characters;
}

@end
