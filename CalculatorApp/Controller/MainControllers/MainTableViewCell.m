//
//  MainTableViewCell.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/27/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "MainTableViewCell.h"
#import "AppModel.h"
@interface MainTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *appIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *appLabel;

@end

@implementation MainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateWithModel:(id)model {
    AppModel *appModel = (AppModel *)model;
    self.appLabel.text = appModel.title;
    self.appIconImageView.image = appModel.image;
}

@end
