//
//  MoodGraphDetailVC.m
//  BrainSpace
//
//  Created by harikrishna patel on 12/12/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "MoodGraphDetailVC.h"

@interface MoodGraphDetailVC ()

@end

@implementation MoodGraphDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)commonData
{
    [Utility setRightViewOfTextField:self.txtFromDate rightImageName:@"down_arrow"];
    [Utility setRightViewOfTextField:self.txtToDate rightImageName:@"down_arrow"];
    
    [Utility setLeftViewInTextField:self.txtFromDate imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:self.txtToDate imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    //
    self.selected_FromDate = [NSDate date];
    self.selected_ToDate = [NSDate date];

    [self _setupExampleGraph];
    
}

- (void)_setupExampleGraph {
    
    self.data = @[
                  @[@20, @40, @20, @60, @40, @140, @80],
                  @[@40, @20, @60, @100, @60, @20, @60],
                  @[@80, @60, @40, @160, @100, @40, @110]
                  ];
    
    self.labels = @[@"2001", @"2002", @"2003", @"2004", @"2005", @"2006", @"2007"];
    
    self.graph.dataSource = self;
    self.graph.lineWidth = 3.0;
    
    self.graph.valueLabelCount = 6;
    
    [self.graph draw];
}

#pragma mark - GKLineGraphDataSource

- (NSInteger)numberOfLines {
    return [self.data count];
}

- (UIColor *)colorForLineAtIndex:(NSInteger)index {
    id colors = @[[UIColor colorWithRed:226/255.0f green:13/255.0f blue:30/255.0f alpha:1.0f],
                  [UIColor colorWithRed:0/255.0f green:174/255.0f blue:48/255.0f alpha:1.0f],
                  [UIColor colorWithRed:235/255.0f green:230/255.0f blue:70/255.0f alpha:1.0f]
                  ];
    return [colors objectAtIndex:index];
}

- (NSArray *)valuesForLineAtIndex:(NSInteger)index {
    return [self.data objectAtIndex:index];
}

- (CFTimeInterval)animationDurationForLineAtIndex:(NSInteger)index {
    return [[@[@1, @1.6, @2.2, @1.4] objectAtIndex:index] doubleValue];
}

- (NSString *)titleForLineAtIndex:(NSInteger)index {
    return [self.labels objectAtIndex:index];
}


#pragma mark - actionSheet delegate

- (void)dateWasSelected:(NSDate *)selectedDate element:(id)element
{
    UIButton *btn=(UIButton*)element;
    if(btn.tag == 1)
    {
        self.selected_FromDate = selectedDate;
        NSDateFormatter* df = [[NSDateFormatter alloc]init];
        [df setDateFormat:@"dd-MM-yyyy"];
        NSString *result = [df stringFromDate:self.selected_FromDate];
        
        self.txtFromDate.text = result;
    }
    else
    {
        self.selected_ToDate = selectedDate;
        NSDateFormatter* df = [[NSDateFormatter alloc]init];
        [df setDateFormat:@"dd-MM-yyyy"];
        NSString *result = [df stringFromDate:self.selected_ToDate];
        
        self.txtToDate.text = result;
    }
}

#pragma mrk - UIButton Action

- (IBAction)btnFromDate:(id)sender {
    [self.view endEditing:YES];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *minimumDateComponents = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    [minimumDateComponents setYear:2015];
    
    _actionSheetPicker = [[ActionSheetDatePicker alloc] initWithTitle:@"" datePickerMode:UIDatePickerModeDate selectedDate:self.selected_FromDate
                                                               target:self action:@selector(dateWasSelected:element:) origin:sender];
    self.actionSheetPicker.hideCancel = YES;
    [self.actionSheetPicker showActionSheetPicker];
}

- (IBAction)btnToDate:(id)sender {
    [self.view endEditing:YES];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *minimumDateComponents = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    [minimumDateComponents setYear:2015];
    
    _actionSheetPicker = [[ActionSheetDatePicker alloc] initWithTitle:@"" datePickerMode:UIDatePickerModeDate selectedDate:self.selected_ToDate
                                                               target:self action:@selector(dateWasSelected:element:) origin:sender];
    self.actionSheetPicker.hideCancel = YES;
    [self.actionSheetPicker showActionSheetPicker];
}

- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
