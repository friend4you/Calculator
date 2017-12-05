//
//  User+CoreDataProperties.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 12/5/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//
//

#import "User+CoreDataProperties.h"

@implementation User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"User"];
}

@dynamic name;
@dynamic image;
@dynamic userId;
@dynamic tweets;

@end
