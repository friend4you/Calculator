//
//  ProfilesDataSource.h
//  AuthController
//
//  Created by Dmitriy Frolow on 11/16/17.
//  Copyright © 2017 Dmitriy Frolow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfileModel.h"

typedef void(^ProfilesSourceCompletion)(ProfileModel *model, BOOL isLastModel);

@interface ProfilesDataSource : NSObject
- (ProfileModel *)currentModel;
- (void)nextModelWithCompletion:(ProfilesSourceCompletion)completion;
- (void)previousModelWithCompletion:(ProfilesSourceCompletion)completion;

@end
