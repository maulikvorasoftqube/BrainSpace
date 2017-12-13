//
//  RatedTherapyVC.m
//  BrainSpace
//
//  Created by harikrishna patel on 11/12/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "RatedTherapyVC.h"

@interface RatedTherapyVC ()
{
    NSMutableArray *arrRatedTherapyList;
}
@end

@implementation RatedTherapyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tblRatedTherapList.separatorStyle=UITableViewCellSeparatorStyleNone;
     self.tblRatedTherapList.estimatedRowHeight=101;
    
    
    [self apiCall_getallratings];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - apiCall

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
    [dicParams setValue:@"" forKey:@"therapy_id"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Utility PostApiCall:strURL params:dicParams block:^(NSMutableDictionary *dicResponce, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if(!error)
        {
            NSString *status=[dicResponce objectForKey:@"status"];
            if([status integerValue] == 1)
            {
                arrRatedTherapyList=[[NSMutableArray alloc]init];
                arrRatedTherapyList=[dicResponce objectForKey:@"specialist"];
                [self.tblRatedTherapList reloadData];
                if([arrRatedTherapyList count] != 0)
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


#pragma mark - UITableView Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrRatedTherapyList.count;
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
    
    UILabel *lbl=(UILabel*)[cell.contentView viewWithTag:1];
    lbl.text=@"";
    lbl.text = [NSString stringWithFormat:@"%@",[[arrRatedTherapyList objectAtIndex:indexPath.row]objectForKey:@"treatment_name"]];
    
    UILabel *lblName=(UILabel*)[cell.contentView viewWithTag:2];
    lblName.text=@"";
    lblName.text = [NSString stringWithFormat:@"%@",[[arrRatedTherapyList objectAtIndex:indexPath.row]objectForKey:@"feedback"]];
    
    
    NSString *strRate=[NSString stringWithFormat:@"%@",[[arrRatedTherapyList objectAtIndex:indexPath.row]objectForKey:@"rate"]];
    
    UIButton *btnRate=(UIButton*)[cell.contentView viewWithTag:101];
    UIButton *btnRate2=(UIButton*)[cell.contentView viewWithTag:102];
    UIButton *btnRate3=(UIButton*)[cell.contentView viewWithTag:103];
    UIButton *btnRate4=(UIButton*)[cell.contentView viewWithTag:104];
    UIButton *btnRate5=(UIButton*)[cell.contentView viewWithTag:105];
    
    if([[NSString stringWithFormat:@"%@",strRate] isEqualToString:@"1"])
    {
        [btnRate setImage:[UIImage imageNamed:@"star_fill"] forState:UIControlStateNormal];
        [btnRate2 setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
        [btnRate3 setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
        [btnRate4 setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
        [btnRate5 setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    }
    else if([[NSString stringWithFormat:@"%@",strRate] isEqualToString:@"2"])
    {
        [btnRate setImage:[UIImage imageNamed:@"star_fill"] forState:UIControlStateNormal];
        [btnRate2 setImage:[UIImage imageNamed:@"star_fill"] forState:UIControlStateNormal];
        [btnRate3 setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
        [btnRate4 setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
        [btnRate5 setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    }
    else if([[NSString stringWithFormat:@"%@",strRate] isEqualToString:@"3"])
    {
        [btnRate setImage:[UIImage imageNamed:@"star_fill"] forState:UIControlStateNormal];
        [btnRate2 setImage:[UIImage imageNamed:@"star_fill"] forState:UIControlStateNormal];
        [btnRate3 setImage:[UIImage imageNamed:@"star_fill"] forState:UIControlStateNormal];
        [btnRate4 setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
        [btnRate5 setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    }
    else if([[NSString stringWithFormat:@"%@",strRate] isEqualToString:@"4"])
    {
        [btnRate setImage:[UIImage imageNamed:@"star_fill"] forState:UIControlStateNormal];
        [btnRate2 setImage:[UIImage imageNamed:@"star_fill"] forState:UIControlStateNormal];
        [btnRate3 setImage:[UIImage imageNamed:@"star_fill"] forState:UIControlStateNormal];
        [btnRate4 setImage:[UIImage imageNamed:@"star_fill"] forState:UIControlStateNormal];
        [btnRate5 setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    }
    else if([[NSString stringWithFormat:@"%@",strRate] isEqualToString:@"5"])
    {
        [btnRate setImage:[UIImage imageNamed:@"star_fill"] forState:UIControlStateNormal];
        [btnRate2 setImage:[UIImage imageNamed:@"star_fill"] forState:UIControlStateNormal];
        [btnRate3 setImage:[UIImage imageNamed:@"star_fill"] forState:UIControlStateNormal];
        [btnRate4 setImage:[UIImage imageNamed:@"star_fill"] forState:UIControlStateNormal];
        [btnRate5 setImage:[UIImage imageNamed:@"star_fill"] forState:UIControlStateNormal];
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UIButton Action

- (IBAction)btnMenu:(id)sender {
    [self.view endEditing:YES];
    
    KYDrawerController *elDrawer = (KYDrawerController*)self.navigationController.parentViewController;
    [elDrawer setDrawerState:KYDrawerControllerDrawerStateOpened animated:YES];

}
@end
