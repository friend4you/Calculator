//
//  AuthController.m
//  AuthController
//
//  Created by Dmitriy Frolow on 11/16/17.
//  Copyright © 2017 Dmitriy Frolow. All rights reserved.
//

#import "AuthController.h"
#import "ProfilesDataSource.h"
#import "ImageLoadOperation.h"

@interface AuthController ()

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *authButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *prevButton;
@property (nonatomic, strong) ProfilesDataSource *dataSource;
@property (nonatomic, weak) NSTimer *timer;
@property (strong, nonatomic) NSOperationQueue *queue;
@property (strong, nonatomic) ImageLoadOperation *operation;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@end

@implementation AuthController

+ (AuthController *)instantiateFromStoryboard {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Profile" bundle:nil];
    AuthController *controller = [mainStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass([AuthController class])];
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self renderViewWithProfile:[self.dataSource currentModel]];
    [self setupImageView];
    [self setupNextButton];
    [self setupPreviousButton];
    [self setupPasswordField];
    self.mainScrollView.contentSize = self.view.frame.size;
}

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - InterfaceSetup

- (void)setupNextButton {
    self.nextButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.nextButton.layer.shadowOpacity = 0.5;
}

- (void)setupPreviousButton {
    self.prevButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.prevButton.layer.shadowOpacity = 0.5;
}

- (void)setupPasswordField {
    self.passwordField.layer.cornerRadius = 10;
    self.passwordField.layer.masksToBounds = YES;
}

- (void)setupImageView {
    self.userImageView.layer.cornerRadius = CGRectGetHeight(self.userImageView.frame)/2;
    self.userImageView.layer.masksToBounds = YES;
    self.userImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.userImageView.layer.borderWidth = 2;
    self.userImageView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.userImageView.layer.shadowOpacity = 0.5;
    
    [self animateUserImage];
}

- (void)renderViewWithProfile:(ProfileModel *)profile {
    __weak typeof(self) weakSelf = self;
    self.userImageView.image = nil;
    if(_operation.isExecuting){
        [self.operation cancel];
    }
    self.operation = [[ImageLoadOperation alloc] initWithUrl:profile.profileImage];
    self.operation.loadCompilation = ^(UIImage *image) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.userImageView.image = image;
    };
    [self.queue addOperation:self.operation];
    self.userNameLabel.text = profile.profileName;
}

#pragma mark - Animations

- (void)animateUserImage {
    CABasicAnimation *borderAnimation = [CABasicAnimation animationWithKeyPath:@"borderWidth"];
    borderAnimation.toValue = @5;
    borderAnimation.duration = 1;
    borderAnimation.autoreverses = YES;
    borderAnimation.repeatCount = HUGE_VAL;
    
    
    CAKeyframeAnimation *colorAnimation = [CAKeyframeAnimation animation];
    colorAnimation.keyPath = @"borderColor";
    colorAnimation.duration = 6;
    colorAnimation.values = @[ (__bridge id )[UIColor whiteColor].CGColor,
                               (__bridge id )[UIColor magentaColor].CGColor,
                               (__bridge id )[UIColor whiteColor].CGColor];
    
    colorAnimation.keyTimes = @[@0, @0.5, @1];
    colorAnimation.repeatCount = HUGE_VAL;
    colorAnimation.autoreverses = YES;
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.animations = @[borderAnimation, colorAnimation];
    group.duration = 1;
    group.repeatCount = HUGE_VAL;
    group.autoreverses = YES;
    
    [self.userImageView.layer addAnimation:group forKey:nil];
}

- (void)animateUserName {
    
    CGFloat currentPostionX = self.userNameLabel.layer.position.x;
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.x";
    animation.duration = 0.3;
    animation.values = @[@(currentPostionX),
                         @(currentPostionX - 10),
                         @(currentPostionX + 10),
                         @(currentPostionX + 10),
                         @(currentPostionX - 10),
                         @(currentPostionX - 5),
                         @(currentPostionX + 10),
                         @(currentPostionX)];
    animation.keyTimes = @[@0, @0.14, @0.28, @0.42, @0.56, @0.70, @0.84, @1];
    [self.userNameLabel.layer addAnimation:animation forKey:nil];
    [self.passwordField.layer addAnimation:animation forKey:nil];
    [self.userImageView.layer addAnimation:animation forKey:nil];
    
}

