//
//  Utility.m

//
//  Created by Sanjay on 23/07/15.
//  Copyright (c) 2015 Sanjay. All rights reserved.
//

#import "Utility.h"

@implementation Utility
NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";



//String to color
+ (UIColor *) colorFromHexString:(NSString *)hexString {
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}



#pragma mark - Set Font
//set Labe Fount
/*+(void)setFontOfLable:(UILabel *)tempLable {
 int fontSize = tempLable.font.pointSize;
 tempLable.font = [UIFont fontWithName:AppFontNameRegular size:fontSize];
 }
 
 
 +(void)setFontOfLableBold:(UILabel *)tempLable {
 int fontSize = tempLable.font.pointSize;
 tempLable.font = [UIFont fontWithName:AppFontNameBold size:fontSize];
 }
 
 //set Button Fount
 +(void)setFontOfButton:(UIButton *)tempBtn{
 int fontSize = tempBtn.titleLabel.font.pointSize;
 tempBtn.titleLabel.font = [UIFont fontWithName:AppFontNameRegular size:fontSize];
 }
 
 //set TextField Fount
 +(void)setFontOfTextField:(UITextField *)temptxt{
 int fontSize = temptxt.font.pointSize;
 temptxt.font = [UIFont fontWithName:AppFontNameRegular size:fontSize];
 }*/


+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, (CGRect){.size = size});
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [Utility imageWithColor:color size:CGSizeMake(1, 1)];
}

#pragma mark - Button Design
//set Button Design
//+(void)setRoundButton:(UIButton *)tempBtn{
//
//    [self setFontOfButton:tempBtn];
//    tempBtn.layer.cornerRadius = tempBtn.frame.size.height / 2.0f ;
//    tempBtn.layer.masksToBounds = YES;
//    tempBtn.backgroundColor = [UIColor blackColor];
//
//    tempBtn.titleLabel.textColor = [Utility colorFromHexString:AppButtonTextColor];
//    tempBtn.titleLabel.textColor = [UIColor whiteColor];
//
//    [tempBtn addTarget:self action:@selector(buttonHighlight:) forControlEvents:UIControlEventTouchDown];
//    [tempBtn addTarget:self action:@selector(buttonDragExit:) forControlEvents:UIControlEventTouchDragOutside];

//    [tempBtn setBackgroundImage:[Utility imageWithColor:[UIColor blackColor]] forState:UIControlStateNormal];
////    [tempBtn setBackgroundImage:[Utility imageWithColor:[UIColor blueColor]] forState:UIControlStateHighlighted];
//
////    [tempBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
//    [tempBtn setBackgroundImage:[UIImage imageNamed:@"blue_button"] forState:UIControlStateHighlighted];

//    [tempBtn setBackgroundImage:[UIImage imageNamed:@"black_button"] forState:UIControlStateNormal];
//    UIView *superView = [tempBtn superview];
//    UIView *viewBackOfButton = [[UIView alloc] initWithFrame:tempBtn.frame];
//    viewBackOfButton.backgroundColor = [UIColor blackColor];
//    viewBackOfButton.layer.cornerRadius = tempBtn.frame.size.height / 2.0f ;
//    viewBackOfButton.layer.masksToBounds = YES;
//
//    [superView addSubview:viewBackOfButton];
//
//    [superView bringSubviewToFront:tempBtn];

//}

//+(void)buttonHighlight:(UIButton *)sender{
//    sender.titleLabel.textColor = [UIColor blackColor];
//    sender.backgroundColor = [Utility colorFromHexString:APPColor];
//}
//+(void)buttonDragExit:(UIButton *)sender{
//    sender.titleLabel.textColor = [UIColor whiteColor];
//    sender.backgroundColor = [Utility colorFromHexString:AppButtonBackColor];
//}



#pragma mark - TextField Design
//set Button Design
//+(void)setRoundUITextField:(UITextField *)temptxt{
//
//    [self setFontOfTextField:temptxt];
//    temptxt.layer.cornerRadius = temptxt.frame.size.height / 2.0f ;
//    temptxt.layer.borderColor = [[Utility colorFromHexString:APPTextBoxBorderColorNormal] CGColor];
//    temptxt.layer.borderWidth = 1.0f;
//    temptxt.backgroundColor = [UIColor clearColor];
//    temptxt.textColor = [Utility colorFromHexString:AppButtonTextBoxTextColor];
//}
//
//+(void)setRoundUITextFieldWithoutBorder:(UITextField *)temptxt{
//
//    [self setFontOfTextField:temptxt];
//    temptxt.layer.cornerRadius = temptxt.frame.size.height / 2.0f ;
//    temptxt.backgroundColor = [UIColor clearColor];
//    temptxt.textColor = [Utility colorFromHexString:AppButtonTextBoxTextColor];
//}

