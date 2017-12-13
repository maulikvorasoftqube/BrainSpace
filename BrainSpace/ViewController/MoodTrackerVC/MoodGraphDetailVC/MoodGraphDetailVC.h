//
//  MoodGraphDetailVC.h
//  BrainSpace
//
//  Created by harikrishna patel on 12/12/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globle.h"

@interface MoodGraphDetailVC : UIViewController<GKLineGraphDataSource>

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSArray *labels;

@property (nonatomic, strong) ActionSheetDatePicker *actionSheetPicker;
@property (nonatomic, strong) NSDate *selected_FromDate;
@property (nonatomic, strong) NSDate *selected_ToDate;


@property (strong, nonatomic) IBOutlet UITextField *txtFromDate;
@property (strong, nonatomic) IBOutlet UIButton *btnFromDate;
- (IBAction)btnFromDate:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *txtToDate;
@property (strong, nonatomic) IBOutlet UIButton *btnToDate;
- (IBAction)btnToDate:(id)sender;
@property (strong, nonatomic) IBOutlet GKLineGraph *graph;
- (IBAction)btnBack:(id)sender;

@end