#pragma mark - Actions

- (IBAction)nextProfile:(id)sender {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        CGAffineTransform transform = CGAffineTransformMakeScale(1.7, 1.7);
        weakSelf.userNameLabel.transform = transform;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            weakSelf.userNameLabel.transform = CGAffineTransformIdentity;
        }];
    }];
    
    [self.dataSource nextModelWithCompletion:^(ProfileModel *model, BOOL isLastModel) {
        if (!isLastModel) {
            [UIView transitionWithView:self.userImageView
                              duration:0.25
                               options:UIViewAnimationOptionTransitionFlipFromLeft
                            animations:^{
                                [weakSelf renderViewWithProfile:model];
                            } completion:^(BOOL finished) {

                            }];
        }
    }];
    [UIView animateWithDuration:0.05 animations:^{
        CGAffineTransform transform = CGAffineTransformMakeScale(1.3, 1.3);
        weakSelf.nextButton.transform = transform;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.05 animations:^{
            weakSelf.nextButton.transform = CGAffineTransformIdentity;
        }];
    }];
}

 - (IBAction)prevProfile:(id)sender {
     __weak typeof(self) weakSelf = self;
     [self.dataSource previousModelWithCompletion:^(ProfileModel *model, BOOL isLastModel) {
         if (!isLastModel) {
             __strong typeof(weakSelf) strongSelf = weakSelf;
             [UIView transitionWithView:weakSelf.userImageView
                               duration:0.25
                                options:UIViewAnimationOptionTransitionFlipFromRight
                             animations:^{
                                 [strongSelf renderViewWithProfile:model];
                             } completion:^(BOOL finished) {
                                 
                             }];
         }
     }];
     [UIView animateWithDuration:0.05 animations:^{
         CGAffineTransform transform = CGAffineTransformMakeScale(1.3, 1.3);
         weakSelf.prevButton.transform = transform;
     } completion:^(BOOL finished) {
         [UIView animateWithDuration:0.05 animations:^{
             weakSelf.prevButton.transform = CGAffineTransformIdentity;
         }];
     }];
 }

- (IBAction)checkEnteredNameButton:(UIButton *)sender {
    
    CABasicAnimation *borderAnimation = [CABasicAnimation animationWithKeyPath:@"borderWidth"];
    borderAnimation.toValue = @3;
    borderAnimation.duration = 2;
    
    CAKeyframeAnimation *colorAnimation = [CAKeyframeAnimation animation];
    colorAnimation.keyPath = @"borderColor";
    colorAnimation.duration = 2;
    
    colorAnimation.keyTimes = @[@0, @0.5, @1];
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.animations = @[borderAnimation, colorAnimation];
    group.duration = 2;
    
    if ([self.passwordField.text isEqualToString:self.userNameLabel.text]) {
        colorAnimation.values = @[ (__bridge id )[UIColor whiteColor].CGColor,
                                   (__bridge id )[UIColor greenColor].CGColor,
                                   (__bridge id )[UIColor whiteColor].CGColor];
    } else {
        colorAnimation.values = @[ (__bridge id )[UIColor whiteColor].CGColor,
                                   (__bridge id )[UIColor redColor].CGColor,
                                   (__bridge id )[UIColor whiteColor].CGColor];
        [self animateUserName];
    }
    
    [self.passwordField.layer addAnimation:group forKey:nil];
}

#pragma mark - Lazy Load

- (ProfilesDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [[ProfilesDataSource alloc] init];
    }
    return _dataSource;
}

- (NSOperationQueue *)queue {
    
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
        _queue.qualityOfService = NSQualityOfServiceUserInteractive;
    }
    return _queue;
}

@end