+(void)setLeftViewInTextField:(UITextField *)temptxt imageName:(NSString *)imageName leftSpace:(float)leftSpace topSpace:(float)topSpace height:(float)height width:(float)width{
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width , temptxt.frame.size.height)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(leftSpace, topSpace, width, height)];
    imageView.image = [UIImage imageNamed:imageName];
    [leftView addSubview:imageView];
    temptxt.leftView = leftView;
    
    temptxt.leftViewMode = UITextFieldViewModeAlways;
    
    //[self setFontOfTextField:temptxt];
    
    //    temptxt.leftViewMode = UITextFieldViewModeAlways;
    
    //    [temptxt.layer setBorderWidth:1];
    //    [temptxt.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    //    [temptxt.layer setBorderColor:[UIColor colorWithRed:18/255.0f green:113/255.0f blue:219/255.0f alpha:1.0f].CGColor];
    //    [temptxt.layer setCornerRadius:4];
    
}

+(void)setLeftViewInTextField:(UITextField *)temptxt imageName:(NSString *)imageName leftSpace:(float)leftSpace topSpace:(float)topSpace size:(float)size {
    [self setLeftViewInTextField:temptxt imageName:imageName leftSpace:leftSpace topSpace:topSpace height:size width:size];
}

+(void)setLeftViewInTextField:(UITextField *)temptxt imageName:(NSString *)imageName leftSpace:(float)leftSpace topSpace:(float)topSpace{
    [self setLeftViewInTextField:temptxt imageName:imageName leftSpace:leftSpace topSpace:topSpace height:(temptxt.frame.size.height-(topSpace*2)) width:(temptxt.frame.size.height-(topSpace*2))];
}

+(void)setLeftViewInTextField:(UITextField *)temptxt imageName:(NSString *)imageName{
    [self setLeftViewInTextField:temptxt imageName:imageName leftSpace:5 topSpace:5 height:20 width:20];
}

//+(void)setRoundUITextFieldwithLeftSpace:(UITextField *)temptxt lettSpace:(float)leftSpace{
//
//    [self setFontOfTextField:temptxt];
//    temptxt.layer.cornerRadius = temptxt.frame.size.height / 2.0f ;
//    temptxt.layer.borderColor = [[Utility colorFromHexString:APPTextBoxBorderColorNormal] CGColor];
//    temptxt.layer.borderWidth = 1.0f;
//    temptxt.backgroundColor = [UIColor clearColor];
//    temptxt.textColor = [Utility colorFromHexString:AppButtonTextBoxTextColor];
//
//
//    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftSpace, temptxt.frame.size.height)];
//    temptxt.leftView = paddingView;
//    temptxt.leftViewMode = UITextFieldViewModeAlways;
//}

+(void)settxtBorderWithColor:(UITextField *)txtName borderWidth:(float)borderwidth borderColor:(UIColor *)borderColor cornerRadius:(float)cornerRadius imageName:(NSString *)imge
{
    [self settxtBorderWithColor:txtName borderWidth:borderwidth borderColor:borderColor cornerRadius:cornerRadius];
}

+(void)settxtBorderWithColor:(UITextField *)txtName borderWidth:(float)borderwidth borderColor:(UIColor *)borderColor cornerRadius:(float)cornerRadius
{
    [txtName.layer setBorderWidth:borderwidth];
    [txtName.layer setBorderColor:(__bridge CGColorRef _Nullable)(borderColor)];
    [txtName.layer setCornerRadius:cornerRadius];
}

+(void)setTextFieldLeftRightBottom_lightGrayColor_Border:(UITextField*)tetField
{
    //Bottom border
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, tetField.frame.size.height - 1,tetField.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [tetField.layer addSublayer:bottomBorder];
    
    //left border
    CALayer *leftBorder = [CALayer layer];
    leftBorder.frame = CGRectMake(0,35,1,5);
    leftBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [tetField.layer addSublayer:leftBorder];
    
    //right border
    CALayer *rightBorder = [CALayer layer];
    rightBorder.frame = CGRectMake(tetField.frame.size.width - 1,35,1,5);
    rightBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [tetField.layer addSublayer:rightBorder];
}

