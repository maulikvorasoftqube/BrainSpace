//
//  TherapyDetailVC.m
//  BrainSpace
//
//  Created by harikrishna patel on 09/12/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "TherapyDetailVC.h"

@interface TherapyDetailVC ()

@end

@implementation TherapyDetailVC

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

    self.tblTherapyDetailList.estimatedRowHeight=200;
    
}


#pragma mark - UITableView Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrSelectedTherapy.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=(UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell_row"];
    
    if(indexPath.row % 2)
    {
        cell.contentView.backgroundColor=[UIColor whiteColor];
    }
    else
    {
        cell.contentView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    }
    
//    UILabel *lbl=(UILabel*)[cell.contentView viewWithTag:1];
//    lbl.text=@"";
//    lbl.text = [NSString stringWithFormat:@"%@",[[self.arrSelectedTherapy objectAtIndex:indexPath.row]objectForKey:@"treatment_name"]];
    
    UILabel *lblName=(UILabel*)[cell.contentView viewWithTag:3];
    lblName.text=@"";
    lblName.text = [NSString stringWithFormat:@"%@",[[self.arrSelectedTherapy objectAtIndex:indexPath.row]objectForKey:@"treatment_name"]];
    
    UIImageView *img=(UIImageView *)[cell.contentView viewWithTag:1];
    [img setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[self.arrSelectedTherapy objectAtIndex:indexPath.row]objectForKey:@"image_name"]]] placeholderImage:[UIImage imageNamed:@"output-0"]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UIButton Action

- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnRate_Therapy:(id)sender {

}

@end
