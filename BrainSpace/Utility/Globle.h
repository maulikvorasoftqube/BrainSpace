//
//  Globle.h
//  Gab
//
//  Created by Softqube on 02/06/17.
//  Copyright © 2017 me. All rights reserved.
//

#ifndef Globle_h
#define Globle_h



#import "Utility.h"
#import "Reachability.h"
#import <AFNetworking.h>
#import "WToast.h"
#import <MBProgressHUD.h>
#import <UIImageView+AFNetworking.h>
#import "NIDropDown.h"
#import "GKLineGraph.h"
#import <ActionSheetPicker.h>

//viewcontroller
#import "LoginVC.h"
#import "KYDrawerController.h"
#import "TherapyDetailVC.h"
#import "RatedTherapyVC.h"
#import "MoodTrackerVC.h"


#define URL_MAIN @"http://43.252.197.237/PHP/projects/therapy/api/"

#define login @"login"
#define therapylist @"therapylist"
#define ratetherapy @"ratetherapy"
#define getallratings @"getallratings"
#define savemood @"savemood"
#define getallmoods @"getallmoods"
#define imageupload @"imageupload"
#define updatepatientuser @"updatepatientuser"
#define userinfo @"userinfo"

//validation
#define Internet_Connection_Not @"Please make sure that you have an active Internet connection!"
#define Please_try_again @"Please try again...!!"


#endif
