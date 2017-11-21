//
//  GalaxyViewController.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/21/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "GalaxyViewController.h"
#import "GalaxyModel.h"

@interface GalaxyViewController ()

@property (strong, nonatomic) NSURL *imageURL;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;


@end

@implementation GalaxyViewController

+ (GalaxyViewController *)instantiateFromStoryboard {
    UIStoryboard *galaxyStoryboard = [UIStoryboard storyboardWithName:@"Galaxy" bundle:nil];
    GalaxyViewController *controller = [galaxyStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass([GalaxyViewController class])];
    return controller;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView = [[UIImageView alloc] init];
    [self.imageScrollView addSubview:self.imageView];
    
    self.imageURL = [GalaxyModel getSpaceImage];
    
}

- (void)fetchImage {
    NSData *imageData = [NSData dataWithContentsOfURL:self.imageURL];
    self.image = [UIImage imageWithData:imageData];
}


#define mark - Lazy loading

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
    [self.imageView sizeToFit];
    self.imageScrollView.contentSize = self.imageView.frame.size;
}

- (void)setImageURL:(NSURL *)imageURL {
    self.imageURL = imageURL;
    
    self.image = nil;
    [self fetchImage];
}

- (NSURL *)imageURL {
    if (!self.imageURL) {
        self.imageURL = [GalaxyModel getSpaceImage];
    }
    
    return self.imageURL;
}



@end
