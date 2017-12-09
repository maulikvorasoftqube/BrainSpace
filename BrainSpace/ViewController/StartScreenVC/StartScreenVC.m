//
//  StartScreenVC.m
//  BrainSpace
//
//  Created by harikrishna patel on 08/12/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "StartScreenVC.h"
#import "Globle.h"

@interface StartScreenVC ()

@end

@implementation StartScreenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *email=[[NSUserDefaults standardUserDefaults]objectForKey:@"email"];
    if(email.length != 0)
    {
        UIViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
        [self.navigationController pushViewController:vc animated:NO];
    }
    
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 0; i < 59; i++)
    {
        [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"output-%d.png",i]]];
    }
    
    // Normal Animation
    self.img.animationImages = images;
    self.img.animationDuration = 6.0f;
    [self.img startAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnStart:(id)sender
{
    UIViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
