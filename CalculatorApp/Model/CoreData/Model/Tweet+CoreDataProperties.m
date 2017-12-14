//
//  Tweet+CoreDataProperties.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 12/14/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//
//

#import "Tweet+CoreDataProperties.h"

@implementation Tweet (CoreDataProperties)

+ (NSFetchRequest<Tweet *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Tweet"];
}

@dynamic likes;
@dynamic retweets;
@dynamic text;
@dynamic tweetId;
@dynamic user;

@end
