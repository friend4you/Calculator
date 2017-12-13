//
//  CardCollectionViewCell.h
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 12/8/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Character.h"

@interface CardCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *characterImageView;
@property (weak, nonatomic) IBOutlet UILabel *characterInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *characterNameLabel;

- (void)configureCellWithCharacter:(Character *)character;

@end
