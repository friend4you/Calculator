//
//  TweetTableViewCell.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/27/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "TweetTableViewCell.h"
#import "ImageLoadOperation.h"

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

- (void)configureCellWithData:(TwitterTweet *)tweet queue:(NSOperationQueue *)queue{
    __weak typeof(self) weakSelf = self;
    self.tweetText.text = tweet.text;
    self.userNameLabel.text = tweet.user.name;
    self.retweetLabel.text = tweet.retweets;
    self.likesLabel.text = tweet.likes;
    NSURL *imageUrl = [NSURL URLWithString:tweet.user.image];
    ImageLoadOperation *operation = [[ImageLoadOperation alloc] initWithUrl:imageUrl];
    operation.loadCompilation = ^(UIImage *image) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.avatarImageView.image = image;
    };
    [queue addOperation:operation];
}


- (void)prepareForReuse {
    [super prepareForReuse];
    self.tweetText.text = nil;
    self.avatarImageView.image = nil;
    self.userNameLabel.text = nil;
    self.retweetLabel.text = nil;
    self.likesLabel.text = nil;
}

@end
