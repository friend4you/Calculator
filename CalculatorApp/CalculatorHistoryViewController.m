//
//  CalculatorHistoryViewController.m
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/6/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import "CalculatorHistoryViewController.h"

@interface CalculatorHistoryViewController ()

@property (strong, nonatomic) NSString *resultString;

@end

@implementation CalculatorHistoryViewController

- (NSMutableArray *)expressionsForHistory {
    if (!_expressionsForHistory) {
        _expressionsForHistory = [NSMutableArray new];
    }
    return _expressionsForHistory;
}

- (NSMutableArray *)resultsForHistory {
    if (!_resultsForHistory) {
        _resultsForHistory = [[NSMutableArray alloc]  initWithArray:@[@100]];
    }
    return _resultsForHistory;
}

- (NSString *)resultString {
    if (_resultString == nil) {
        _resultString = [NSString stringWithFormat:@"%f", 20.0];
    }
    return _resultString;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//warning Incomplete implementation, return the number of rows
    return self.expressionsForHistory.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExpressionCell" forIndexPath:indexPath];
    UILabel *result = [cell viewWithTag:10];
    NSString *res = result.text;
    [self.delegate addItemViewController:self didFinishEnteringItem:res];
}



 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExpressionCell" forIndexPath:indexPath];
    
     UILabel *exp = [cell viewWithTag:5];
     UILabel *result = [cell viewWithTag:10];
     exp.text = [self.expressionsForHistory objectAtIndex:indexPath.row];
     result.text = [self.resultsForHistory objectAtIndex:0]; //[self.resultsForHistory objectAtIndex:indexPath.row];
     NSLog(@"%@", result.text);
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
