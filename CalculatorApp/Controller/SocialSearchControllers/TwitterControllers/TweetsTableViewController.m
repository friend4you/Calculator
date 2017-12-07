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
#import "TwitterTweet.h"
#import "CoreDataHelper.h"
#import "TwitterLoginViewController.h"
#import <TwitterKit/TwitterKit.h>
#import "Reachability.h"
#import "TwitterHelper.h"

@interface TweetsTableViewController () <UISearchBarDelegate>

@property (strong, nonatomic) NSArray *json;
@property (strong, nonatomic) NSOperationQueue *queue;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (nonatomic, strong) NSMutableArray<TwitterTweet *> *tweets;
@property (strong, nonatomic) NSDictionary *homeTimeLineParams;

@end

@implementation TweetsTableViewController

+ (TweetsTableViewController *)instantiateFromStoryboard {
    UIStoryboard *socialSearch = [UIStoryboard storyboardWithName:@"SocialSearch" bundle:nil];
    TweetsTableViewController *controller = [socialSearch instantiateViewControllerWithIdentifier:NSStringFromClass([TweetsTableViewController class])];
    return controller;
}

#pragma mark - Life cycle

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
        TwitterHelper *helper = [TwitterHelper new];
        [helper fetchHomeTweetsFromTwitter];
        helper.getTweets = ^(NSArray *tweets) {
            self.tweets = [NSMutableArray arrayWithArray:tweets];
            [self.tableView reloadData];
        };
        
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if ([searchText isEqualToString:@""]) {
        TwitterHelper *helper = [TwitterHelper new];
        [helper fetchHomeTweetsFromTwitter];
        helper.getTweets = ^(NSArray *tweets) {
            self.tweets = [NSMutableArray arrayWithArray:tweets];
            [self.tableView reloadData];
        };
        return;
    }
    TwitterHelper *helper = [TwitterHelper new];
    [helper searchInTwitterWithQuery:searchText];
    helper.getTweets = ^(NSArray *tweets) {
        self.tweets = [NSMutableArray arrayWithArray:tweets];
        [self.tableView reloadData];
    };    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetTableViewCell *tweetCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TweetTableViewCell class]) forIndexPath:indexPath];
    TwitterTweet *tweet = self.tweets[indexPath.row];
    
    ImageLoadOperation *operation = [[ImageLoadOperation alloc] initWithUrl:[NSURL URLWithString:tweet.user.image]];
    operation.loadCompilation = ^(UIImage *image) {
        tweetCell.avatar = image;
    };
    [self.queue addOperation:operation];
    tweetCell.text = tweet.text;
    tweetCell.userName = tweet.user.name;
    tweetCell.retweetCount = tweet.retweets;
    tweetCell.likesCount = tweet.likes;
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

- (NSMutableArray<TwitterTweet *> *)tweets {
    if (!_tweets) {
        _tweets = [[NSMutableArray alloc] init];
    }
    return _tweets;
}

@end
