//
//  TweetTableViewCell.h
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/27/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterTweet.h"

@interface TweetTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImage *avatar;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *retweetCount;
@property (strong, nonatomic) NSString *likesCount;

- (void)configureCellWithData:(TwitterTweet *)tweet queue:(NSOperationQueue *)queue;

@end
