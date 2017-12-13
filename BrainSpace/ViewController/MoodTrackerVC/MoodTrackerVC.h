//
//  MoodTrackerVC.h
//  BrainSpace
//
//  Created by harikrishna patel on 11/12/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globle.h"

@interface MoodTrackerVC : UIViewController<GKLineGraphDataSource>

@property (nonatomic, weak) IBOutlet GKLineGraph *graph;
- (IBAction)btnMenu:(id)sender;

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSArray *labels;


@property (strong, nonatomic) IBOutlet UIImageView *imgMoodImg;
@property (strong, nonatomic) IBOutlet UIButton *btnSubmit_Mood;
- (IBAction)btnSubmit_Mood:(id)sender;


@property (strong, nonatomic) IBOutlet UIButton *btnGraphClick;
- (IBAction)btnGraphClick:(id)sender;


@end
