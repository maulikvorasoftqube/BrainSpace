//
//  TherapyDetailVC.m
//  BrainSpace
//
//  Created by harikrishna patel on 09/12/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "TherapyDetailVC.h"

@interface TherapyDetailVC ()
{
    NSString *strSelectRatingValue;
    NSMutableArray *arrTherapyDetailList;
    
    long currentIndex,totalIndex;
}
@end

@implementation TherapyDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)commonData
{
    strSelectRatingValue=@"1";
    self.viewRating_Inner.layer.cornerRadius=4;
    self.viewRating_Inner.clipsToBounds=YES;
    self.tblTherapyDetailList.estimatedRowHeight=200;
    
    [self.viewRating setHidden:YES];
    
    currentIndex=0;
    totalIndex=[self.arrSelectedTherapy count]-1;
    if([self.arrSelectedTherapy count] != 0)
    {
        arrTherapyDetailList=[[NSMutableArray alloc]init];
        [arrTherapyDetailList addObject:[self.arrSelectedTherapy objectAtIndex:0]];
        [self.tblTherapyDetailList reloadData];
    }
    
    [self apiCall_getallratings];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeImage:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [_tblTherapyDetailList addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeImage:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [_tblTherapyDetailList addGestureRecognizer:swipeRight];
}

-(void)swipeImage:(UISwipeGestureRecognizer*)recognizer
{
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        if (currentIndex < totalIndex)
        {
            currentIndex++;
            if(currentIndex < [self.arrSelectedTherapy count])
            {
                arrTherapyDetailList=[[NSMutableArray alloc]init];
                [arrTherapyDetailList addObject:[self.arrSelectedTherapy objectAtIndex:currentIndex]];
                [self.tblTherapyDetailList reloadData];
            }
        }
        else
        {
            [WToast showWithText:@"Data not found!"];
        }
    }
    else if (recognizer.direction == UISwipeGestureRecognizerDirectionRight)
    {
        if (currentIndex > 0)
        {
            currentIndex--;
            if(currentIndex < [self.arrSelectedTherapy count])
            {
                arrTherapyDetailList=[[NSMutableArray alloc]init];
                [arrTherapyDetailList addObject:[self.arrSelectedTherapy objectAtIndex:currentIndex]];
                [self.tblTherapyDetailList reloadData];
            }
            
        }
        else
        {
            [WToast showWithText:@"Data not found!"];
        }
    }
}

#pragma mark - apiCall Method