+(void)setTextFieldLeftRightBottom_lightGrayColor_Border:(UITextField*)tetField x:(float)x
{
    //Bottom border
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, tetField.frame.size.height - 1,tetField.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [tetField.layer addSublayer:bottomBorder];
    
    //left border
    CALayer *leftBorder = [CALayer layer];
    leftBorder.frame = CGRectMake(0,25,1,5);
    leftBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [tetField.layer addSublayer:leftBorder];
    
    //right border
    CALayer *rightBorder = [CALayer layer];
    rightBorder.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width - x,25,1,5);
    rightBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [tetField.layer addSublayer:rightBorder];
}

+ (NSString *)getMilisecondToTime:(NSString *)timeStamp
{
    NSTimeInterval _interval=[timeStamp doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(_interval/1000)];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay|NSCalendarUnitWeekOfMonth|NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
    NSString *time;
    if(components.day!=0)
    {
        if(components.day==1)
        {
            //time=[NSString stringWithFormat:@"%ld day",(long)components.day];
            time=[NSString stringWithFormat:@"yesterday"];
        }
        else
        {
            NSTimeInterval _interval=[timeStamp doubleValue];
            NSDate *date = [NSDate dateWithTimeIntervalSinceNow:(_interval/1000)];
            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd/MM/yyyy"];
            NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
            [dateFormat setTimeZone:gmt];
            NSString *DateAgo = [dateFormat stringFromDate:date];

            time=[NSString stringWithFormat:@"%@",DateAgo];
        }
    }
    else
    {
        if(components.minute > 0)
        {
            time=[NSString stringWithFormat:@"%ld:%ld",(long)components.hour,(long)components.minute];
        }
        else
        {
            time=[NSString stringWithFormat:@"just now"];
        }
    }

    
    return time;
}

+ (NSString *)getMilisecondToTime_HomeScreen:(NSString *)timeStamp
{
    NSTimeInterval _interval=[timeStamp doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(_interval/1000)];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit|NSWeekCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
    NSString *time;
    if(components.day!=0)
    {
        if(components.day==1)
        {
            //time=[NSString stringWithFormat:@"%ld day",(long)components.day];
            time=[NSString stringWithFormat:@"yesterday"];
        }
        else
        {
            NSTimeInterval _interval=[timeStamp doubleValue];
            NSDate *date = [NSDate dateWithTimeIntervalSinceNow:(_interval/1000)];
            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd/MM/yyyy"];
            NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
            [dateFormat setTimeZone:gmt];
            NSString *DateAgo = [dateFormat stringFromDate:date];
            
            time=[NSString stringWithFormat:@"%@",DateAgo];
        }
    }
    else
    {
        timeStamp =[timeStamp stringByReplacingOccurrencesOfString:@"/Date(" withString:@""];
        timeStamp=[timeStamp stringByReplacingOccurrencesOfString:@")/" withString:@""];
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:([timeStamp integerValue] / 1000.0)];
        NSDateFormatter *df = [[NSDateFormatter alloc] init] ;
        [df setDateFormat:@"hh:mm a"];
       time =[df stringFromDate:date];

    }
    return time;
}


