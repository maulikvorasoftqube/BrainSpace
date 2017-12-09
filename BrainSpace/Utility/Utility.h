//
//  Utility.h

//
//  Created by Sanjay on 23/07/15.
//  Copyright (c) 2015 Sanjay. All rights reserved.
//


#import "Globle.h"

#import <MediaPlayer/MediaPlayer.h>

@import UIKit;
@interface Utility : NSObject

//get color form string
+ (UIColor *) colorFromHexString:(NSString *)hexString;

//set font


//set View Design
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor *)color;


+(void)setLeftViewInTextField:(UITextField *)temptxt imageName:(NSString *)imageName leftSpace:(float)leftSpace topSpace:(float)topSpace height:(float)height width:(float)width;
+(void)setLeftViewInTextField:(UITextField *)temptxt imageName:(NSString *)imageName leftSpace:(float)leftSpace topSpace:(float)topSpace size:(float)size;
+(void)setLeftViewInTextField:(UITextField *)temptxt imageName:(NSString *)imageName leftSpace:(float)leftSpace topSpace:(float)topSpace;
+(void)setLeftViewInTextField:(UITextField *)temptxt imageName:(NSString *)imageName;

+(void)setTextFieldLeftRightBottom_lightGrayColor_Border:(UITextField*)tetField;
+(void)setTextFieldLeftRightBottom_lightGrayColor_Border:(UITextField*)tetField x:(float)x;


+(void)setLetfAndRightViewOfTextField:(UITextField *)txtField leftImageName:(NSString *)leftImageName rightImageName:(NSString *)rightImageName;
+(void)setLetfViewOfTextField:(UITextField *)txtField leftImageName:(NSString *)leftImageName;
+(void)setRightViewOfTextField:(UITextField *)txtField rightImageName:(NSString *)rightImageName;
//+(void)setLeftRightBottomLine:(UITextField *)txtField

+(void)settxtBorderWithColor:(UITextField *)txtName borderWidth:(float)borderwidth borderColor:(UIColor *)borderColor cornerRadius:(float)cornerRadius;
+(void)settxtBorderWithColor:(UITextField *)txtName borderWidth:(float)borderwidth borderColor:(UIColor *)borderColor cornerRadius:(float)cornerRadius imageName:(NSString *)imge;


//validation method
+(BOOL)validateEmailWithString:(NSString*)email;
+(BOOL)validateAlphaNumericString:(NSString *)string;
+(BOOL)validateBlankField:(NSString *)string;
+(BOOL)validatePhoneLength:(NSString *)string;
+(BOOL)validateNumberString:(NSString *)string;
+(BOOL)validatePassword:(NSString *)string  NewPassword:(NSString *)strNewPassword;
///+(BOOL)validateURL: (NSString *) strURL;
+(BOOL)validatePassword:(NSString *)string;
+(BOOL)validatePassword:(NSString *)string  validateRetypePassword:(NSString *)strRetypePassword;
+(BOOL)validatePassword1:(NSString *)string;

+(BOOL)validateTermsAndCondition:(UIButton *)button;
+(BOOL)validateTextfieldLength:(NSString*)string;
+(NSString *) randomStringWithLength: (int) len;
+ (NSString *)getDateStringForDate_status:(NSString *)timeStamp;

//changeDateFormate
+(NSString*)ChangeDateformate:(NSString *)strDate oldDateFtm:(NSString *)strOldDateFtm newDateFtm:(NSString *)strNewDateFtm;
+ (NSString *)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;


+(NSString *) stringByStrippingHTML:(NSString *)strString;

+ (NSString *)getSizeOfFile:(NSString *)filePath;
+(NSString *) getTimeStamp;

// For SliderView
+ (void)SetViewControllerName:(NSString *)viewcontrollerName;

+(BOOL)isInterNetConnectionIsActive;

+(NSString *)imageToNSString:(UIImage *)image;

+ (NSString *)getMilisecondToTime:(NSString *)timeStamp;

+(NSString *)convertMiliSecondtoDate:(NSString *)dateFormate date:(NSString *)strDate;

+(NSString *)convertDatetoSpecificDate:(NSString *)dateFormate date:(NSString *)strDate;

+(NSString *)convertDateFtrToDtaeFtr:(NSString *)dateFormate newDateFtr:(NSString *)newDateFtr date:(NSString *)strDate;

+(void)SearchTextView1: (UIView *)viewSearch;


#pragma mark - Api Function

+(void)PostApiCall:(NSString *)apiUrl params:(NSMutableDictionary *)param block:(void (^)(NSMutableDictionary *,NSError *))block;
+(void)PostApiCall_AfterTenSec:(NSString *)apiUrl params:(NSMutableDictionary *)param block:(void (^)(NSMutableDictionary *,NSError *))block;

#pragma mark - convert json

+(NSString *)Convertjsontostring:(NSMutableDictionary *)dictonary;
+(NSMutableDictionary *)ConvertStringtoJSON:(NSString *)jsonStr;

+(NSMutableArray *)getLocalDetail : (NSArray *)jsonstr columnKey:(NSString *)columnKey;
+(NSString *)randomImageGenerator;
+(void)SearchTextView: (UIView *)viewSearch;

/*+(void)POSTapiCall:(NSString *)apiName parms:(NSMutableDictionary *)parms block:(void (^)(NSMutableDictionary *,NSError *))block;
//+(void)APIPhoto:(NSString *)apiName parms:(NSMutableDictionary*)parms block:(void (^)(NSDictionary *, NSError *))block;
+(void)APIWithImage:(NSString *)apiName parms:(NSMutableDictionary*)parms block:(void (^)(NSDictionary *, NSError *))block;
+(void)APIWithPicImage:(NSString *)apiName parms:(NSMutableDictionary*)parms block:(void (^)(NSDictionary *, NSError *))block;
 
//+(void)POSTapiCall_New:(NSString *)apiName parms:(NSMutableDictionary *)parms block:(void (^)(NSMutableDictionary *,NSError *))block;
 
+(void)GETapiCall_New:(NSString *)apiName block:(void (^)(NSMutableDictionary *,NSError *))block;
+(void)apiCallForUploadResume:(NSString *)apiName fileData:(NSData *)fileData parms:(NSMutableDictionary *)parms block:(void (^)(NSMutableDictionary *,NSError *))block;

+(void)apicallforuploadimage:(NSString *)apiName image:(UIImage *)selectedimage parms:(NSMutableDictionary *)parms block:(void (^)(NSMutableDictionary *,NSError *))block;

+(void)apiCallForUploadCoverletter:(NSString *)apiName fileData:(NSData *)fileData parms:(NSMutableDictionary *)parms block:(void (^)(NSMutableDictionary *,NSError *))block;

+(void)downloadresume:(NSString *)apiName fileData:(NSData *)fileData block:(void (^)(NSMutableDictionary *,NSError *))block; */

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize isAspectRation:(BOOL)aspect;

+ (NSString *)getMilisecondToTime_HomeScreen:(NSString *)timeStamp;
+ (void)removeUserDefaults1;

+ (NSString *)documentsPathForFileName:(NSString *)name;


@end
