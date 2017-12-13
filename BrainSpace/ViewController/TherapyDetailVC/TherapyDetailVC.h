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

//===========

@property (strong, nonatomic) IBOutlet UIView *viewRating;
@property (strong, nonatomic) IBOutlet UIView *viewRating_Inner;
@property (strong, nonatomic) IBOutlet UIButton *btnClose_Rating;
- (IBAction)btnClose_Rating:(id)sender;

- (IBAction)btnRate1:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnRate;

@property (strong, nonatomic) IBOutlet UIButton *btnRate2;
- (IBAction)btnRate2:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnRate3;
- (IBAction)btnRate3:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnRate4;
- (IBAction)btnRate4:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnRate5;
- (IBAction)btnRate5:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *txtView_Feedback;

@property (strong, nonatomic) IBOutlet UIButton *btnSubmit;
- (IBAction)btnSubmit:(id)sender;


@end
