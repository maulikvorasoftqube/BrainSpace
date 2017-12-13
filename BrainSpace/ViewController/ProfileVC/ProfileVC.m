//
//  ProfileVC.m
//  BrainSpace
//
//  Created by harikrishna patel on 11/12/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ProfileVC.h"

@interface ProfileVC ()
{
    NSString *strSelectImage,*strUpload_ImgName;
    NSMutableArray *arrGender,*arrMaritalStatus;
}
@end

@implementation ProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)commonData
{
    self.selected_DOBDate = [NSDate date];
    strSelectImage=@"0";
    strUpload_ImgName=@"";
    self.btnUploadProfile.layer.cornerRadius=50;
    self.btnUploadProfile.clipsToBounds=YES;
    
    [Utility setRightViewOfTextField:self.txtGender rightImageName:@"down_arrow"];
    [Utility setRightViewOfTextField:self.txtMaritalStatus rightImageName:@"down_arrow"];
    [Utility setRightViewOfTextField:self.txtBOD rightImageName:@"down_arrow"];
    
    [Utility setLeftViewInTextField:self.txtName imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:self.txtBOD imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:self.txtGender imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:self.txtMaritalStatus imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:self.txtContactNo imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:self.txtEmergencyContact imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:self.txtEmergencyName imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:self.txtDiagnosis imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:self.txtReasonfortx imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:self.txtMedications imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:self.txtDoctors imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    [self apiCall_userinfo];
}

#pragma mark - apiCall

-(void)apiCall_imageupload
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        [WToast showWithText:Internet_Connection_Not duration:kWTShort];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@",URL_MAIN,imageupload];

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSData *imgData=[[NSData alloc]init];
    if ([strSelectImage isEqualToString:@"1"]) {
        imgData= UIImagePNGRepresentation(self.btnUploadProfile.currentImage);
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:strURL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imgData name:@"file" fileName:@"asas.png" mimeType:@".png"];
    } progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Response: %@", responseObject);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSMutableDictionary *dicData=[responseObject mutableCopy];
        strUpload_ImgName=[[dicData objectForKey:@"image"]objectForKey:@"image_name"];
        [self apiCall_updatepatientuser];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        [WToast showWithText:@"Please try again!"];
    }];
}

