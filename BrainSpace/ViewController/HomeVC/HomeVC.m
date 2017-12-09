//
//  HomeVC.m
//  BrainSpace
//
//  Created by harikrishna patel on 08/12/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "HomeVC.h"

@interface HomeVC ()
{
    NSMutableArray *arrTherayList;
}
@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)commonData
{
    self.tblTherapyList.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [self apiCall_therapylist];
}

#pragma mark - apiCall Method

-(void)apiCall_therapylist
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        [WToast showWithText:Internet_Connection_Not duration:kWTShort];
        return;
    }

    NSString *strURL=[NSString stringWithFormat:@"%@%@",URL_MAIN,therapylist];
    
    NSMutableDictionary *dicParams=[[NSMutableDictionary alloc]init];
    
    [dicParams setValue:@"" forKey:@"parent_id"];
    [dicParams setValue:@"" forKey:@"therapy_id"];
    [dicParams setValue:@"0" forKey:@"is_more"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Utility PostApiCall:strURL params:dicParams block:^(NSMutableDictionary *dicResponce, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if(!error)
        {
            NSString *status=[dicResponce objectForKey:@"status"];
            if([status integerValue] == 1)
            {
                NSMutableArray *arrusers=[dicResponce objectForKey:@"therapy"];
                if([arrusers count] != 0)
                {
                    arrTherayList =[[NSMutableArray alloc]init];
                    arrTherayList =[arrusers mutableCopy];
                    [self.tblTherapyList reloadData];
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


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrTherayList.count;
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
    lbl.text = [NSString stringWithFormat:@"%@",[[arrTherayList objectAtIndex:indexPath.row]objectForKey:@"treatment_name"]];
    
    UIImageView *img=(UIImageView *)[cell.contentView viewWithTag:3];
    [img setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[arrTherayList objectAtIndex:indexPath.row]objectForKey:@"image_name"]]] placeholderImage:[UIImage imageNamed:@"output-0"]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark -UIButton Action

- (IBAction)btnHome:(id)sender {
    [self.view endEditing:YES];
    
    KYDrawerController *elDrawer = (KYDrawerController*)self.navigationController.parentViewController;
    [elDrawer setDrawerState:KYDrawerControllerDrawerStateOpened animated:YES];
}
@end
