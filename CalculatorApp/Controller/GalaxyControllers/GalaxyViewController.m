//
//  GalaxyViewController.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/21/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "GalaxyViewController.h"
#import "GalaxyModel.h"
#import "ImageLoadOperation.h"

@interface GalaxyViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) NSURL *imageURL;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) GalaxyModel *model;
@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (strong, nonatomic) NSOperationQueue *queue;

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

- (void)fetchImage {    
    ImageLoadOperation *operation = [[ImageLoadOperation alloc] initWithUrl:self.imageURL];
    operation.loadCompilation = ^(UIImage *image) {
        self.image = image;
    };
    [self.queue addOperation:operation];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

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

- (NSOperationQueue *)queue {
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
        _queue.qualityOfService = NSQualityOfServiceUserInitiated;
        _queue.suspended = NO;
        _queue.maxConcurrentOperationCount = 1;
    }
    return _queue;
}

@end
