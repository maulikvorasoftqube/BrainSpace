//
//  LoginVC.m
//  BrainSpace
//
//  Created by harikrishna patel on 08/12/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "LoginVC.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface LoginVC ()<GIDSignInDelegate,GIDSignInUIDelegate>
{
    NSString *is_selected;
    GIDSignIn *signIn;
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
    
    
    signIn = [GIDSignIn sharedInstance];
    signIn.clientID=@"173454432239-g5gkshrsijtua909k9uhaafnj9odgjii.apps.googleusercontent.com";  // here add your ID
    signIn.scopes = @[ @"profile" ];
    signIn.delegate = (id)self;
    
    [GIDSignIn sharedInstance].uiDelegate = self;

}

#pragma mark - apiCall Method

-(void)apiCall_login:(NSString *)is_social emailid:(NSString*)emailid
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        [WToast showWithText:Internet_Connection_Not duration:kWTShort];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@",URL_MAIN,login];
    
    NSMutableDictionary *dicParams=[[NSMutableDictionary alloc]init];
    if([is_social isEqualToString:@"1"])
    {
        [dicParams setValue:[NSString stringWithFormat:@"%@",emailid] forKey:@"email"];
        [dicParams setValue:[NSString stringWithFormat:@"%@",emailid] forKey:@"password"];
        [dicParams setValue:@"1" forKey:@"is_social"];
    }
    else
    {
        [dicParams setValue:[NSString stringWithFormat:@"%@",self.txtEmail.text] forKey:@"email"];
        [dicParams setValue:[NSString stringWithFormat:@"%@",self.txtPassword.text] forKey:@"password"];
        [dicParams setValue:@"0" forKey:@"is_social"];
    }
    
    [dicParams setValue:@"1" forKey:@"is_agree"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Utility PostApiCall:strURL params:dicParams block:^(NSMutableDictionary *dicResponce, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if(!error)
        {
            NSString *status=[dicResponce objectForKey:@"status"];
            if([status integerValue] == 1)
            {
                NSMutableArray *arrusers=[[dicResponce objectForKey:@"user"]mutableCopy];
                if([arrusers isKindOfClass:[NSMutableDictionary class]])
                {
                    NSMutableDictionary *dicusers=[dicResponce objectForKey:@"user"];
                    NSString *stris_social=[dicusers objectForKey:@"is_social"];
                    if([stris_social integerValue] == 1)
                    {
                        NSString *email=[dicusers objectForKey:@"social_id"];
                        NSString *password=[dicusers objectForKey:@"password"];
                        NSString *userid=[dicusers objectForKey:@"id"];
                        
                        [[NSUserDefaults standardUserDefaults]setObject:email forKey:@"email"];
                        [[NSUserDefaults standardUserDefaults]setObject:password forKey:@"password"];
                        [[NSUserDefaults standardUserDefaults]setObject:userid forKey:@"userid"];
                        [[NSUserDefaults standardUserDefaults]synchronize];
                    }
                    else
                    {
                        NSString *email=[dicusers objectForKey:@"email"];
                        NSString *password=[dicusers objectForKey:@"password"];
                        NSString *userid=[dicusers objectForKey:@"id"];
                        
                        [[NSUserDefaults standardUserDefaults]setObject:email forKey:@"email"];
                        [[NSUserDefaults standardUserDefaults]setObject:password forKey:@"password"];
                        [[NSUserDefaults standardUserDefaults]setObject:userid forKey:@"userid"];
                        [[NSUserDefaults standardUserDefaults]synchronize];
                    }
                    UIViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
                else if([arrusers count] != 0)
                {
                    NSString *stris_social=[[arrusers objectAtIndex:0]objectForKey:@"is_social"];
                    if([stris_social integerValue] == 1)
                    {
                        NSString *email=[[arrusers objectAtIndex:0]objectForKey:@"social_id"];
                        NSString *password=[[arrusers objectAtIndex:0]objectForKey:@"password"];
                        NSString *userid=[[arrusers objectAtIndex:0]objectForKey:@"id"];
                        
                        [[NSUserDefaults standardUserDefaults]setObject:email forKey:@"email"];
                        [[NSUserDefaults standardUserDefaults]setObject:password forKey:@"password"];
                        [[NSUserDefaults standardUserDefaults]setObject:userid forKey:@"userid"];
                        [[NSUserDefaults standardUserDefaults]synchronize];
                    }
                    else
                    {
                        NSString *email=[[arrusers objectAtIndex:0]objectForKey:@"email"];
                        NSString *password=[[arrusers objectAtIndex:0]objectForKey:@"password"];
                        NSString *userid=[[arrusers objectAtIndex:0]objectForKey:@"id"];
                        
                        [[NSUserDefaults standardUserDefaults]setObject:email forKey:@"email"];
                        [[NSUserDefaults standardUserDefaults]setObject:password forKey:@"password"];
                        [[NSUserDefaults standardUserDefaults]setObject:userid forKey:@"userid"];
                        [[NSUserDefaults standardUserDefaults]synchronize];
                    }
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
    
    [self apiCall_login:@"0" emailid:@""];
    
    
}

- (IBAction)btnFBLogin:(id)sender {
    FBSDKLoginManager *loginfb = [[FBSDKLoginManager alloc] init];
    //   [login setLoginBehavior:FBSDKLoginBehaviorWeb];
    [loginfb
     logInWithReadPermissions: @[@"public_profile",@"email"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
     {
         if (error)
         {
             NSLog(@"Process error");
         } else if (result.isCancelled)
         {
             NSLog(@"Cancelled");
         } else
         {
             if ([FBSDKAccessToken currentAccessToken])
             {
                 [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                 NSDictionary *parameters = [NSDictionary dictionaryWithObject:@"id,email,first_name,last_name,name,picture{url}" forKey:@"fields"];
                 
                 [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
                  startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error)
                  {
                      [MBProgressHUD hideHUDForView:self.view animated:YES];
                      if (!error)
                      {
                          NSMutableDictionary *dic=[result mutableCopy];
                          NSString *email=[dic objectForKey:@"id"];
                          if([NSString stringWithFormat:@"%@",email].length != 0)
                          {
                              [self apiCall_login:@"1" emailid:email];
                          }
                          else
                          {
                              [WToast showWithText:@"Please try again!"];
                          }
                      }
                  }];
             }
         }
     }];
}

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {

   /* NSString *userId = user.userID;
    NSString *idToken = user.authentication.idToken;
    NSString *fullName = user.profile.name;
    NSString *givenName = user.profile.givenName;
    NSString *familyName = user.profile.familyName;*/
    NSString *email = user.profile.email;
    if(email.length != 0)
    {
        [self apiCall_login:@"1" emailid:email];
    }
}

- (IBAction)btnGoogleLogin:(id)sender {
   [[GIDSignIn sharedInstance] signIn];
}
@end
