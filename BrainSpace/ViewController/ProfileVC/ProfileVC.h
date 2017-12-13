//
//  ProfileVC.h
//  BrainSpace
//
//  Created by harikrishna patel on 11/12/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globle.h"

@interface ProfileVC : UIViewController<NIDropDownDelegate>
{
    NIDropDown *dropDown;
}
@property (nonatomic, strong) NSDate *selected_DOBDate;

@property (nonatomic, strong) ActionSheetDatePicker *actionSheetPicker;


@property (strong, nonatomic) IBOutlet UIButton *btnUploadProfile;
- (IBAction)btnUploadProfile:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UITextField *txtBOD;
@property (strong, nonatomic) IBOutlet UIButton *btnBOD;
- (IBAction)btnBOD:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *txtGender;
@property (strong, nonatomic) IBOutlet UIButton *btnGender;
- (IBAction)btnGender:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *txtMaritalStatus;
@property (strong, nonatomic) IBOutlet UIButton *btnMaritalStatus;
- (IBAction)btnMaritalStatus:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtContactNo;
@property (strong, nonatomic) IBOutlet UITextField *txtEmergencyContact;
@property (strong, nonatomic) IBOutlet UITextField *txtEmergencyName;
@property (strong, nonatomic) IBOutlet UITextField *txtDiagnosis;
@property (strong, nonatomic) IBOutlet UITextField *txtReasonfortx;
@property (strong, nonatomic) IBOutlet UITextField *txtMedications;
@property (strong, nonatomic) IBOutlet UITextField *txtDoctors;
@property (strong, nonatomic) IBOutlet UITextView *txtAdress;

@property (strong, nonatomic) IBOutlet UIButton *btnSubmit;
- (IBAction)btnSubmit:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnMenu;
- (IBAction)btnMenu:(id)sender;

@end
