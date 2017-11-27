//
//  TweetTableViewCell.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/27/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "TweetTableViewCell.h"

@interface TweetTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@end

@implementation TweetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIImage *)avatar {
    return self.avatarImageView.image;
}

- (void)setAvatar:(UIImage *)avatar {
    self.avatarImageView.image = avatar;
}

- (NSString *)text {
    return self.tweetText.text;
}

- (void)setText:(NSString *)text {
    self.tweetText.text = text;
}

@end
