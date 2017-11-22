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
@property (strong, nonatomic) GalaxyModel *model;
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
    self.imageScrollView.minimumZoomScale = 0.5;
    self.imageScrollView.maximumZoomScale = 3.0;
    self.imageScrollView.delegate = self;
    
    self.imageURL = self.model.imageURL;
}

- (void)didReceiveMemoryWarning {
    NSLog(@"You have memory warning");
}

- (void)fetchImage {
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:self.imageURL
                                                         completionHandler:^(NSData * _Nullable data,
                                                                             NSURLResponse * _Nullable response,
                                                                             NSError * _Nullable error) {
                                                             if (!error) {
                                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                                     self.image = [UIImage imageWithData:data];
                                                                 });
                                                             }
                                                         }];
    [task resume];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}


#define mark - Lazy loading

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
    [self.imageView sizeToFit];
    self.imageScrollView.contentSize = self.imageView.frame.size;
    CGFloat x = self.imageView.frame.size.width - self.view.frame.size.width;
    CGFloat y = self.imageView.frame.size.height - self.view.frame.size.height;
    self.imageScrollView.contentOffset = CGPointMake(x, y);
}

- (void)setImageURL:(NSURL *)imageURL {
    _imageURL = imageURL;
    
    self.image = nil;
    [self fetchImage];
}

- (GalaxyModel *)model {
    if (!_model) {
        _model = [[GalaxyModel alloc] init];
    }
    return _model;
}


@end
