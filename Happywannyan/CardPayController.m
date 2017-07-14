//
//  CardPayController.m
//  Happywannyan
//
//  Created by Kausik_Jati on 08/07/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import "CardPayController.h"

@interface CardPayController ()

@end

@implementation CardPayController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ary=[[NSMutableArray alloc]init];
    
    
    main_ary=[[NSMutableArray alloc]initWithObjects:@"JOHN DOE",@"JOHN DOE",@"JOHN DOE",@"JOHN DOE",@"JOHN DOE", nil];
    
    sendreqbtn_lbl.frame=CGRectMake(sendreq_btn.frame.origin.x+sendreq_btn.frame.size.width/8-5, sendreq_btn.frame.origin.y+10+5, sendreqbtn_lbl.frame.size.width, sendreqbtn_lbl.frame.size.height);
    
    cardpay_tbl.contentInset = UIEdgeInsetsMake(-20, 0, 100, 0);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 93;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return main_ary.count;
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CELL=[cardpay_tbl dequeueReusableCellWithIdentifier:@"cardpay_cell" forIndexPath:indexPath];
    
    
    CELL.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    CELL.cardholdername_lbl.text=[main_ary objectAtIndex:indexPath.row];
    
    CELL.carddetails_view.layer.cornerRadius=15;
    CELL.carddetails_view.layer.borderWidth=1;
    
    CELL.carddetails_view.layer.borderColor=[UIColor colorWithRed:(244/255.0) green:(244/255.0) blue:(244/255.0) alpha:1].CGColor;
    CELL.select_img.image=[UIImage imageNamed:@"Oval 3"];
    
    
    
   if ([ary containsObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]])
   {
       
       CELL.carddetails_view.layer.borderColor=[UIColor colorWithRed:(39/255.0) green:(118/255.0) blue:(161/255.0) alpha:1].CGColor;
        
        CELL.select_img.image=[UIImage imageNamed:@"Tick"];
    
   }
    else
    {
        CELL.carddetails_view.layer.borderColor=[UIColor colorWithRed:(244/255.0) green:(244/255.0) blue:(244/255.0) alpha:1].CGColor;
        
        CELL.select_img.image=[UIImage imageNamed:@"Oval 3"];

    }
    
    return CELL;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return _footerview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return _footerview.frame.size.height;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    int selectedIndex=[[ary firstObject] intValue];
    [ary removeAllObjects];
    [ary addObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
    NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexpath,indexPath1, nil];
    
    
    [cardpay_tbl reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)existing_tap:(id)sender {
    
    existing_img.image=[UIImage imageNamed:@"Tick"];
    newcard_img.image=[UIImage imageNamed:@"Oval 3"];
    others_img.image=[UIImage imageNamed:@"Oval 3"];
}

- (IBAction)newcard_tap:(id)sender {
    newcard_img.image=[UIImage imageNamed:@"Tick"];
    existing_img.image=[UIImage imageNamed:@"Oval 3"];
    others_img.image=[UIImage imageNamed:@"Oval 3"];
    
}

- (IBAction)others_tap:(id)sender {
    
    others_img.image=[UIImage imageNamed:@"Tick"];
    existing_img.image=[UIImage imageNamed:@"Oval 3"];
    newcard_img.image=[UIImage imageNamed:@"Oval 3"];
    
}
- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
@end
