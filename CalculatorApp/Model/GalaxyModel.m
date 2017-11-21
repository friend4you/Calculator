//
//  GalaxyModel.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/21/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "GalaxyModel.h"

@implementation GalaxyModel

+ (NSURL *)getSpaceImage {
    NSURL *spaceURL = [NSURL URLWithString:@"https://cdn.spacetelescope.org/archives/images/large/heic0601a.jpg"];
    return spaceURL;
}

@end