+ (NSString *)getDateStringForDate_status:(NSString *)timeStamp
{
    NSTimeInterval _interval=[timeStamp doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(_interval/1000)];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [dateFormat setTimeZone:gmt];
    NSString *DateAgo = [dateFormat stringFromDate:date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit|NSWeekCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
    NSString *time;
    /*if(components.year!=0)
    {
        if(components.year==1)
        {
            time=[NSString stringWithFormat:@"%ld year",(long)components.year];
        }
        else
        {
            time=[NSString stringWithFormat:@"%ld years",(long)components.year];
        }
    }
    else if(components.month!=0)
    {
        if(components.month==1)
        {
            time=[NSString stringWithFormat:@"%ld month",(long)components.month];
        }
        else
        {
            time=[NSString stringWithFormat:@"%ld months",(long)components.month];
        }
    }
    else if(components.week!=0)
    {
        if(components.week==1)
        {
            time=[NSString stringWithFormat:@"%ld week",(long)components.week];
        }
        else
        {
            time=[NSString stringWithFormat:@"%ld weeks",(long)components.week];
        }
    }
    else*/
        
    if(components.day!=0)
    {
        if(components.day==1)
        {
            //time=[NSString stringWithFormat:@"%ld day",(long)components.day];
            time=[NSString stringWithFormat:@"yesterday"];
        }
        else
        {
            time=[NSString stringWithFormat:@"%@",DateAgo];
        }
    }
    else if(components.hour!=0)
    {
        if(components.hour==1)
        {
            time=[NSString stringWithFormat:@"%ld hour ago",(long)components.hour];
        }
        else
        {
            time=[NSString stringWithFormat:@"%ld hours ago",(long)components.hour];
        }
    }
    else if(components.minute!=0)
    {
        if(components.minute==1)
        {
            time=[NSString stringWithFormat:@"%ld min ago",(long)components.minute];
        }
        else
        {
            time=[NSString stringWithFormat:@"%ld mins ago",(long)components.minute];
        }
    }
    else if(components.second>=0)
    {
        if(components.second < 10)
        {
            time=[NSString stringWithFormat:@"just now"];
        }
        else
        {
            time=[NSString stringWithFormat:@"%ld secs ago",(long)components.second];
        }
    }
    return [NSString stringWithFormat:@"%@",time];
}
/*+ (NSString *)getDateStringForDate_status:(NSString *)timeStamp
{
    NSTimeInterval _interval=[timeStamp doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(_interval/1000)];
    
    NSCalendarUnit units = NSCalendarUnitDay | NSCalendarUnitWeekOfYear |
    NSCalendarUnitMonth | NSCalendarUnitYear;
    
    // if `date` is before "now" (i.e. in the past) then the components will be positive
    NSDateComponents *components = [[NSCalendar currentCalendar] components:units
                                                                   fromDate:date
                                                                     toDate:[NSDate date]
                                                                    options:0];
    
    if (components.year > 0)
    {
        return [NSString stringWithFormat:@"%ld years ago", (long)components.year];
    }
    else if (components.month > 0)
    {
        return [NSString stringWithFormat:@"%ld months ago", (long)components.month];
    }
    else if (components.weekOfYear > 0)
    {
        return [NSString stringWithFormat:@"%ld weeks ago", (long)components.weekOfYear];
    }
    else if (components.day > 0)
    {
        if (components.day > 1)
        {
            return [NSString stringWithFormat:@"%ld days ago", (long)components.day];
        }
        else
        {
            return @"Yesterday";
        }
    }
    else
    {
        NSLog(@"%ld-%ld-%ld",(long)components.day,(long)components.month,(long)components.year);
        return @"Today";
    }
}
*/
#pragma mark - TextField View

+(void)setLetfAndRightViewOfTextField:(UITextField *)txtField leftImageName:(NSString *)leftImageName rightImageName:(NSString *)rightImageName{
    
    // UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, txtField.frame.size.height, txtField.frame.size.height)];
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 33, 33)];
    
    // UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, txtField.frame.size.height - 10, txtField.frame.size.height - 10)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 23, 23)];
    imageView.image = [UIImage imageNamed:rightImageName];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [rightView addSubview:imageView];
    txtField.rightView = rightView;
    txtField.rightViewMode = UITextFieldViewModeAlways;
    
    [self setLetfViewOfTextField:txtField leftImageName:leftImageName];
}

+(void)setLetfViewOfTextField:(UITextField *)txtField leftImageName:(NSString *)leftImageName{
    
    // UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, txtField.frame.size.height + 5, txtField.frame.size.height)];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 38, 33)];
    
    //UIView *line = [[UIView alloc] initWithFrame:CGRectMake(leftView.frame.size.width - 5, 5, 1, leftView.frame.size.height - 10)];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(leftView.frame.size.width - 5, 5, 1, 23)];
    
    line.backgroundColor = [UIColor lightGrayColor];
    
    
    //UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 8, leftView.frame.size.width - 5, txtField.frame.size.height - 15)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 8, 28, 18)];
    
    imageView.image = [UIImage imageNamed:leftImageName];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [leftView addSubview:imageView];
    [leftView addSubview:line];
    
    txtField.leftView = leftView;
    txtField.leftViewMode = UITextFieldViewModeAlways;
}

+(void)setRightViewOfTextField:(UITextField *)txtField rightImageName:(NSString *)rightImageName{
    
    //  UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, txtField.frame.size.height, txtField.frame.size.height)];
    
    //  UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, txtField.frame.size.height - 10, txtField.frame.size.height - 10)];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
    
    imageView.image = [UIImage imageNamed:rightImageName];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [rightView addSubview:imageView];
    txtField.rightView = rightView;
    txtField.rightViewMode = UITextFieldViewModeAlways;
}

#pragma mark - Validation method

