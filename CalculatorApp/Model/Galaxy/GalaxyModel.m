//
//  GalaxyModel.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/21/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "GalaxyModel.h"
#import "GalaxyCellModel.h"

@interface GalaxyModel()

@property (strong, nonatomic)NSURL *imageURL;
@property (strong, nonatomic, readwrite)NSArray *model;

@end

@implementation GalaxyModel

- (NSURL *)imageURL {
    if (!_imageURL) {
        _imageURL = [NSURL URLWithString:@"http://magazine.viterbi.usc.edu/wp-content/uploads/BSP_054.jpg"];
        // http://magazine.viterbi.usc.edu/wp-content/uploads/BSP_054.jpg //
        // https://cdn.spacetelescope.org/archives/images/large/heic0601a.jpg // 18000 × 18000
        // http://www.faustisland.com/wp-content/uploads/2017/03/pexels-photo-107956.jpeg // 5257 × 3474
        // https://www.jpl.nasa.gov/images/wise/20131030/pia17553-full.jpg // 9163 × 9163
        // https://upload.wikimedia.org/wikipedia/commons/f/f9/The_hidden_fires_of_the_Flame_Nebula.jpg // 12564 × 15283
    }
    return _imageURL;
}

- (NSArray *)model {
    if (!_model) {
        _model = [self fetchModel];
    }
    return _model;
}

- (NSArray *)fetchModel {
    NSMutableArray *model = [[NSMutableArray alloc] init];
    
    
    return [model copy];
}

@end
