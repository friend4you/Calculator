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



static NSString *requestMethodGET = @"GET";

static NSString *userTimeLine = @"https://api.twitter.com/1.1/statuses/user_timeline.json";
static NSString *homeTimeLine = @"https://api.twitter.com/1.1/statuses/home_timeline.json";
static NSString *searchUrl = @"https://api.twitter.com/1.1/search/tweets.json";

static NSString *userJsonKey = @"user";
static NSString *profileImageUrlJsonKey = @"profile_image_url_https";
static NSString *favoriteCountJsonKey = @"favorite_count";
static NSString *retweetCountJsonKey = @"retweet_count";
static NSString *userNameJsonKey = @"name";
static NSString *tweetTextJsonKey = @"text";
static NSString *statusesJsonKey = @"statuses";
static NSString *userIdRequestKey = @"user_id";
static NSString *countRequestKey = @"count";
static NSString *queryRequestKey = @"q";

@interface TweetsTableViewController () <UISearchBarDelegate>

@property (strong, nonatomic) NSArray *json;
@property (strong, nonatomic) NSOperationQueue *queue;
@property (strong, nonatomic) NSOperationQueue *searchQueue;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (strong, nonatomic) NSDictionary *homeTimeLineParams;
@property (strong, nonatomic) NSDictionary *userTimeLineParams;

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
    self.tableView.rowHeight = 150;
    self.searchBar.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    TWTRSessionStore *store = [[Twitter sharedInstance] sessionStore];
    
    if (!store.session) {
        TwitterLoginViewController *login = [TwitterLoginViewController instantiateFromStoryboard];
        [self presentViewController:login animated:YES completion:nil];
    } else {
        [self fetchTweetsFromTwitterWithUrl:homeTimeLine params:_homeTimeLineParams];
    }
}

- (void)fetchTweetsFromTwitterWithUrl: (NSString *)url params:(NSDictionary *)params {
    __weak typeof(self) weakSelf = self;
    
    TWTRSessionStore *store = [[Twitter sharedInstance] sessionStore];
    TWTRAPIClient *client = [[TWTRAPIClient alloc] initWithUserID:store.session.userID];
    
    NSError *clientError;
    NSURLRequest *request = [client URLRequestWithMethod:requestMethodGET URL:url parameters:params error:&clientError];
    
    if (request) {
        [client sendTwitterRequest:request completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (data) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                NSError *jsonError;
                strongSelf.json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                [strongSelf.tableView reloadData];
            }
        }];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    __weak typeof(self) weakSelf = self;
    
    if ([searchText isEqualToString:@""]) {
        [self fetchTweetsFromTwitterWithUrl:homeTimeLine params:self.homeTimeLineParams];
        return;
    }
    
    TWTRSessionStore *store = [[Twitter sharedInstance] sessionStore];
    TWTRAPIClient *client = [[TWTRAPIClient alloc] initWithUserID:store.session.userID];
    
    NSDictionary *params = @{queryRequestKey : searchText};
    NSError *clientError;
    
    NSURLRequest *request = [client URLRequestWithMethod:requestMethodGET URL:searchUrl parameters:params error:&clientError];
    
    if (request) {
        [client sendTwitterRequest:request completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (data) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                NSError *jsonError;
                
                NSDictionary *twjson = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                strongSelf.json = [twjson objectForKey:statusesJsonKey];
                [strongSelf.tableView reloadData];
            }
        }];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.json.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetTableViewCell *tweetCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TweetTableViewCell class]) forIndexPath:indexPath];
    NSDictionary *tweets = [self.json objectAtIndex:indexPath.row];
    
    NSDictionary *dict = [tweets objectForKey:userJsonKey];
    NSString *imageUrlString = [dict objectForKey:profileImageUrlJsonKey];
    NSString *likes = [[tweets objectForKey:favoriteCountJsonKey] stringValue];
    NSString *retweets = [[tweets objectForKey:retweetCountJsonKey] stringValue];
    NSString *userName = [dict objectForKey:userNameJsonKey];
    NSString *text = [tweets objectForKey:tweetTextJsonKey];
    ImageLoadOperation *operation = [[ImageLoadOperation alloc] initWithUrl:[NSURL URLWithString:imageUrlString]];
    operation.loadCompilation = ^(UIImage *image) {
        tweetCell.avatar = image;        
    };
    [self.queue addOperation:operation];
    tweetCell.text = text;
    tweetCell.userName = userName;
    tweetCell.retweetCount = retweets;
    tweetCell.likesCount = likes;    
    return tweetCell;
}

#pragma mark - Actions

- (IBAction)twitterLogoutButton:(UIButton *)sender {
    TWTRSessionStore *store = [[Twitter sharedInstance] sessionStore];
    [store logOutUserID:store.session.userID];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)backToMainButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Lazy Load

- (NSOperationQueue *)queue {
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
        _queue.qualityOfService = NSQualityOfServiceDefault;
    }
    return _queue;
}

- (NSOperationQueue *)searchQueue {
    if (!_searchQueue) {
        _searchQueue = [[NSOperationQueue alloc]  init];
        _searchQueue.qualityOfService = NSQualityOfServiceUserInteractive;
        _searchQueue.maxConcurrentOperationCount = 1;
    }
    return _searchQueue;
}

- (NSDictionary *)homeTimeLineParams {
    if (!_homeTimeLineParams) {
        _homeTimeLineParams = @{countRequestKey : @"20"};
    }
    return _homeTimeLineParams;
}

- (NSDictionary *)userTimeLineParams {
    if (!_userTimeLineParams) {
        _userTimeLineParams = @{userIdRequestKey : @"580097412"}; //ChrisEvans twitter id: 580097412
    }
    return _userTimeLineParams;
}

@end
