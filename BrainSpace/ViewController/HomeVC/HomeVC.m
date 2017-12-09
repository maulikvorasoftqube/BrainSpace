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
    NSString *is_selectTherapyType;
    
    NSMutableArray *arrPrevious_DisplyeTherapyList;
}
@end

@implementation HomeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self commonData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)commonData
{
    self.tblTherapyList.separatorStyle=UITableViewCellSeparatorStyleNone;
    arrPrevious_DisplyeTherapyList =[[NSMutableArray alloc]init];
    self.btnBack.hidden=YES;
    
    [self apiCall_therapylist:@"" parent_id:@"" is_more:@"0"];
}

-(void)viewWillAppear:(BOOL)animated
{
        if ([arrPrevious_DisplyeTherapyList count] != 0)
        {
            arrTherayList=[[arrPrevious_DisplyeTherapyList lastObject]mutableCopy];
            [arrPrevious_DisplyeTherapyList removeLastObject];
            if ([arrPrevious_DisplyeTherapyList count] == 0)
            {
                self.btnHome.hidden=NO;
                self.btnBack.hidden=YES;
            }
        }
        [self.tblTherapyList reloadData];
}

#pragma mark - apiCall Method

-(void)apiCall_therapylist:(NSString*)therapy_id parent_id:(NSString*)parent_id is_more:(NSString *)is_more
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        [WToast showWithText:Internet_Connection_Not duration:kWTShort];
        return;
    }

    NSString *strURL=[NSString stringWithFormat:@"%@%@",URL_MAIN,therapylist];
    
    NSMutableDictionary *dicParams=[[NSMutableDictionary alloc]init];
    
    [dicParams setValue:parent_id forKey:@"parent_id"];
    [dicParams setValue:therapy_id forKey:@"therapy_id"];
    //[dicParams setValue:is_more forKey:@"is_more"];
    
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
                    NSString *is_more =[[arrusers objectAtIndex:0]objectForKey:@"is_more"];
                    NSString *type_name =[[arrusers objectAtIndex:0]objectForKey:@"type_name"];
                    if([is_more integerValue] == 1|| [type_name isEqualToString:@"Therapy"])
                    {
                        arrTherayList =[[NSMutableArray alloc]init];
                        arrTherayList =[arrusers mutableCopy];
                        [self.tblTherapyList reloadData];
                        
                        }
                    else
                    {
                        
                        TherapyDetailVC *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"TherapyDetailVC"];
                        vc.arrSelectedTherapy=[arrusers mutableCopy];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
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
    lbl.text=@"";
    lbl.text = [NSString stringWithFormat:@"%@",[[arrTherayList objectAtIndex:indexPath.row]objectForKey:@"treatment_name"]];
    
    UIImageView *img=(UIImageView *)[cell.contentView viewWithTag:3];
    [img setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[arrTherayList objectAtIndex:indexPath.row]objectForKey:@"image_name"]]] placeholderImage:[UIImage imageNamed:@"output-0"]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *therapy_id=[[arrTherayList objectAtIndex:indexPath.row]objectForKey:@"id"];
    
    NSString *is_more =[[arrTherayList objectAtIndex:indexPath.row]objectForKey:@"is_more"];
    NSString *type_name =[[arrTherayList objectAtIndex:indexPath.row]objectForKey:@"type_name"];
    if([is_more integerValue] == 1|| [type_name isEqualToString:@"Therapy"])
    {
        if(![arrPrevious_DisplyeTherapyList containsObject:arrTherayList])
        {
            [arrPrevious_DisplyeTherapyList addObject:arrTherayList];
        }
        
        if ([arrPrevious_DisplyeTherapyList count] != 0)
        {
            self.btnBack.hidden=NO;
            self.btnHome.hidden=YES;
        }
        else
        {
            self.btnBack.hidden=YES;
            self.btnHome.hidden=NO;
        }

        [self apiCall_therapylist:@"" parent_id:therapy_id is_more:is_more];
    }
    else
    {
//        if(![arrPrevious_DisplyeTherapyList containsObject:arrTherayList])
//        {
//            [arrPrevious_DisplyeTherapyList addObject:arrTherayList];
//        }
        [self apiCall_therapylist:therapy_id parent_id:@"" is_more:is_more];
        
    }
    
}

#pragma mark -UIButton Action

- (IBAction)btnHome:(id)sender {
    [self.view endEditing:YES];
    
    KYDrawerController *elDrawer = (KYDrawerController*)self.navigationController.parentViewController;
    [elDrawer setDrawerState:KYDrawerControllerDrawerStateOpened animated:YES];
}
- (IBAction)btnBack:(id)sender {
    if ([arrPrevious_DisplyeTherapyList count] != 0)
    {
        arrTherayList=[[arrPrevious_DisplyeTherapyList lastObject]mutableCopy];
        [arrPrevious_DisplyeTherapyList removeLastObject];
        if ([arrPrevious_DisplyeTherapyList count] == 0)
        {
            self.btnHome.hidden=NO;
            self.btnBack.hidden=YES;
        }
        [self.tblTherapyList reloadData];
    }
    else
    {
        self.btnHome.hidden=NO;
        self.btnBack.hidden=YES;
    }

    
}
@end
