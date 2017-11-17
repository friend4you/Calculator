//
//  RDLSplitGraphicsViewController.h
//  CalculatorApp
//
//  Created by Vladyslav Arseniuk on 11/14/17.
//  Copyright © 2017 Vladyslav Arseniuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RDLSplitGraphicsViewController : UISplitViewController<UISplitViewControllerDelegate>

+ (RDLSplitGraphicsViewController *)instantiateFromStoryboard;

@end