+ (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


+(BOOL)validateAlphaNumericString:(NSString *)string {
    
    NSCharacterSet *alphanumericSet = [NSCharacterSet alphanumericCharacterSet];
    NSCharacterSet *numberSet = [NSCharacterSet decimalDigitCharacterSet];
    BOOL isAplhaNumericOnly= [[string stringByTrimmingCharactersInSet:alphanumericSet] isEqualToString:@""] && ![[string stringByTrimmingCharactersInSet:numberSet] isEqualToString:@""];
    
    return isAplhaNumericOnly;
}

+(BOOL)validateNumberString:(NSString *)string {
    
    if(string.length == 0) {
        return NO;
    }
    
    NSString *expression = @"^([0-9]+)?(\\.([0-9]{1,2})?)?$";
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:string
                                                        options:0
                                                          range:NSMakeRange(0, [string length])];
    if (numberOfMatches == 0)
        return NO;
    
    return YES;
    
}

+(BOOL)validateBlankField:(NSString *)string {
    
    NSString *value = [string stringByTrimmingCharactersInSet:[NSCharacterSet  whitespaceCharacterSet]];
    
    if([value length]  > 0) {
        return NO;
    }
    
    return YES;
}

+(BOOL)validatePhoneLength:(NSString *)string {
    
    
    NSString *value = [string stringByTrimmingCharactersInSet:[NSCharacterSet  whitespaceCharacterSet]];
    
    if([value length]  == 10) {
        NSCharacterSet *alphanumericSet = [NSCharacterSet alphanumericCharacterSet];
        NSCharacterSet *numberSet = [NSCharacterSet decimalDigitCharacterSet];
        BOOL isAplhaNumericOnly= [[string stringByTrimmingCharactersInSet:alphanumericSet] isEqualToString:@""] && ![[string stringByTrimmingCharactersInSet:numberSet] isEqualToString:@""];
        
        return isAplhaNumericOnly;
    }
    
    NSCharacterSet *alphanumericSet = [NSCharacterSet alphanumericCharacterSet];
    NSCharacterSet *numberSet = [NSCharacterSet decimalDigitCharacterSet];
    BOOL isAplhaNumericOnly= [[string stringByTrimmingCharactersInSet:alphanumericSet] isEqualToString:@""] && ![[string stringByTrimmingCharactersInSet:numberSet] isEqualToString:@""];
    
    if(isAplhaNumericOnly == NO) {
        return YES;
    }
    
    return isAplhaNumericOnly;
}

+(BOOL)validatePassword:(NSString *)string{
    
    NSString *value = [string stringByTrimmingCharactersInSet:[NSCharacterSet  whitespaceCharacterSet]];
    
    if([value length] >= 6 && [value length] <= 30) {
        return YES;
    }
    
    return NO;
}

+(BOOL)validatePassword1:(NSString *)string
{
    NSString *value = [string stringByTrimmingCharactersInSet:[NSCharacterSet  whitespaceCharacterSet]];
    
    if( [value length] <= 5)
    {
        return YES;
    }
    
    return NO;
}

+(BOOL)validateZipCode:(NSString *)string{
    
    NSString *value = [string stringByTrimmingCharactersInSet:[NSCharacterSet  whitespaceCharacterSet]];
    
    if([value length]  < 7) {
        return YES;
    }
    
    return NO;
}


+(BOOL)validatePassword:(NSString *)string  NewPassword:(NSString *)strNewPassword{
    
    NSRange rangeValue = [string rangeOfString:strNewPassword];
    
    if (rangeValue.length > 0) {
        return NO;
    }
    
    return YES;
}


+(BOOL)validatePassword:(NSString *)string  validateRetypePassword:(NSString *)strRetypePassword{
    
    NSString *value = [string stringByTrimmingCharactersInSet:[NSCharacterSet  whitespaceCharacterSet]];
    NSString *value1 = [strRetypePassword stringByTrimmingCharactersInSet:[NSCharacterSet  whitespaceCharacterSet]];
    if ([value isEqualToString:value1]) {
        return YES;
    }
    return NO;
}
+(BOOL)validateTermsAndCondition:(UIButton *)button
{
    if (button.selected) {
        return YES;
    }
    return NO;
}


+(BOOL)validateTextfieldLength:(NSString*)string
{
    NSString *value = [string stringByTrimmingCharactersInSet:[NSCharacterSet  whitespaceCharacterSet]];
    
    if([value length] >= 6) {
        return YES;
    }
    return NO;
}

#pragma mark - DateFormate

