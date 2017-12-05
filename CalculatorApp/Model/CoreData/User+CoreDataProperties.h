//
//  User+CoreDataProperties.h
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 12/5/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//
//

#import "User+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *image;
@property (nonatomic) int32_t userId;
@property (nullable, nonatomic, retain) Tweet *tweets;

@end

NS_ASSUME_NONNULL_END
