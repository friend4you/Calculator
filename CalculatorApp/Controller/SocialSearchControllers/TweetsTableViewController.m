//
//  TweetsTableViewController.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/27/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "TweetsTableViewController.h"
#import "ImageLoadOperation.h"
#import "TweetsLoadOperation.h"
#import "TweetTableViewCell.h"
#import "TwitterLoginViewController.h"
#import <TwitterKit/TwitterKit.h>

@interface TweetsTableViewController ()

@property (strong, nonatomic) NSDictionary *tweets;
@property (strong, nonatomic) NSArray *json;
@property (strong, nonatomic) NSOperationQueue *queue;
@property (weak, nonatomic) IBOutlet UIView *footerView;

@end

@implementation TweetsTableViewController

+ (TweetsTableViewController *)instantiateFromStoryboard {
    UIStoryboard *socialSearch = [UIStoryboard storyboardWithName:@"SocialSearch" bundle:nil];
    TweetsTableViewController *controller = [socialSearch instantiateViewControllerWithIdentifier:NSStringFromClass([TweetsTableViewController class])];
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = self.footerView;   
    
}

- (void)viewWillAppear:(BOOL)animated {
    TWTRSessionStore *store = [[Twitter sharedInstance] sessionStore];
    
    if (!store.session) {
        TwitterLoginViewController *login = [TwitterLoginViewController instantiateFromStoryboard];
        [self presentViewController:login animated:YES completion:nil];
    } else {
        [self fetchTweetsFromTwitter];
    }
}

- (void)fetchTweetsFromTwitter {
    __weak typeof(self) weakSelf = self;

    TWTRSessionStore *store = [[Twitter sharedInstance] sessionStore];

    TWTRAPIClient *client = [[TWTRAPIClient alloc] initWithUserID:store.session.userID];
    
    NSString *statusesShowEndpoint = @"https://api.twitter.com/1.1/statuses/user_timeline.json";
    NSDictionary *params = @{@"user_id" : @"580097412"};
    NSError *clientError;
    
    NSURLRequest *request = [client URLRequestWithMethod:@"GET" URL:statusesShowEndpoint parameters:params error:&clientError];
    
    if (request) {
        [client sendTwitterRequest:request completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (data) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                NSError *jsonError;
                self.json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                strongSelf.tweets = [self.json objectAtIndex:0];
                [strongSelf.tableView reloadData];
            }
            else {
                NSLog(@"Error: %@", connectionError);
            }
        }];
    }
    else {
        NSLog(@"Error: %@", clientError);
    }
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSArray *keys = [self.tweets allKeys];
    return self.json.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TweetTableViewCell class]) forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *tweets = [self.json objectAtIndex:indexPath.row];
    TweetTableViewCell *tweetCell = (TweetTableViewCell *)cell;
    NSDictionary *dict = [tweets objectForKey:@"user"];
    NSString *imageUrlString = [dict objectForKey:@"profile_image_url"];//[14][2]
    NSString *text = [tweets objectForKey:@"text"];//[17]
    ImageLoadOperation *operation = [[ImageLoadOperation alloc] initWithUrl:[NSURL URLWithString:imageUrlString]];
    operation.loadCompilation = ^(UIImage *image) {
        tweetCell.avatar = image;
        
    };
    tweetCell.text = text;
    [self.queue addOperation:operation];
}
- (IBAction)twitterLogoutButton:(UIButton *)sender {
    TWTRSessionStore *store = [[Twitter sharedInstance] sessionStore];
    [store logOutUserID:store.session.userID];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)backToMainButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#define mark - Lazy Load

- (NSOperationQueue *)queue {
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
        _queue.qualityOfService = NSQualityOfServiceDefault;
    }
    return _queue;
}

@end
