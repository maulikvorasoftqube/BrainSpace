//
//  HomeVC.h
//  BrainSpace
//
//  Created by harikrishna patel on 08/12/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globle.h"

@interface HomeVC : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *btnHome;
- (IBAction)btnHome:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *tblTherapyList;

@property (strong, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)btnBack:(id)sender;

@end
