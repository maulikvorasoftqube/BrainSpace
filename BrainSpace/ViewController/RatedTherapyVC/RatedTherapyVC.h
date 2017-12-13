//
//  RatedTherapyVC.h
//  BrainSpace
//
//  Created by harikrishna patel on 11/12/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globle.h"

@interface RatedTherapyVC : UIViewController
- (IBAction)btnMenu:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tblRatedTherapList;

@end