+(NSString *) getTimeStamp
{
    return [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
}

+(NSString*)ChangeDateformate:(NSString *)strDate oldDateFtm:(NSString *)strOldDateFtm newDateFtm:(NSString *)strNewDateFtm
{
    NSString *strUpdated_date=strDate;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //@"yyyy-MM-dd hh:mm:ss"
    [dateFormatter setDateFormat:strOldDateFtm];
    NSDate *date = [dateFormatter dateFromString:strUpdated_date];
    // @"MMM dd,yyyy hh:mm a"
    [dateFormatter setDateFormat:strNewDateFtm];
    NSString *strnew_updated_date = [dateFormatter stringFromDate:date];
    
    return strnew_updated_date;
}
+ (NSString *)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    //NSDateComponents *difference = [calendar components:NSCalendarUnitDay
    //                                            fromDate:fromDate toDate:toDate options:0];
    
    NSDateComponents *difference=[[NSCalendar currentCalendar] components:NSCalendarUnitDay
                                                                 fromDate:fromDateTime
                                                                   toDate:[NSDate date]
                                                                  options:0];
    if (difference.hour < 25 && difference.weekOfYear == 0 && difference.day == 0) {
        return [NSString stringWithFormat:@"%ld hour ago", (long)difference.hour];
    }
    else  if (difference.day > 0)
    {
        if (difference.day > 1)
        {
            return [NSString stringWithFormat:@"%ld days ago", (long)[difference day]];
        }
        else
        {
            return @"Yesterday";
        }
    }
    else
    {
        return [NSString stringWithFormat:@"%ld days ago", (long)difference.day];
    }
}

+(NSString *) stringByStrippingHTML:(NSString *)strString {
    NSRange r;
    while ((r = [strString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        strString = [strString stringByReplacingCharactersInRange:r withString:@""];
    return strString;
}

+ (NSString *)getSizeOfFile:(NSString *)filePath {
    NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
    NSInteger fileSize = [[fileAttributes objectForKey:NSFileSize] doubleValue];
    NSString *fileSizeString = [NSByteCountFormatter stringFromByteCount:fileSize countStyle:NSByteCountFormatterCountStyleFile];
    return fileSizeString;
}

#pragma mark -For SliderView
+ (void)SetViewControllerName:(NSString *)viewcontrollerName
{
    [[NSUserDefaults standardUserDefaults]setObject:viewcontrollerName forKey:@"ForSliderNavigation"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


#pragma mark - Interner connection active or not
+(BOOL)isInterNetConnectionIsActive{
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        NSLog(@"There IS NO internet connection");
        return NO;
    }
    return YES;
}


+(NSString *)imageToNSString:(UIImage *)image
{
    NSData *data = UIImagePNGRepresentation(image);
    
    return [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}

#pragma mark - dateFormate

+(NSString *)convertMiliSecondtoDate:(NSString *)dateFormate date:(NSString *)strDate
{
    strDate =[strDate stringByReplacingOccurrencesOfString:@"/Date(" withString:@""];
    strDate=[strDate stringByReplacingOccurrencesOfString:@")/" withString:@""];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:([strDate integerValue] / 1000.0)];
    NSDateFormatter *df = [[NSDateFormatter alloc] init] ;
    [df setDateFormat:dateFormate];
    NSString *dateString =[df stringFromDate:date];
    return dateString;
}

+(NSString *)convertDatetoSpecificDate:(NSString *)dateFormate date:(NSString *)strDate
{
    strDate =[strDate stringByReplacingOccurrencesOfString:@"/Date(" withString:@""];
    strDate=[strDate stringByReplacingOccurrencesOfString:@")/" withString:@""];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:([strDate integerValue] / 1000.0)];
    NSDateFormatter *df = [[NSDateFormatter alloc] init] ;
    [df setDateFormat:dateFormate];
    NSString *dateString =[df stringFromDate:date];
    
    //    NSDateFormatter *df1 = [[NSDateFormatter alloc] init] ;
    //    [df1 setDateFormat:dateFormate];
    //    NSDate *dateString1 =[df1 dateFromString:dateString];
    
    //    NSDateFormatter *df2 = [[NSDateFormatter alloc] init] ;
    //    [df2 setDateFormat:newDateFormate];
    //    NSString *dateString3 =[df2 stringFromDate:dateString1];
    
    return dateString;
}

+(NSString *)convertDateFtrToDtaeFtr:(NSString *)dateFormate newDateFtr:(NSString *)newDateFtr date:(NSString *)strDate
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init] ;
    [df setDateFormat:dateFormate];
    NSDate *dateString =[df dateFromString:strDate];
    
    NSDateFormatter *df1 = [[NSDateFormatter alloc] init] ;
    [df1 setDateFormat:newDateFtr];
    NSString *newDate =[df1 stringFromDate:dateString];
    
    return newDate;
}

#pragma mark - Api Function

+(void)PostApiCall:(NSString *)apiUrl params:(NSMutableDictionary *)param block:(void (^)(NSMutableDictionary *,NSError *))block{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:apiUrl parameters:param progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         if (block) {
             block(responseObject,nil);
         }
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         NSMutableDictionary * jsonData1  = [[NSMutableDictionary alloc]init];
         if (block) {
             block(jsonData1,error);
         }
     }];
    
    
    /* NSData *jsonData = [NSJSONSerialization dataWithJSONObject:param options:0 error:nil];
     NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init ];
     [request setURL:[NSURL URLWithString:apiUrl]];
     [request setHTTPMethod:@"POST"];
     
     [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
     [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
     
     [request setValue:[NSString stringWithFormat:@"%d",[jsonData length]] forHTTPHeaderField:@"Content-length"];
     [request setHTTPBody: jsonData];
     
     NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
     [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
     dispatch_async(dispatch_get_main_queue(), ^{
     if(!error)
     {
     NSMutableDictionary * jsonData1  = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
     if (block) {
     block(jsonData1,nil);
     }
     }
     else
     {
     NSMutableDictionary * jsonData1  = [[NSMutableDictionary alloc]init];
     if (block) {
     block(jsonData1,error);
     }
     }
     });
     }] resume];*/
}

