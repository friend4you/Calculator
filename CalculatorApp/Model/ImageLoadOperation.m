//
//  ImageLoadOperation.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/24/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "ImageLoadOperation.h"

typedef NS_ENUM(NSUInteger, OperationState) {
    ReadyState,
    ExecutingState,
    FinishedState
};

static NSString *operationReady = @"isReady";
static NSString *operationExecuting = @"isExecuting";
static NSString *operationFinished = @"isFinished";

@interface ImageLoadOperation ()

@property (strong, nonatomic) NSURL *imageUrl;
@property (assign, nonatomic) OperationState state;
@property (strong, nonatomic) NSURLSessionTask *loadTask;

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

- (void)cancel {
    [super cancel];
    
    [self.loadTask cancel];
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
                                                                 UIImage *roundedImage = [strongSelf makeCircleBorderWithImage:image];
                                                                 
                                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                                     strongSelf.loadCompilation(roundedImage);
                                                                     [strongSelf setFinishedState];
                                                                 });
                                                             }
                                                         }];
    self.loadTask = task;
    [task resume];
}

- (void)setExecutingState {
    [self willChangeValueForKey:operationReady];
    [self willChangeValueForKey:operationExecuting];
    self.state = ExecutingState;
    [self didChangeValueForKey:operationReady];
    [self didChangeValueForKey:operationExecuting];
}

- (void)setFinishedState {
    [self willChangeValueForKey:operationExecuting];
    [self willChangeValueForKey:operationFinished];
    self.state = FinishedState;
    [self didChangeValueForKey:operationExecuting];
    [self didChangeValueForKey:operationFinished];
}

- (BOOL)fileFromManager {
    __weak typeof(self) weakSelf = self;
    
    NSString *fileName = [[self.imageUrl path] lastPathComponent];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *tempDir = NSTemporaryDirectory();
    NSString *path = [tempDir stringByAppendingPathComponent:fileName];
    if ([fileManager fileExistsAtPath:path]) {
        UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfFile:path]];
        UIImage *roundedImage = [self makeCircleBorderWithImage:img];
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.loadCompilation(roundedImage);
            [weakSelf setFinishedState];
        });
        return YES;
    } else {
        return NO;
    }
}

- (void)saveImageData:(NSData *)data {
    NSString *fileName = [[self.imageUrl path] lastPathComponent];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *tempDir = NSTemporaryDirectory();
    NSString *path = [tempDir stringByAppendingPathComponent:fileName];
    [fileManager createFileAtPath:path contents:data attributes:nil];
}

- (UIImage *)makeCircleBorderWithImage:(UIImage *)image {
    CGFloat radius;
    CGRect roundedRect = CGRectZero;
    CGRect cropRect = CGRectZero;
    if(image.size.height < image.size.width) {
        radius = image.size.height / 2;
        roundedRect.size.height = image.size.height;
        roundedRect.size.width = image.size.height;
        cropRect.origin.x = (image.size.width - image.size.height) / 2;
        cropRect.size.height = image.size.height;
        cropRect.size.width = image.size.height;
    } else {
        radius = image.size.width / 2;
        roundedRect.size.height = image.size.width;
        roundedRect.size.width = image.size.width;
        cropRect.origin.y = (image.size.height - image.size.width) / 2;
        cropRect.size.height = image.size.width;
        cropRect.size.width = image.size.width;
    }
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], cropRect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    UIGraphicsBeginImageContextWithOptions(roundedRect.size, NO, 1.0);
    
    [[UIBezierPath bezierPathWithRoundedRect:roundedRect
                                cornerRadius:radius] addClip];
    [cropped drawInRect:roundedRect];
    
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return roundedImage;
}



@end
