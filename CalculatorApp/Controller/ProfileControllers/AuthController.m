//
//  AuthController.m
//  AuthController
//
//  Created by Dmitriy Frolow on 11/16/17.
//  Copyright © 2017 Dmitriy Frolow. All rights reserved.
//

#import "AuthController.h"
#import "ProfilesDataSource.h"

@interface AuthController ()

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *authButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *prevButton;
@property (nonatomic, strong) ProfilesDataSource *dataSource;
@property (nonatomic, weak) NSTimer *timer;


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
    [self setupUserName];
    [self setupNextButton];
    [self setupPreviousButton];
    [self setupPasswordField];
    
}

- (void)setupNextButton {
    self.nextButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.nextButton.layer.shadowOpacity = 0.5;
}

- (void)setupPreviousButton {
    self.prevButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.prevButton.layer.shadowOpacity = 0.5;
}

- (void)setupUserName {
//    self.timer =  [NSTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        [self animateUserName];
//    }];
}

- (void)setupPasswordField {
    self.passwordField.layer.cornerRadius = 10;
    self.passwordField.layer.masksToBounds = YES;
}

- (void)animateUserName {
    
    CGFloat currentPostionX = self.userNameLabel.layer.position.x;
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.x";
    animation.duration = 0.4;
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
    
}


- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)setupImageView {
    self.userImageView.layer.cornerRadius = CGRectGetHeight(self.userImageView.frame)/2;
    self.userImageView.layer.masksToBounds = YES;
    self.userImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.userImageView.layer.borderWidth = 2;
    self.userImageView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.userImageView.layer.shadowOpacity = 0.5;
    
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

- (void)renderViewWithProfile:(ProfileModel *)profile {
    self.userImageView.image = profile.profileImage;
    self.userNameLabel.text = profile.profileName;
}

#pragma mark - Actions

- (IBAction)nextProfile:(id)sender {
    
    [UIView animateWithDuration:0.25 animations:^{
        CGAffineTransform transform = CGAffineTransformMakeScale(1.7, 1.7);
        self.userNameLabel.transform = transform;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.userNameLabel.transform = CGAffineTransformIdentity;
        }];
    }];
    
    [self.dataSource nextModelWithCompletion:^(ProfileModel *model, BOOL isLastModel) {
        if (!isLastModel) {
            [UIView transitionWithView:self.userImageView
                              duration:0.25
                               options:UIViewAnimationOptionTransitionFlipFromLeft
                            animations:^{
                                [self renderViewWithProfile:model];
                            } completion:^(BOOL finished) {

                            }];
        }
    }];
    [UIView animateWithDuration:0.05 animations:^{
        CGAffineTransform transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.nextButton.transform = transform;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.05 animations:^{
            self.nextButton.transform = CGAffineTransformIdentity;
        }];
    }];
}

 - (IBAction)prevProfile:(id)sender {
     [self.dataSource previousModelWithCompletion:^(ProfileModel *model, BOOL isLastModel) {
         if (!isLastModel) {
             [UIView transitionWithView:self.userImageView
                               duration:0.25
                                options:UIViewAnimationOptionTransitionFlipFromRight
                             animations:^{
                                 [self renderViewWithProfile:model];
                             } completion:^(BOOL finished) {
                                 
                             }];
         }
     }];
     [UIView animateWithDuration:0.05 animations:^{
         CGAffineTransform transform = CGAffineTransformMakeScale(1.3, 1.3);
         self.prevButton.transform = transform;
     } completion:^(BOOL finished) {
         [UIView animateWithDuration:0.05 animations:^{
             self.prevButton.transform = CGAffineTransformIdentity;
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

@end
