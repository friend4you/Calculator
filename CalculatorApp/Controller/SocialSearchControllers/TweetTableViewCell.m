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
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;

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

- (NSString *)userName {
    return self.userNameLabel.text;
}

- (void)setUserName:(NSString *)userName {
    self.userNameLabel.text = userName;
}

- (NSString *)retweetCount {
    return self.retweetLabel.text;
}

- (void)setRetweetCount:(NSString *)retweetCount {
    self.retweetLabel.text = retweetCount;
}

- (NSString *)likesCount {
    return self.likesLabel.text;
}

- (void)setLikesCount:(NSString *)likesCount {
    self.likesLabel.text = likesCount;
}

@end
