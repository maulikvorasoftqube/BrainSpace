//
//  StartScreenVC.h
//  BrainSpace
//
//  Created by harikrishna patel on 08/12/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartScreenVC : UIViewController


@property (strong, nonatomic) IBOutlet UIImageView *img;

- (IBAction)btnStart:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnStart;

@end
