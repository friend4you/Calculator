//
//  Tweet+CoreDataProperties.h
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 12/5/17.
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
@property (nonatomic) int32_t tweetId;
@property (nullable, nonatomic, retain) NSSet<User *> *user;

@end

@interface Tweet (CoreDataGeneratedAccessors)

- (void)addUserObject:(User *)value;
- (void)removeUserObject:(User *)value;
- (void)addUser:(NSSet<User *> *)values;
- (void)removeUser:(NSSet<User *> *)values;

@end

NS_ASSUME_NONNULL_END
