//
//  FbPostTableViewCell.h
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 12/4/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FbPostTableViewCell : UITableViewCell

@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *postDate;
@property (strong, nonatomic) NSString *postText;
@property (strong, nonatomic) UIImage *userImage;

@end
