//
//  PaymentBooking2Controller.m
//  Happywannyan
//
//  Created by Kausik_Jati on 30/06/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import "PaymentBooking2Controller.h"
#import "PaymentBooking3Controller.h"
#import "YXSpritesLoadingView.h"


@interface PaymentBooking2Controller ()

@end

@implementation PaymentBooking2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    api_ary=[NSMutableArray new];
    data_ary=[NSMutableArray new];
    ary1=[[NSMutableArray alloc]init];
    
    url_obj=[Json_Class new];
    
    timetbl_view.layer.cornerRadius=10.0f;
    
    blur_view.hidden=YES;
    time_tbl.hidden=YES;
    timetbl_view.hidden=YES;
    
    
    paymentbooking_tbl.contentInset=UIEdgeInsetsMake(0, 0, 70, 0);
    
    
    time_ary=[[NSMutableArray alloc]initWithObjects:@"I'm Flexible",@"12:00 AM" ,@"12:30 AM" ,@"01:00 AM" ,@"01:30 AM" ,@"02:00 AM" ,@"02:30 AM" ,@"03:00 AM" ,@"03:30 AM" ,@"04:00 AM" ,@"04:30 AM" ,@"05:00 AM" ,@"05:30 AM" ,@"06:00 AM" ,@"06:30 AM" ,@"07:00 AM" ,@"07:30 AM" ,@"08:00 AM" ,@"08:30 AM" ,@"09:00 AM" ,@"09:30 AM" ,@"10:00 AM" ,@"10:30 AM" ,@"11:00 AM" ,@"11:30 AM" ,@"12:00 PM" ,@"12:30 PM" ,@"01:00 PM" ,@"01:30 PM" ,@"02:00 PM" ,@"02:30 PM" ,@"03:00 PM" ,@"03:30 PM" ,@"04:00 PM" ,@"04:30 PM" ,@"05:00 PM" ,@"05:30 PM" ,@"06:00 PM" ,@"06:30 PM" ,@"07:00 PM" ,@"07:30 PM" ,@"08:00 PM" ,@"08:30 PM" ,@"09:00 PM" ,@"09:30 PM" ,@"10:00 PM" ,@"10:30 PM" ,@"11:00 PM" ,@"11:30 PM" ,nil];
    
    nextbtn_lbl.frame=CGRectMake(next_btn.frame.origin.x+next_btn.frame.size.width/8, next_btn.frame.origin.y+10, nextbtn_lbl.frame.size.width, nextbtn_lbl.frame.size.height);
    
    
    firstname_textfield.text=[[[NSUserDefaults standardUserDefaults]valueForKey:@"userinfo"] valueForKey:@"firstname"];
    
    lastname_textfield.text=[[[NSUserDefaults standardUserDefaults]valueForKey:@"userinfo"] valueForKey:@"lastname"];
    
    NSString *url_str=[NSString stringWithFormat:@"%@before_booking_info",App_Domain_Url];
    NSString *postdata=[NSString stringWithFormat:@"user_id=%@&sitter_user_id=%@&service_id=%@&langid=%@&start_date=%@&end_date=%@&no_of_visit=%@&no_of_pet=",[[NSUserDefaults standardUserDefaults]valueForKey:@"userid"],_sitterid,_service_id,[[NSUserDefaults standardUserDefaults]valueForKey:@"lan_code"],_startdate_str,_enddate_str,_noofvisit_str];
    
    postdata=[postdata stringByRemovingPercentEncoding];
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
    
    [request setURL:[NSURL URLWithString:url_str]];
    
    [request setHTTPMethod:@"POST"];
    
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:[postdata dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [url_obj GlobalDict:request Globalstr:@"array" lodaer:YES Withblock:^(id result, NSError *error) {
        
        
        NSLog(@"%@",result);
        
        
        
        NSString *response = [NSString stringWithFormat:@"%@",[result valueForKey:@"response"]];
        
        if ([response isEqualToString:@"1"]) {
            
            data_ary=[result valueForKeyPath:@"info_array"];
            
            api_ary=[result valueForKeyPath:@"info_array.pet_section"];
            
            NSLog(@"------>%@",api_ary);
            
            [paymentbooking_tbl reloadData];
        }
    }];
    
    
//    UITapGestureRecognizer *singleFingerTap =
//    [[UITapGestureRecognizer alloc] initWithTarget:self
//                                            action:@selector(handleSingleTap:)];
//    [blur_view addGestureRecognizer:singleFingerTap];
    
}

//- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
//{
//    
//    [UIView transitionWithView:blur_view duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void){
//        blur_view.hidden=YES;
//    } completion:nil];
//    
//    NSLog(@"tapped");
//}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView==paymentbooking_tbl) {
        return _tableheader_view.frame.size.height;
    }
    else
    {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView==paymentbooking_tbl) {
        return _tableheader_view;
    }
    else
    {
        return nil;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView==paymentbooking_tbl) {
         return api_ary.count;
    }
    else
    {
        return time_ary.count;
    }
   
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==paymentbooking_tbl) {
    CELL=[paymentbooking_tbl dequeueReusableCellWithIdentifier:@"paymentbooking2"forIndexPath:indexPath];
        
    CELL.selectionStyle=UITableViewCellSelectionStyleNone;
    
        CELL.celllabel_lbl.text=[[api_ary objectAtIndex:indexPath.row]valueForKey:@"name"];
    
    if ([ary1 containsObject:[api_ary objectAtIndex:indexPath.row]]) {
        CELL.cellimage_img.image=[UIImage imageNamed:@"check-box-color"];
    }
    else
    {
        CELL.cellimage_img.image=[UIImage imageNamed:@"check-box-empty"];
    }
    return CELL;
    }
    else
    {
        CELL1=[time_tbl dequeueReusableCellWithIdentifier:@"time"forIndexPath:indexPath];
        
        CELL1.selectionStyle=UITableViewCellSelectionStyleNone;
        
        CELL1.time_lbl.text=[time_ary objectAtIndex:indexPath.row];
        
        return CELL1;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView==paymentbooking_tbl) {
        return _tablefooter_view.frame.size.height;

    }
    else
    {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (tableView==paymentbooking_tbl) {
        return _tablefooter_view;
    }
    else
    {
        return nil;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    if (tableView==paymentbooking_tbl) {
        if ([ary1 containsObject:[api_ary objectAtIndex:indexPath.row]]) {
            [ary1 removeObject:[api_ary objectAtIndex:indexPath.row]];
        }
        else
        {
            [ary1 addObject:[api_ary objectAtIndex:indexPath.row]];
        }
        [paymentbooking_tbl beginUpdates];
        [paymentbooking_tbl reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [paymentbooking_tbl endUpdates];

    }
    else
    {
        [UIView transitionWithView:blur_view duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void){
            if ([timetbl_headerlbl.text isEqualToString:@"Pick-Up Time"]) {
               pickuptime_lbl.text=[time_ary objectAtIndex:indexPath.row];
            }
            else
            {
                dropofftime_lbl.text=[time_ary objectAtIndex:indexPath.row];
            }
            blur_view.hidden=YES;
        } completion:nil];
    }
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
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

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)pickup_tap:(id)sender {
    
    timetbl_headerlbl.text=@"Pick-Up Time";
    
    [UIView transitionWithView:blur_view duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void){
        blur_view.hidden=NO;
        time_tbl.hidden=NO;
        timetbl_view.hidden=NO;
    } completion:nil];
    
    
}

- (IBAction)dropoff_tap:(id)sender {
    
    timetbl_headerlbl.text=@"Drop-Off Time";
    
    [UIView transitionWithView:blur_view duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void){
        blur_view.hidden=NO;
        time_tbl.hidden=NO;
        timetbl_view.hidden=NO;
    } completion:nil];
    
    
}

- (IBAction)timetblclose_tap:(id)sender {
    [UIView transitionWithView:blur_view duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void){
        blur_view.hidden=YES;
    } completion:nil];
    
}

- (IBAction)nextbtn_tap:(id)sender {
    
    if (firstname_textfield.text.length==0) {
        [YXSpritesLoadingView errorInfo:@"Enter Firstname"];
    }
    else if (lastname_textfield.text.length==0) {
        [YXSpritesLoadingView errorInfo:@"Enter Lastname"];
    }
    else if (pickuptime_lbl.text.length==0) {
        [YXSpritesLoadingView errorInfo:@"Enter Pickup Time"];
    }
    else if (dropofftime_lbl.text.length==0) {
        [YXSpritesLoadingView errorInfo:@"Enter Drop-Off Time"];
    }
    else
    {
    PaymentBooking3Controller *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"paymentbooking3"];
        
        obj.data=[NSMutableArray new];
        obj.data=data_ary;
        
    [self.navigationController pushViewController:obj animated:YES];
    }
}
@end
