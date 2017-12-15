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

    self.graph.dataSource = self;
    self.graph.lineWidth = 3.0;
    self.graph.valueLabelCount = 6;
    
    NSString *FirstDate_CurrentMonth=[self getFirstDate_CurrntMonth];
    
    NSDateFormatter *ft=[[NSDateFormatter alloc]init];
    ft.dateFormat=@"yyyy-MM-dd";
    NSString *currentDate=[ft stringFromDate:[NSDate date]];
    
    [self apiCall_getallmoods:FirstDate_CurrentMonth ToDate:currentDate];
    
}

- (void)_setupExampleGraph {
    
    //self.data = @[
    //              @[@20, @40, @20, @60, @40, @140, @80],
    //              @[@40, @20, @60, @100, @60, @20, @60],
    //              @[@80, @60, @40, @160, @100, @40, @110]
    //              ];
    
   // self.labels = @[@"2001", @"2002", @"2003", @"2004", @"2005", @"2006", @"2007"];
    
    self.graph.dataSource = self;
    self.graph.lineWidth = 3.0;
    
   // self.graph.valueLabelCount = 6;
    
    [self.graph draw];
}

#pragma mark - GKLineGraphDataSource

- (NSInteger)numberOfLines {
    return [self.data count];
}

- (UIColor *)colorForLineAtIndex:(NSInteger)index {
    id colors = @[[UIColor colorWithRed:0/255.0f green:174/255.0f blue:48/255.0f alpha:1.0f],
                  [UIColor colorWithRed:235/255.0f green:230/255.0f blue:70/255.0f alpha:1.0f],
                  [UIColor colorWithRed:226/255.0f green:13/255.0f blue:30/255.0f alpha:1.0f]
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
        [df setDateFormat:@"yyyy-MM-dd"];
        NSString *result = [df stringFromDate:self.selected_FromDate];
        
        self.txtFromDate.text = result;
    }
    else
    {
        self.selected_ToDate = selectedDate;
        NSDateFormatter* df = [[NSDateFormatter alloc]init];
        [df setDateFormat:@"yyyy-MM-dd"];
        NSString *result = [df stringFromDate:self.selected_ToDate];
        
        self.txtToDate.text = result;
    }
       
    [self apiCall_getallmoods:self.txtFromDate.text ToDate:self.txtToDate.text];

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

-(NSString *)getFirstDate_CurrntMonth
{
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:[NSDate date]];
    
    NSDate * firstDateOfMonth = [self returnDateForMonth:comps.month year:comps.year day:1];
    
    NSDateFormatter *ft=[[NSDateFormatter alloc]init];
    ft.dateFormat=@"yyyy-MM-dd";
    NSString *firstdateofcurrentmonth=[ft stringFromDate:firstDateOfMonth];
    
    return firstdateofcurrentmonth;
}
- (NSDate *)returnDateForMonth:(NSInteger)month year:(NSInteger)year day:(NSInteger)day {
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    [components setDay:day];
    [components setMonth:month];
    [components setYear:year];
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [gregorian dateFromComponents:components];
}

#pragma  mark - UIButton Action

-(void)apiCall_getallmoods:(NSString *)FromDate ToDate:(NSString *)ToDate
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        [WToast showWithText:Internet_Connection_Not duration:kWTShort];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@",URL_MAIN,getallmoods];
    
    NSString *userid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    NSMutableDictionary *dicParams=[[NSMutableDictionary alloc]init];
    
   
    
    [dicParams setValue:userid forKey:@"user_id"];
    [dicParams setValue:FromDate forKey:@"from_date"];
    [dicParams setValue:ToDate forKey:@"to_date"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Utility PostApiCall:strURL params:dicParams block:^(NSMutableDictionary *dicResponce, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if(!error)
        {
            NSString *status=[dicResponce objectForKey:@"status"];
            if([status integerValue] == 1)
            {
                NSMutableArray *arrResponceDataata=[dicResponce objectForKey:@"data"];
                if([arrResponceDataata count] != 0)
                {
                    NSMutableArray *arrTemp_date=[[NSMutableArray alloc]init];
                    [arrTemp_date addObject:@"0"];
                    NSMutableArray *arrTemp=[[NSMutableArray alloc]init];
                    NSMutableArray *arrGood_Temp=[[NSMutableArray alloc]init];
                    [arrGood_Temp addObject:@"0"];
                    NSMutableArray *arrSilent_Temp=[[NSMutableArray alloc]init];
                    [arrSilent_Temp addObject:@"0"];
                    NSMutableArray *arrBad_Temp=[[NSMutableArray alloc]init];
                    [arrBad_Temp addObject:@"0"];
                    
                    for (NSMutableDictionary *dic in arrResponceDataata)
                    {
                        NSMutableArray *mood=[[dic objectForKey:@"mood"]mutableCopy];
                        
                        if([mood count] != 0)
                        {
                            [arrGood_Temp addObject:[[mood objectAtIndex:0] objectForKey:@"Good"]];
                            [arrSilent_Temp addObject:[[mood objectAtIndex:0] objectForKey:@"Silent"]];
                            [arrBad_Temp addObject:[[mood objectAtIndex:0] objectForKey:@"Bad"]];
                            
                            NSMutableArray *arrDateMain=[[NSMutableArray alloc]init];
                            NSString *strDate=[[mood objectAtIndex:0] objectForKey:@"created_date"];
                            strDate = [Utility convertDateFtrToDtaeFtr:@"yyyy-MM-dd" newDateFtr:@"dd" date:strDate];
                            [arrDateMain addObject:strDate];
                            
                            [arrTemp_date addObject:strDate];
                        }
                    }
                    [arrTemp addObject:arrGood_Temp];
                    [arrTemp addObject:arrSilent_Temp];
                    [arrTemp addObject:arrBad_Temp];
                    
                    self.data=[arrTemp mutableCopy];
                    self.labels=[arrTemp_date mutableCopy];
                    
                    [self.graph reset];
                    [self.graph draw];
                }
                else
                {
                    [self.graph reset];
                     [WToast showWithText:[dicResponce objectForKey:@"message"]];
                }
                
            }
            else
            {
                [WToast showWithText:[dicResponce objectForKey:@"message"]];
            }
        }
        else
        {
            [WToast showWithText:Please_try_again];
        }
    }];
}
@end