-(void)apiCall_ratetherapy
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        [WToast showWithText:Internet_Connection_Not duration:kWTShort];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@",URL_MAIN,ratetherapy];
    
    NSString *userid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    NSString *therapy_id=@"";
    if(arrTherapyDetailList.count != 0)
    {
        therapy_id=[[arrTherapyDetailList objectAtIndex:0]objectForKey:@"id"];
    }
    NSMutableDictionary *dicParams=[[NSMutableDictionary alloc]init];
    
    [dicParams setValue:userid forKey:@"user_id"];
    [dicParams setValue:strSelectRatingValue forKey:@"rate"];
    [dicParams setValue:therapy_id forKey:@"therapy_id"];
    [dicParams setValue:self.txtView_Feedback.text forKey:@"feedback"];
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Utility PostApiCall:strURL params:dicParams block:^(NSMutableDictionary *dicResponce, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if(!error)
        {
            NSString *status=[dicResponce objectForKey:@"status"];
            if([status integerValue] == 1)
            {
                [self.viewRating setHidden:YES];
                [WToast showWithText:[dicResponce objectForKey:@"message"]];
                NSMutableArray *arrusers=[dicResponce objectForKey:@"therapy"];
                if([arrusers count] != 0)
                {
                }
                else
                {
                    
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

-(void)apiCall_getallratings
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        [WToast showWithText:Internet_Connection_Not duration:kWTShort];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@",URL_MAIN,getallratings];
    
    NSString *userid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    NSMutableDictionary *dicParams=[[NSMutableDictionary alloc]init];
    
    [dicParams setValue:userid forKey:@"user_id"];
    
    NSString *therapy_id=@"";
    if(arrTherapyDetailList.count != 0)
    {
        therapy_id=[[arrTherapyDetailList objectAtIndex:0]objectForKey:@"id"];
    }
    [dicParams setValue:therapy_id forKey:@"therapy_id"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Utility PostApiCall:strURL params:dicParams block:^(NSMutableDictionary *dicResponce, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if(!error)
        {
            NSString *status=[dicResponce objectForKey:@"status"];
            if([status integerValue] == 1)
            {
                NSMutableArray *arrspecialist=[dicResponce objectForKey:@"specialist"];
                if([arrspecialist count] != 0)
                {
                    NSString *feedback=[[arrspecialist objectAtIndex:0]objectForKey:@"feedback"];
                     NSString *rate=[[arrspecialist objectAtIndex:0]objectForKey:@"rate"];
                    if (feedback.length !=0) {
                        [self.txtView_Feedback setText:feedback];
                    }
                    else
                    {
                        [self.txtView_Feedback setText:@""];
                        
                    }
                    [self setRatingValue:[NSString stringWithFormat:@"%@",rate]];
                    
                }
            }
            else
            {
                //[WToast showWithText:[dicResponce objectForKey:@"message"]];
            }
        }
        else
        {
           // [WToast showWithText:Please_try_again];
        }
    }];
}

#pragma mark - UITableView Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrTherapyDetailList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=(UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell_row"];
    
    if(indexPath.row % 2)
    {
        cell.contentView.backgroundColor=[UIColor whiteColor];
    }
    else
    {
        cell.contentView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    }
    
    UILabel *lblName=(UILabel*)[cell.contentView viewWithTag:3];
    lblName.text=@"";
    lblName.text = [NSString stringWithFormat:@"%@",[[arrTherapyDetailList objectAtIndex:indexPath.row]objectForKey:@"treatment_name"]];
    
    UIImageView *img=(UIImageView *)[cell.contentView viewWithTag:1];
    [img setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[arrTherapyDetailList objectAtIndex:indexPath.row]objectForKey:@"image_name"]]] placeholderImage:[UIImage imageNamed:@"output-0"]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UIButton Action

- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnRate_Therapy:(id)sender
{
    [self.viewRating setHidden:NO];
}

- (IBAction)btnClose_Rating:(id)sender
{
    [self.viewRating setHidden:YES];
}

-(void)setRatingValue:(NSString*)strRate
{
    strSelectRatingValue=strRate;
    if([strRate isEqualToString:@"1"])
    {
        [self.btnRate setImage:[UIImage imageNamed:@"star_fill"] forState:UIControlStateNormal];
        [self.btnRate2 setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
        [self.btnRate3 setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
        [self.btnRate4 setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
        [self.btnRate5 setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    }
    else if ([strRate isEqualToString:@"2"])
    {
        [self.btnRate setImage:[UIImage imageNamed:@"star_fill"] forState:UIControlStateNormal];
        [self.btnRate2 setImage:[UIImage imageNamed:@"star_fill"] forState:UIControlStateNormal];
        [self.btnRate3 setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
        [self.btnRate4 setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
        [self.btnRate5 setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    }
    else if ([strRate isEqualToString:@"3"])
    {
        [self.btnRate setImage:[UIImage imageNamed:@"star_fill"] forState:UIControlStateNormal];
        [self.btnRate2 setImage:[UIImage imageNamed:@"star_fill"] forState:UIControlStateNormal];
        [self.btnRate3 setImage:[UIImage imageNamed:@"star_fill"] forState:UIControlStateNormal];
        [self.btnRate4 setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
        [self.btnRate5 setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    }
    else if ([strRate isEqualToString:@"4"])
    {
        [self.btnRate setImage:[UIImage imageNamed:@"star_fill"] forState:UIControlStateNormal];
        [self.btnRate2 setImage:[UIImage imageNamed:@"star_fill"] forState:UIControlStateNormal];
        [self.btnRate3 setImage:[UIImage imageNamed:@"star_fill"] forState:UIControlStateNormal];
        [self.btnRate4 setImage:[UIImage imageNamed:@"star_fill"] forState:UIControlStateNormal];
        [self.btnRate5 setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    }
    else if ([strRate isEqualToString:@"5"])
    {
        [self.btnRate setImage:[UIImage imageNamed:@"star_fill"] forState:UIControlStateNormal];
        [self.btnRate2 setImage:[UIImage imageNamed:@"star_fill"] forState:UIControlStateNormal];
        [self.btnRate3 setImage:[UIImage imageNamed:@"star_fill"] forState:UIControlStateNormal];
        [self.btnRate4 setImage:[UIImage imageNamed:@"star_fill"] forState:UIControlStateNormal];
        [self.btnRate5 setImage:[UIImage imageNamed:@"star_fill"] forState:UIControlStateNormal];
    }
}

#pragma mark - UIBUtton

- (IBAction)btnRate1:(id)sender {
    [self setRatingValue:@"1"];
}
- (IBAction)btnRate2:(id)sender {
    [self setRatingValue:@"2"];
}
- (IBAction)btnRate3:(id)sender {
    [self setRatingValue:@"3"];
}
- (IBAction)btnRate4:(id)sender {
    [self setRatingValue:@"4"];
}
- (IBAction)btnRate5:(id)sender {
    [self setRatingValue:@"5"];
}
- (IBAction)btnSubmit:(id)sender {
    [self.view endEditing:YES];
    [self apiCall_ratetherapy];
}
@end
