//
//  TherapyDetailVC.h
//  BrainSpace
//
//  Created by harikrishna patel on 09/12/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globle.h"

@interface TherapyDetailVC : UIViewController

@property (strong, nonatomic) NSMutableArray *arrSelectedTherapy;

@property (strong, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)btnBack:(id)sender;


@property (strong, nonatomic) IBOutlet UITableView *tblTherapyDetailList;


@property (strong, nonatomic) IBOutlet UIButton *btnRate_Therapy;
- (IBAction)btnRate_Therapy:(id)sender;

@end
