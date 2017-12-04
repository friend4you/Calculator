//
//  MainTableViewCell.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/27/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "MainTableViewCell.h"

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

#define mark - Lazy Load

- (NSString *)appName {
    return self.appLabel.text;
}

- (void)setAppName:(NSString *)appName {
    self.appLabel.text = appName;
}

- (UIImage *)appImage {
    return self.appIconImageView.image;
}

-(void)setAppImage:(UIImage *)appImage {
    self.appIconImageView.image = appImage;
}

@end
