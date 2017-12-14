//
//  Tweet+CoreDataProperties.h
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 12/14/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//
//

#import "Tweet+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Tweet (CoreDataProperties)

+ (NSFetchRequest<Tweet *> *)fetchRequest;

@property (nonatomic) int32_t likes;
@property (nonatomic) int32_t retweets;
@property (nullable, nonatomic, copy) NSString *text;
@property (nullable, nonatomic, copy) NSString *tweetId;
@property (nullable, nonatomic, retain) User *user;

@end

NS_ASSUME_NONNULL_END
