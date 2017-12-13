//
//  LoginVC.h
//  BrainSpace
//
//  Created by harikrishna patel on 08/12/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globle.h"
#import <GoogleSignIn/GoogleSignIn.h>
@interface LoginVC : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;

@property (strong, nonatomic) IBOutlet UIButton *btnAgreement;
- (IBAction)btnAgreement:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
- (IBAction)btnLogin:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnFBLogin;
- (IBAction)btnFBLogin:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnGoogleLogin;
- (IBAction)btnGoogleLogin:(id)sender;

@end
