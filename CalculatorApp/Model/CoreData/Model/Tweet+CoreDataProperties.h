//
//  Tweet+CoreDataProperties.h
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 12/7/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//
//

#import "Tweet+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Tweet (CoreDataProperties)

+ (NSFetchRequest<Tweet *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *likes;
@property (nullable, nonatomic, copy) NSString *retweets;
@property (nullable, nonatomic, copy) NSString *text;
@property (nullable, nonatomic, copy) NSString *tweetId;
@property (nullable, nonatomic, retain) User *user;

@end

NS_ASSUME_NONNULL_END
