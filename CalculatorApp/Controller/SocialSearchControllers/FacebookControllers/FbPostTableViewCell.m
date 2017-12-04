//
//  FbPostTableViewCell.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 12/4/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "FbPostTableViewCell.h"

@interface FbPostTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *datePostLabel;
@property (weak, nonatomic) IBOutlet UILabel *textPostLabel;

@end

@implementation FbPostTableViewCell

- (void)setUserName:(NSString *)userName {
    self.userNameLabel.text = userName;
}

- (void)setPostDate:(NSString *)postDate {
    self.datePostLabel.text = postDate;
}

- (void)setPostText:(NSString *)postText {
    self.textPostLabel.text = postText;
}

- (void)setUserImage:(UIImage *)userImage {
    self.userImageView.image = userImage;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.userNameLabel.text = nil;
    self.datePostLabel.text = nil;
    self.textPostLabel.text = nil;
    self.userImageView.image = nil;
}

@end