+(void)PostApiCall_AfterTenSec:(NSString *)apiUrl params:(NSMutableDictionary *)param block:(void (^)(NSMutableDictionary *,NSError *))block
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:apiUrl parameters:param progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         if (block) {
             block(responseObject,nil);
         }
     } failure:^(NSURLSessionTask *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         NSMutableDictionary * jsonData1  = [[NSMutableDictionary alloc]init];
         if (block) {
             block(jsonData1,error);
         }
     }];
    
}
+(NSString *)Convertjsontostring:(NSMutableDictionary *)dictonary;
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictonary options:0 error:&error];
    
    if (! jsonData)
    {
        NSLog(@"bv_jsonStringWithPrettyPrint: error: %@", error.localizedDescription);
        return @"[]";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}


+(NSMutableDictionary *)ConvertStringtoJSON:(NSString *)jsonStr;
{
    NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    return json;
}

+(NSMutableArray *)getLocalDetail : (NSArray *)jsonstr columnKey:(NSString *)columnKey
{
    NSData *data;
    NSMutableArray *json = [[NSMutableArray alloc]init];
    
    if([jsonstr count] != 0)
    {
        for (int i=0; i<jsonstr.count; i++)
        {
            data= [[[jsonstr objectAtIndex:i]objectForKey:columnKey]  dataUsingEncoding:NSUTF8StringEncoding];
            [json addObject:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
        }
        
    }
    
    //  NSLog(@"json=%@",json);
    
    return json;
}

+(NSString *)randomImageGenerator
{
    return [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970] * 1000];
}