-(void)apiCall_updatepatientuser
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        [WToast showWithText:Internet_Connection_Not duration:kWTShort];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@",URL_MAIN,updatepatientuser];
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:self.txtName.text forKey:@"name"];
    [dic setObject:strUpload_ImgName forKey:@"image_name"];
    [dic setObject:self.txtBOD.text forKey:@"dob"];
    [dic setObject:self.txtGender.text forKey:@"gender"];
    [dic setObject:self.txtMaritalStatus.text forKey:@"marital_status"];
    [dic setObject:self.txtAdress.text forKey:@"address"];
    [dic setObject:self.txtContactNo.text forKey:@"contact"];
    [dic setObject:self.txtEmergencyContact.text forKey:@"emergency_contact"];
    [dic setObject:self.txtEmergencyName.text forKey:@"emergency_name"];
    [dic setObject:self.txtDiagnosis.text forKey:@"diagnosis"];
    [dic setObject:self.txtReasonfortx.text forKey:@"reason_for_tx"];
    [dic setObject:self.txtMedications.text forKey:@"medications"];
    [dic setObject:self.txtDoctors.text forKey:@"doctors"];
    
    NSString *strJson=[Utility Convertjsontostring:dic];
    NSString *userid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    NSMutableDictionary *dicParams=[[NSMutableDictionary alloc]init];
    [dicParams setValue:userid forKey:@"user_id"];
    [dicParams setValue:strJson forKey:@"str"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Utility PostApiCall:strURL params:dicParams block:^(NSMutableDictionary *dicResponce, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if(!error)
        {
            NSString *status=[dicResponce objectForKey:@"status"];
            if([status integerValue] == 1)
            {
                [WToast showWithText:[dicResponce objectForKey:@"message"]];
                
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


-(void)apiCall_userinfo
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        [WToast showWithText:Internet_Connection_Not duration:kWTShort];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@",URL_MAIN,userinfo];
    
    NSString *userid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    NSMutableDictionary *dicParams=[[NSMutableDictionary alloc]init];
    [dicParams setValue:userid forKey:@"user_id"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Utility PostApiCall:strURL params:dicParams block:^(NSMutableDictionary *dicResponce, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if(!error)
        {
            NSString *status=[dicResponce objectForKey:@"status"];
            if([status integerValue] == 1)
            {
                NSMutableDictionary *dicuser_info=[dicResponce objectForKey:@"user_info"];
                
                NSString *DocumentName=[dicuser_info objectForKey:@"image_name"];
                
                [[NSUserDefaults standardUserDefaults]setObject:DocumentName forKey:@"user_image"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                if(DocumentName.length != 0)
                {
                    UIImageView *imgDoc=[[UIImageView alloc]init];
                    [MBProgressHUD showHUDAddedTo:self.btnUploadProfile animated:YES];
                    [imgDoc setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",DocumentName]]] placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                        [MBProgressHUD hideHUDForView:self.btnUploadProfile animated:YES];
                        [self.btnUploadProfile setImage:image forState:UIControlStateNormal];
                    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                    }];
                }
                
                //=====name
                NSString *name=[dicuser_info objectForKey:@"name"];
                if (name.length != 0) {
                    self.txtName.text=name;
                }
                
                //=====dob
                NSString *dob=[dicuser_info objectForKey:@"dob"];
                if (dob.length != 0 && ![dob isEqualToString:@"0000-00-00"]) {
                    
                    NSDateFormatter* df = [[NSDateFormatter alloc]init];
                    [df setDateFormat:@"yyyy-MM-dd"];
                    NSDate *result = [df dateFromString:dob];
                    
                    NSDateFormatter* df1 = [[NSDateFormatter alloc]init];
                    [df1 setDateFormat:@"yyyy-MM-dd"];
                    NSString *newdob = [df1 stringFromDate:result];

                    
                    self.txtBOD.text=newdob;
                }
                
                //=====gender
                NSString *gender=[dicuser_info objectForKey:@"gender"];
                if (gender.length != 0) {
                    self.txtGender.text=gender;
                }
                
                //=====marital_status
                NSString *marital_status=[dicuser_info objectForKey:@"marital_status"];
                if (marital_status.length != 0) {
                    self.txtMaritalStatus.text=marital_status;
                }
                
                //=====contact
                NSString *contact=[dicuser_info objectForKey:@"contact"];
                if (contact.length != 0) {
                    self.txtContactNo.text=contact;
                }
                
                //=====emergency_contact
                NSString *emergency_contact=[dicuser_info objectForKey:@"emergency_contact"];
                if (emergency_contact.length != 0) {
                    self.txtEmergencyContact.text=emergency_contact;
                }
                
                //=====emergency_name
                NSString *emergency_name=[dicuser_info objectForKey:@"emergency_name"];
                if (emergency_name.length != 0) {
                    self.txtEmergencyName.text=emergency_name;
                }
                
                //=====diagnosis
                NSString *diagnosis=[dicuser_info objectForKey:@"diagnosis"];
                if (diagnosis.length != 0) {
                    self.txtDiagnosis.text=diagnosis;
                }
                
                //=====reason_for_tx
                NSString *reason_for_tx=[dicuser_info objectForKey:@"reason_for_tx"];
                if (reason_for_tx.length != 0) {
                    self.txtReasonfortx.text=reason_for_tx;
                }
                
                //=====medications
                NSString *medications=[dicuser_info objectForKey:@"medications"];
                if (medications.length != 0) {
                    self.txtMedications.text=medications;
                }
                
                //=====doctors
                NSString *doctors=[dicuser_info objectForKey:@"doctors"];
                if (doctors.length != 0) {
                    self.txtDoctors.text=doctors;
                    
                }
                
                //=====gender
                NSString *address=[dicuser_info objectForKey:@"address"];
                if (address.length != 0) {
                    self.txtAdress.text=address;
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


#pragma mark - actionSheet delegate

- (void)dateWasSelected:(NSDate *)selectedDate element:(id)element
{
    self.selected_DOBDate = selectedDate;
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString *result = [df stringFromDate:self.selected_DOBDate];
    
    self.txtBOD.text = result;
}

#pragma mark - NIDropDown Delegate

- (void) niDropDownDelegateMethod: (NIDropDown *) sender title:(NSString *)strTitle tag:(long)btntag rowIndex:(long)rowIndex
{
    if (btntag == 1) {
        self.txtGender.text=strTitle;
    }else{
    self.txtMaritalStatus.text=strTitle;
    }
    
    [self rel];
}

-(void)rel{
    dropDown = nil;
}

#pragma mark - UIImagePicker Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    strSelectImage=@"1";
    UIImage *selectImage;
    if(picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary)
    {
        selectImage= info[UIImagePickerControllerEditedImage];
    }
    else
    {
        selectImage= info[UIImagePickerControllerOriginalImage];
    }
    
    [self.btnUploadProfile setImage:selectImage forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    strSelectImage=@"0";
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark- UIButton action

- (IBAction)btnUploadProfile:(id)sender
{
    [self.view endEditing:YES];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Attach image" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* pickFromGallery = [UIAlertAction actionWithTitle:@"Take a photo"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * action) {
                                                                if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                                                                {
                                                                    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
                                                                    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                                                    picker.delegate = (id)self;
                                                                    [self presentViewController:picker animated:YES completion:NULL];
                                                                }
                                                                
                                                            }];
    UIAlertAction* takeAPicture = [UIAlertAction actionWithTitle:@"Choose from gallery"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             UIImagePickerController* picker = [[UIImagePickerController alloc] init];
                                                             picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                                             picker.delegate = (id)self;
                                                             picker.allowsEditing=YES;
                                                             [self presentViewController:picker animated:YES completion:NULL];
                                                         }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * action) {
                                                   }];
    
    [alertController addAction:pickFromGallery];
    [alertController addAction:takeAPicture];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (IBAction)btnBOD:(id)sender
{
    [self.view endEditing:YES];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *minimumDateComponents = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    [minimumDateComponents setYear:2015];
    
    _actionSheetPicker = [[ActionSheetDatePicker alloc] initWithTitle:@"" datePickerMode:UIDatePickerModeDate selectedDate:self.selected_DOBDate
                                                               target:self action:@selector(dateWasSelected:element:) origin:sender];
    self.actionSheetPicker.hideCancel = YES;
    [self.actionSheetPicker showActionSheetPicker];
}

- (IBAction)btnGender:(id)sender {
    [self.view endEditing:YES];
    NSArray * arrimg = [[NSArray alloc] init];
    arrGender=[NSMutableArray arrayWithObjects:@"Male",@"Female",@"Other", nil];
    if(dropDown == nil) {
        CGFloat f = 100;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arrGender :arrimg :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}

- (IBAction)btnMaritalStatus:(id)sender {
    [self.view endEditing:YES];
    NSArray * arrimg = [[NSArray alloc] init];
     arrMaritalStatus=[NSMutableArray arrayWithObjects:@"Married",@"Unmarried",@"Single",@"Widow",@"Seperated", nil];
    if(dropDown == nil) {
        CGFloat f = 150;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arrMaritalStatus :arrimg :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}

- (IBAction)btnSubmit:(id)sender {
    if([strSelectImage isEqualToString:@"1"])
    {
        [self apiCall_imageupload];
    }
    else
    {
        [self apiCall_updatepatientuser];
    }
}

- (IBAction)btnMenu:(id)sender {
    [self.view endEditing:YES];
    
    KYDrawerController *elDrawer = (KYDrawerController*)self.navigationController.parentViewController;
    [elDrawer setDrawerState:KYDrawerControllerDrawerStateOpened animated:YES];
}
@end
