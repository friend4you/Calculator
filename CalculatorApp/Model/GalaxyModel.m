//
//  GalaxyModel.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/21/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "GalaxyModel.h"

@interface GalaxyModel()

@property (strong, nonatomic)NSURL *imageURL;

@end

@implementation GalaxyModel


- (NSURL *)imageURL {
    if (!_imageURL) {
        _imageURL = [NSURL URLWithString:@"https://cdn.spacetelescope.org/archives/images/large/heic0601a.jpg"];
    }
    return _imageURL;
        
}

@end
