//
//  CardCollectionViewCell.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 12/8/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "CardCell.h"
#import "GridViewLayout.h"

@interface CardCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightConstraint;
@property (assign, nonatomic) CGFloat defaultImageHeight;

@end

@implementation CardCell

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.layer.cornerRadius = self.bounds.size.width * 0.05;
        self.layer.borderWidth = 3;
        self.layer.borderColor = [UIColor colorWithRed:0.5 green:0.47 blue:0.25 alpha:1.0].CGColor;
    }
    return self;
}

- (void) prepareForReuse {
    [super prepareForReuse];
    self.characterImageView.image = nil;
    self.characterInfoLabel.text = @"";
    self.characterNameLabel.text = @"";
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    CGFloat imageWidth = self.defaultImageHeight;

    GridLayoutAttributes *attributes = (GridLayoutAttributes *)layoutAttributes;
    if ([attributes isKindOfClass:[GridLayoutAttributes class]]) {
        self.imageHeightConstraint.constant = attributes.imageHeight;
    } else {
        self.imageHeightConstraint.constant = imageWidth;
    }
}

- (void)configureCellWithCharacter:(Character *)character {
    self.characterNameLabel.text = character.name;
    self.characterImageView.image = [UIImage imageNamed:character.name];
    self.characterInfoLabel.text = character.info;
}

- (CGFloat)defaultImageHeight {
    if (!_defaultImageHeight) {
        _defaultImageHeight = self.characterImageView.frame.size.width;
    }
    return _defaultImageHeight;
}

@end
