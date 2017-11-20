//
//  Animator.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/16/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//



#import "Animator.h"

@interface Animator()

@property (nonatomic, assign)CGRect originFrame;

@end

@implementation Animator

- (CATransform3D)yRotation:(double)angle {
    return CATransform3DMakeRotation(angle, 0.0, 1.0, 0.0);
}

- (UIView *)perspectiveTransformFor:(UIView *)containerView {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.002;
    containerView.layer.sublayerTransform = transform;
    return containerView;
}

- (instancetype)initWithFrame:(CGRect)originFrame {
    self = [super self];
    if(self) {
        self.originFrame = originFrame;
    }
    return self;
}

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *snapshotTo = [toViewController.view snapshotViewAfterScreenUpdates:YES];

    if (!snapshotTo) {
        return;
    }

    UIView *containerView = transitionContext.containerView;
    CGRect finalFrame = [transitionContext finalFrameForViewController:toViewController];

    snapshotTo.frame = self.originFrame;
    snapshotTo.layer.cornerRadius = 20;
    snapshotTo.layer.masksToBounds = YES;


    [containerView addSubview:toViewController.view];
    [containerView addSubview:snapshotTo];
    [toViewController.view setHidden:YES];

    containerView = [self perspectiveTransformFor:containerView];

    double angle = M_PI / 2;
    snapshotTo.layer.transform = [self yRotation:angle];

    NSTimeInterval duration = [self transitionDuration:transitionContext];

    [UIView animateKeyframesWithDuration:duration
                                   delay:0
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic
                              animations:^{
//                                  [UIView addKeyframeWithRelativeStartTime:0.0
//                                                          relativeDuration:0.25
//                                                                animations:^{
//                                                                    fromViewController.view.transform = CGAffineTransformMakeScale(0.8, 0.5);
//                                                                }];
                                  [UIView addKeyframeWithRelativeStartTime:0.25
                                                          relativeDuration:0.25
                                                                animations:^{
                                                                    fromViewController.view.layer.transform = [self yRotation:-(angle)];
                                                                }];
                                  [UIView addKeyframeWithRelativeStartTime:0.50
                                                          relativeDuration:0.25
                                                                animations:^{
                                                                    snapshotTo.layer.transform = [self yRotation:0.0];
                                                                }];
                                  [UIView addKeyframeWithRelativeStartTime:0.75
                                                          relativeDuration:0.25
                                                                animations:^{
                                                                    snapshotTo.frame = finalFrame;
                                                                    snapshotTo.layer.cornerRadius = 0;
                                                                }];
                                 }
                              completion:^(BOOL finished){
                                  [toViewController.view setHidden:NO];
                                  [snapshotTo removeFromSuperview];
                                  fromViewController.view.transform = CGAffineTransformIdentity;
                                  fromViewController.view.layer.transform = CATransform3DIdentity;
                                  [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                              }];

  
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 2.0;
}

@end
