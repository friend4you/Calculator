//
//  GalaxyCollectionViewCell.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/22/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "GalaxyCollectionViewCell.h"

@interface GalaxyCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *galaxyImageView;
@property (weak, nonatomic) IBOutlet UILabel *galaxyLabel;

@end

@implementation GalaxyCollectionViewCell

- (void)setImage:(UIImage *)image {
    self.galaxyImageView.image = image;
}

- (void)setImageDescription:(NSString *)imageDescription {
    self.galaxyLabel.text = imageDescription;
}

- (UIImage *)image {
    return self.galaxyImageView.image;
}

- (NSString *)imageDescription {
    return self.galaxyLabel.text;
}

@end
