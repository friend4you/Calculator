//
//  ViewController.h
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 10/27/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorHistoryViewController.h"

@interface ViewController : UIViewController <CalculatorHistoryDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