+(NSString *) randomStringWithLength: (int) len {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize isAspectRation:(BOOL)aspect
{
    if (!image) {
        return nil;
    }
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    CGFloat originRatio = image.size.width / image.size.height;
    CGFloat newRatio = newSize.width / newSize.height;
    
    CGSize sz;
    
    if (!aspect) {
        sz = newSize;
    }else {
        if (originRatio < newRatio) {
            sz.height = newSize.height;
            sz.width = newSize.height * originRatio;
        }else {
            sz.width = newSize.width;
            sz.height = newSize.width / originRatio;
        }
    }
    CGFloat scale = 1.0;
    //    if([[UIScreen mainScreen]respondsToSelector:@selector(scale)]) {
    //        CGFloat tmp = [[UIScreen mainScreen]scale];
    //        if (tmp > 1.5) {
    //            scale = 2.0;
    //        }
    //    }
    sz.width /= scale;
    sz.height /= scale;
    UIGraphicsBeginImageContextWithOptions(sz, NO, scale);
    [image drawInRect:CGRectMake(0, 0, sz.width, sz.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
/*+(void)SaveImageDocumentDirectory :(NSMutableDictionary *)dicImg :(NSString *)url
 {
 NSLog(@"dic=%@",dicImg);
 NSData *data ;
 
 NSURL *url1 = [NSURL URLWithString:[[NSString stringWithFormat:@"%@/%@",url,[dicImg objectForKey:@"ProfilePicture"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
 NSLog(@"url:%@",url1);
 
 NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
 NSString *documentsDirectory = [paths objectAtIndex:0];
 NSLog(@"Directory :%@",documentsDirectory);
 
 NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:[dicImg objectForKey:@"ProfilePicture"]];
 UIImage *image = imageView.image; // imageView is my image from camera
 NSData *imageData = UIImagePNGRepresentation(image);
 [imageData writeToFile:savedImagePath atomically:NO];
 
 [data writeToURL:url1 atomically:YES];
 
 // [data writeToFile:[documentsDirectory stringByAppendingPathComponent:[NSString str]] atomically:YES];
 
 }*/

+(void)SearchTextView: (UIView *)viewSearch
{
    //Bottom border self.view.frame.size.width
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, viewSearch.frame.size.height - 1, [UIScreen mainScreen].bounds.size.width -20, 1.0f);
    bottomBorder.shadowColor = [UIColor grayColor].CGColor;
    bottomBorder.shadowOffset = CGSizeMake(1, 1);
    bottomBorder.shadowOpacity = 1;
    bottomBorder.shadowRadius = 1.0;
    bottomBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [viewSearch.layer addSublayer:bottomBorder];
    
    //left border
    CALayer *leftBorder = [CALayer layer];
    leftBorder.frame = CGRectMake(0.0f, 30.0f, 1.0f, viewSearch.frame.size.height-30);
    leftBorder.shadowColor = [UIColor grayColor].CGColor;
    leftBorder.shadowOffset = CGSizeMake(1, 1);
    leftBorder.shadowOpacity = 1;
    leftBorder.shadowRadius = 1.0;
    leftBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [viewSearch.layer addSublayer:leftBorder];
    
    //right border
    CALayer *rightBorder = [CALayer layer];
    rightBorder.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-20, 30.0f, 1.0f, viewSearch.frame.size.height-30);
    rightBorder.shadowColor = [UIColor grayColor].CGColor;
    rightBorder.shadowOffset = CGSizeMake(1, 1);
    rightBorder.shadowOpacity = 1;
    rightBorder.shadowRadius = 1.0;
    rightBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [viewSearch.layer addSublayer:rightBorder];
}

+(void)SearchTextView1: (UIView *)viewSearch
{
    //Bottom border self.view.frame.size.width
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(5, viewSearch.frame.size.height - 1, [UIScreen mainScreen].bounds.size.width -30, 1.0f);
    bottomBorder.shadowColor = [UIColor grayColor].CGColor;
    bottomBorder.shadowOffset = CGSizeMake(1, 1);
    bottomBorder.shadowOpacity = 1;
    bottomBorder.shadowRadius = 1.0;
    bottomBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [viewSearch.layer addSublayer:bottomBorder];
    
    //left border
    CALayer *leftBorder = [CALayer layer];
    leftBorder.frame = CGRectMake(5, 30.0f, 1.0f, viewSearch.frame.size.height-30);
    leftBorder.shadowColor = [UIColor grayColor].CGColor;
    leftBorder.shadowOffset = CGSizeMake(1, 1);
    leftBorder.shadowOpacity = 1;
    leftBorder.shadowRadius = 1.0;
    leftBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [viewSearch.layer addSublayer:leftBorder];
    
    //right border
    CALayer *rightBorder = [CALayer layer];
    rightBorder.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-25, 30.0f, 1.0f, viewSearch.frame.size.height-30);
    rightBorder.shadowColor = [UIColor grayColor].CGColor;
    rightBorder.shadowOffset = CGSizeMake(1, 1);
    rightBorder.shadowOpacity = 1;
    rightBorder.shadowRadius = 1.0;
    rightBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [viewSearch.layer addSublayer:rightBorder];
}

+(void)removeUserDefaults1
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [userDefaults dictionaryRepresentation];
    
    
    
    for (id key in dict)
    {
        NSLog(@"ALL keys=%@",key);
        
        
        if ([key isEqualToString:@"Password"])
        {
            
        }
        else if ([key isEqualToString:@"MobileNumber"])
        {
            
        }
        else
        {
            [userDefaults removeObjectForKey:key];
        }
        
    }
    [userDefaults synchronize];
    
    /* [[NSUserDefaults standardUserDefaults]setObject:_aPhonenumberTextField.text forKey:@"MobileNumber"];
     [[NSUserDefaults standardUserDefaults]setObject:_aPasswordTextField.text forKey:@"Password"];*/
    
}

+ (NSString *)documentsPathForFileName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    
    return [documentsPath stringByAppendingPathComponent:name];
}




@end
