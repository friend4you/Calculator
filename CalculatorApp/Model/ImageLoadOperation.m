//
//  ImageLoadOperation.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/24/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "ImageLoadOperation.h"

typedef enum : NSUInteger {
    ReadyState,
    ExecutingState,
    FinishedState
} OperationState;

@interface ImageLoadOperation ()

@property (strong, nonatomic) NSURL *imageUrl;
@property (assign, nonatomic) OperationState state;

@end

@implementation ImageLoadOperation

-(instancetype)initWithUrl:(NSURL *)imageUrl {
    self = [super init];
    if (self) {
        _imageUrl = imageUrl;
        _state = ReadyState;
    }
    return self;
}

-(BOOL)isReady {
    if (self.state == ReadyState) {
        return YES;
    }
    return NO;
}

-(BOOL)isExecuting {
    if (self.state == ExecutingState) {
        return YES;
    }
    return NO;
}

- (BOOL)isFinished {
    if (self.state == FinishedState) {
        return YES;
    }
    return NO;
}

- (void)start {
    [self setExecutingState];
    
    __weak typeof(self) weakSelf = self;
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:self.imageUrl
                                                         completionHandler:^(NSData * _Nullable data,
                                                                             NSURLResponse * _Nullable response,
                                                                             NSError * _Nullable error) {
                                                             __strong typeof(weakSelf) strongSelf = weakSelf;
                                                             
                                                             if (data) {
                                                                 UIImage *image = [UIImage imageWithData:data];
                                                                 CGFloat radius = 0;
                                                                 CGRect rect = CGRectZero;
                                                                 if(image.size.height < image.size.width) {
                                                                     radius = image.size.height / 2;
                                                                     rect.size.height = image.size.height;
                                                                     rect.size.width = image.size.height;
                                                                     //rect.origin.x = (image.size.width - image.size.height) / 2;
                                                                 } else {
                                                                     radius = image.size.width / 2;
                                                                     rect.size.height = image.size.width;
                                                                     rect.size.width = image.size.width;
                                                                     //rect.origin.y = (image.size.height - image.size.width) / 2;
                                                                 }

                                                                 // Begin a new image that will be the new image with the rounded corners
                                                                 // (here with the size of an UIImageView)
                                                                 UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1.0);

                                                                 // Add a clip before drawing anything, in the shape of an rounded rect
                                                                 [[UIBezierPath bezierPathWithRoundedRect:rect
                                                                                             cornerRadius:radius] addClip];
                                                                 // Draw your image
                                                                 [image drawInRect:rect];

                                                                 // Get the image, here setting the UIImageView image
                                                                 UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();

                                                                 // Lets forget about that we were drawing
                                                                 UIGraphicsEndImageContext();
                                                                 
                                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                                     strongSelf.loadCompilation(roundedImage);
                                                                     [strongSelf setFinishedState];
                                                                 });
                                                             }
                                                         }];
    [task resume];
}

- (void)setExecutingState {
    [self willChangeValueForKey:@"isReady"];
    [self willChangeValueForKey:@"isExecuting"];
    self.state = ExecutingState;
    [self didChangeValueForKey:@"isReady"];
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)setFinishedState {
    [self willChangeValueForKey:@"isReady"];
    [self willChangeValueForKey:@"isFinished"];
    self.state = ExecutingState;
    [self didChangeValueForKey:@"isReady"];
    [self didChangeValueForKey:@"isFinished"];
}

@end
