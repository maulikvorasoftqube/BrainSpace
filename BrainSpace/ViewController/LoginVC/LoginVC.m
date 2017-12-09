//
//  LoginVC.m
//  BrainSpace
//
//  Created by harikrishna patel on 08/12/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()
{
    NSString *is_selected;
}
@end

@implementation LoginVC

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
    self.btnLogin.layer.cornerRadius=4;
    self.btnLogin.clipsToBounds=YES;
    
    self.btnFBLogin.layer.cornerRadius=4;
    self.btnFBLogin.clipsToBounds=YES;
    
    self.btnGoogleLogin.layer.cornerRadius=4;
    self.btnGoogleLogin.clipsToBounds=YES;
    
    [Utility setLeftViewInTextField:self.txtEmail imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:self.txtPassword imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    
}

#pragma mark - apiCall Method

-(void)apiCall_login
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        [WToast showWithText:Internet_Connection_Not duration:kWTShort];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@",URL_MAIN,login];
    
    NSMutableDictionary *dicParams=[[NSMutableDictionary alloc]init];
    [dicParams setValue:[NSString stringWithFormat:@"%@",self.txtEmail.text] forKey:@"email"];
    [dicParams setValue:[NSString stringWithFormat:@"%@",self.txtPassword.text] forKey:@"password"];
    [dicParams setValue:@"0" forKey:@"is_social"];
    [dicParams setValue:@"1" forKey:@"is_agree"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Utility PostApiCall:strURL params:dicParams block:^(NSMutableDictionary *dicResponce, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if(!error)
        {
            NSString *status=[dicResponce objectForKey:@"status"];
            if([status integerValue] == 1)
            {
                NSMutableArray *arrusers=[dicResponce objectForKey:@"user"];
                if([arrusers count] != 0)
                {
                    NSString *email=[[arrusers objectAtIndex:0]objectForKey:@"email"];
                    NSString *password=[[arrusers objectAtIndex:0]objectForKey:@"password"];
                    NSString *userid=[[arrusers objectAtIndex:0]objectForKey:@"id"];
                    
                    [[NSUserDefaults standardUserDefaults]setObject:email forKey:@"email"];
                    [[NSUserDefaults standardUserDefaults]setObject:password forKey:@"password"];
                    [[NSUserDefaults standardUserDefaults]setObject:userid forKey:@"userid"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    
                    UIViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
                    [self.navigationController pushViewController:vc animated:YES];
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

#pragma mark - UIButton

- (IBAction)btnAgreement:(id)sender {
    if([is_selected isEqualToString:@"1"])
    {
        [self.btnAgreement setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
        is_selected=@"0";
    }
    else
    {
        [self.btnAgreement setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateNormal];
        is_selected=@"1";
    }
}
- (IBAction)btnLogin:(id)sender {
    if([Utility validateBlankField:self.txtEmail.text])
    {
        [WToast showWithText:@"Please enter email!"];
        return;
    }
    
    if(![Utility validateEmailWithString:self.txtEmail.text])
    {
        [WToast showWithText:@"Please enter valied email!"];
        return;
    }
    
    if([Utility validateBlankField:self.txtPassword.text])
    {
        [WToast showWithText:@"Please enter password!"];
        return;
    }
    
    if (![is_selected isEqualToString:@"1"]) {
        [WToast showWithText:@"Please select agreement to sharing information to application!"];
        return;
    }
    
    [self apiCall_login];
    
    
}
- (IBAction)btnFBLogin:(id)sender {
}
- (IBAction)btnGoogleLogin:(id)sender {
}
@end
