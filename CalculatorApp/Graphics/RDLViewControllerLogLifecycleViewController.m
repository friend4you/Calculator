//
//  RDLViewControllerLogLifecycleViewController.m
//  ChartViewLab
//
//  Created by Vitalii Gervaziuk on 11/12/17.
//  Copyright © 2017 Dmitriy Frolov. All rights reserved.
//

#import "RDLViewControllerLogLifecycleViewController.h"

@interface ViewControllerLyfeCycleLog : NSObject

@property (nonatomic, strong) NSString *prefix;
@property (nonatomic, strong) NSMutableDictionary *instanceCounts;
@property (nonatomic, strong) NSDate *lastLogTime;
@property (nonatomic, assign) NSTimeInterval indentationInterval;
@property (nonatomic, strong) NSString *indentationString;

@end

@implementation ViewControllerLyfeCycleLog

-(instancetype)init {
    self = [super init];
    
    if (self) {
        self.prefix = @"";
        self.lastLogTime = [[NSDate alloc] init];
        self.instanceCounts = [[NSMutableDictionary alloc] init];
        self.indentationInterval = 1.0;
        self.indentationString = @"___";
    }
    
    return self;
}

@end

@interface RDLViewControllerLogLifecycleViewController ()

@property (nonatomic, assign) int instanceCount;

@end

@implementation RDLViewControllerLogLifecycleViewController

static ViewControllerLyfeCycleLog *lifeLog;

+(void)initialize {
    [super initialize];
    lifeLog = [[ViewControllerLyfeCycleLog alloc] init];
}

+(NSString*)logPrefixForClassName:(NSString *)className {
    if (lifeLog.lastLogTime.timeIntervalSinceNow < -lifeLog.indentationInterval) {
        lifeLog.prefix = [lifeLog.prefix stringByAppendingString:lifeLog.indentationString];
        NSLog(@"");
    }
    
    lifeLog.lastLogTime = [[NSDate alloc] init];
    
    return [lifeLog.prefix stringByAppendingString:className];
}

+(int)bumpInstanceCountForClassName:(NSString *)className {
    NSNumber *count = lifeLog.instanceCounts[className];
    int intCount = count.intValue;
    
    intCount = intCount + 1;
    
    lifeLog.instanceCounts[className] = @(intCount);
    
    return intCount;
}

-(void)logVCLMessage:(NSString *)message {
    NSString* className = NSStringFromClass([self class]);
    
    if (self.instanceCount == 0) {
        self.instanceCount = [RDLViewControllerLogLifecycleViewController bumpInstanceCountForClassName:className];
    }
    
    NSLog(@"%@(%i) %@", [RDLViewControllerLogLifecycleViewController logPrefixForClassName:className], self.instanceCount, message);
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self logVCLMessage:@"initWithCoder called"];
    }
    
    return self;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        [self logVCLMessage:@"initWithNibName called"];
    }
    
    return self;
}

-(void)dealloc {
    [self logVCLMessage:@"Controller deallocated"];
//    [super dealloc]; Called separately.
}

-(void)awakeFromNib {
    [super awakeFromNib];
    [self logVCLMessage:@"awakeFromNib is called"];
}

-(void)loadView {
    [super loadView];
    [self logVCLMessage:@"loadView is called"];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self logVCLMessage:@"viewDidLoad is called"];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self logVCLMessage:[NSString stringWithFormat:@"viewWillAppear is called animated = %@", animated ? @"true" : @"false"]];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self logVCLMessage:[NSString stringWithFormat:@"viewDidAppear is called animated = %@", animated ? @"true" : @"false"]];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self logVCLMessage:[NSString stringWithFormat:@"viewWillDisappear is called animated = %@", animated ? @"true" : @"false"]];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self logVCLMessage:[NSString stringWithFormat:@"viewDidDisappear is called animated = %@", animated ? @"true" : @"false"]];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [self logVCLMessage:@"didReceiveMemoryWarning is received"];
}

-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self logVCLMessage:[NSString stringWithFormat:@"viewWillLayoutSubviews with bounds: %@", NSStringFromCGSize(self.view.bounds.size)]];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self logVCLMessage:[NSString stringWithFormat:@"viewDidLayoutSubviews with bounds: %@", NSStringFromCGSize(self.view.bounds.size)]];
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [self logVCLMessage:[NSString stringWithFormat:@"viewWillTransitionToSize to size: %@ with coordinator", NSStringFromCGSize(size)]];
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [self logVCLMessage:@"animation begins"];
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [self logVCLMessage:@"animation completed"];
    }];
}

@end
