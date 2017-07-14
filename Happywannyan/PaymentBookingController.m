//
//  PaymentBookingController.m
//  Happywannyan
//
//  Created by Kausik_Jati on 29/06/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import "PaymentBookingController.h"
#import "leftmenu.h"
#import "PaymentBooking2Controller.h"
#import "YXSpritesLoadingView.h"

@interface PaymentBookingController ()
{
    NSMutableArray *noofvisists_ary,*nooftimes_ary;
    UIDatePicker *datePicker,*datePicker1;
}
@end

@implementation PaymentBookingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    noofvisists_ary=[NSMutableArray new];
    nooftimes_ary=[NSMutableArray new];
    
    NSArray *date = [[[NSUserDefaults standardUserDefaults]valueForKey:@"selectdate"] componentsSeparatedByString:@"To"];
    
    if (date.count==2)
    {
        startdate_textfield.text = [date objectAtIndex:0];
        enddate_textfield.text = [date objectAtIndex:1];
        
    }
    
    datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(startdate_btn:) forControlEvents:UIControlEventValueChanged];
    [startdate_textfield setInputView:datePicker];
    
    datePicker1 = [[UIDatePicker alloc]init];
    datePicker1.datePickerMode = UIDatePickerModeDate;
    [datePicker1 addTarget:self action:@selector(enddate_btn:) forControlEvents:UIControlEventValueChanged];
    [enddate_textfield setInputView:datePicker1];
    
    
    
    
    nextbtn_lbl.frame=CGRectMake(next_btn.frame.origin.x+next_btn.frame.size.width/8, next_btn.frame.origin.y+10, nextbtn_lbl.frame.size.width, nextbtn_lbl.frame.size.height);
    
    
    chooseservice_lbl.text=[[_data objectAtIndex:0] valueForKey:@"service_name"];
    
    service_id=[[_data objectAtIndex:0] valueForKey:@"service_id"];
    
    startdate_view.hidden=YES;
    enddate_view.hidden=YES;
    noofpat_view.hidden=YES;
    timesinday_view.hidden=YES;
    
    
    price_lbl.text=[NSString stringWithFormat:@"%@ / %@",[[_data objectAtIndex:0] valueForKey:@"service_price"],[[_data objectAtIndex:0] valueForKey:@"unit_name"]];
    
    if ([[[_data objectAtIndex:0] valueForKey:@"date_field"]isEqualToString:@"double"]) {
        startdate_view.hidden=NO;
        enddate_view.hidden=NO;
    }
    else if ([[[_data objectAtIndex:0] valueForKey:@"date_field"]isEqualToString:@"single"]) {
        startdate_view.hidden=NO;
        calender_img.frame=CGRectMake(self.view.frame.size.width-75, calender_img.frame.origin.y, calender_img.frame.size.width, calender_img.frame.size.height);
        downarrow_img.frame=CGRectMake(self.view.frame.size.width-73,downarrow_img.frame.origin.y, downarrow_img.frame.size.width, downarrow_img.frame.size.height);
        
        startdate_textfield.frame=CGRectMake(startdate_textfield.frame.origin.x,startdate_textfield.frame.origin.y, startdate_textfield.frame.size.width+100, startdate_textfield.frame.size.height);
        
        underline_lbl.frame=CGRectMake(underline_lbl.frame.origin.x,underline_lbl.frame.origin.y, self.view.frame.size.width-45, 1);
    }
    
    
    if ([[[_data objectAtIndex:0] valueForKey:@"no_of_times"]isEqualToString:@"1"]) {
        noofpat_view.hidden=NO;
        [nooftimes_ary removeAllObjects];
        nooftimes_ary=[[[_data objectAtIndex:0] valueForKey:@"no_of_times_dropdown"]mutableCopy];
        noofpets_lbl.text=[NSString stringWithFormat:@"%@",[[nooftimes_ary objectAtIndex:0] valueForKey:@"name"]];
    }
    else if ([[[_data objectAtIndex:0] valueForKey:@"no_of_times"]isEqualToString:@"0"]) {
        noofpat_view.hidden=YES;
    }
    
    
    if ([[[_data objectAtIndex:0] valueForKey:@"no_of_visit"]isEqualToString:@"1"]) {
        timesinday_view.hidden=NO;
        [noofvisists_ary removeAllObjects];
        noofvisists_ary=[[[_data objectAtIndex:0] valueForKey:@"no_of_visit_dropdown"]mutableCopy];
        timesinaday_lbl.text=[[noofvisists_ary objectAtIndex:0] valueForKey:@"name"];
        noofvisit_str=[NSString stringWithFormat:@"%@",[[noofvisists_ary objectAtIndex:0] valueForKey:@"value"]];
        
    }
    else if ([[[_data objectAtIndex:0] valueForKey:@"no_of_visit"]isEqualToString:@"0"]) {
        timesinday_view.hidden=YES;
    }
    
    
}

-(void) startdate_btn:(id)sender
{
    
    enddate_textfield.text=@"";
    datePicker = (UIDatePicker *)startdate_textfield.inputView;
    [datePicker setMinimumDate:[NSDate date]];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = datePicker.date;
    [dateFormat setDateFormat:@"dd MMM yyyy"];
    
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    startdate_textfield.text = [NSString stringWithFormat:@"%@",dateString];
    [datePicker1 setMinimumDate:datePicker.date];
}

-(void) enddate_btn:(id)sender
{
    datePicker1 = (UIDatePicker *)enddate_textfield.inputView;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [datePicker1 setMinimumDate:datePicker.date];
    NSDate *eventDate = datePicker1.date;
    [dateFormat setDateFormat:@"dd MMM yyyy"];
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    enddate_textfield.text = [NSString stringWithFormat:@"%@",dateString];
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    txt=textField;
    
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    keyboardToolbar.barStyle = UIBarStyleDefault;
    
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                      target:self action:@selector(TextViewDoneButtonPressed)];
    keyboardToolbar.items = @[doneBarButton];
    textField.inputAccessoryView = keyboardToolbar;
    return YES;
}

-(void)TextViewDoneButtonPressed
{
    [txt resignFirstResponder];
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

- (IBAction)chooseservice_tap:(id)sender {
    
    UIAlertController *departureActnSht = [UIAlertController alertControllerWithTitle:@"Choose Service"message:nil  preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (int j =0 ; j< _data.count; j++)
    {
        NSString *titleString = [ _data[j] valueForKey:@"service_name"];
        UIAlertAction *action = [UIAlertAction actionWithTitle:titleString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            NSLog(@"%@", _data[j]);
            chooseservice_lbl.text=[_data[j] valueForKey:@"service_name"];
            
            price_lbl.text=[NSString stringWithFormat:@"%@ / %@",[_data[j] valueForKey:@"service_price"],[_data[j] valueForKey:@"unit_name"]];
            
            service_id=@"";
            
            service_id=[_data[j] valueForKey:@"service_id"];
            
            startdate_view.hidden=YES;
            enddate_view.hidden=YES;
            noofpat_view.hidden=YES;
            timesinday_view.hidden=YES;
            
            if ([[_data[j] valueForKey:@"date_field"]isEqualToString:@"double"]) {
                startdate_view.hidden=NO;
                enddate_view.hidden=NO;
            }
            else if ([[_data[j] valueForKey:@"date_field"]isEqualToString:@"single"]) {
                startdate_view.hidden=NO;
                calender_img.frame=CGRectMake(self.view.frame.size.width-75, calender_img.frame.origin.y, calender_img.frame.size.width, calender_img.frame.size.height);
                downarrow_img.frame=CGRectMake(self.view.frame.size.width-73,downarrow_img.frame.origin.y, downarrow_img.frame.size.width, downarrow_img.frame.size.height);
                startdate_textfield.frame=CGRectMake(startdate_textfield.frame.origin.x,startdate_textfield.frame.origin.y, self.view.frame.size.width-40, startdate_textfield.frame.size.height);
                
                underline_lbl.frame=CGRectMake(underline_lbl.frame.origin.x,underline_lbl.frame.origin.y, self.view.frame.size.width-45, 1);
                
            }
            
            
            if ([[_data[j] valueForKey:@"no_of_times"]isEqualToString:@"1"]) {
                noofpat_view.hidden=NO;
                [nooftimes_ary removeAllObjects];
                nooftimes_ary=[[_data[j] valueForKey:@"no_of_times_dropdown"]mutableCopy];
                noofpets_lbl.text=[NSString stringWithFormat:@"%@",[[nooftimes_ary objectAtIndex:0] valueForKey:@"name"]];
            }
            else if ([[_data[j] valueForKey:@"no_of_times"]isEqualToString:@"0"]) {
                noofpat_view.hidden=YES;
            }
            
            
            if ([[_data[j] valueForKey:@"no_of_visit"]isEqualToString:@"1"]) {
                timesinday_view.hidden=NO;
                [noofvisists_ary removeAllObjects];
                noofvisists_ary=[[_data[j] valueForKey:@"no_of_visit_dropdown"]mutableCopy];
                timesinaday_lbl.text=[[noofvisists_ary objectAtIndex:0] valueForKey:@"name"];
                
                noofvisit_str=@"";
                
                noofvisit_str=[NSString stringWithFormat:@"%@",[[noofvisists_ary objectAtIndex:0] valueForKey:@"value"]];
                
                
            }
            else if ([[_data[j] valueForKey:@"no_of_visit"]isEqualToString:@"0"]) {
                timesinday_view.hidden=YES;
            }
            
            
            
            
            
            
        }];
        [departureActnSht addAction:action];
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [departureActnSht addAction:cancelAction];
    [self presentViewController:departureActnSht animated:YES completion:nil];
    
}

- (IBAction)nextbtn_tap:(id)sender {
    
    
    if(startdate_view.hidden==NO && startdate_textfield.text.length == 0)
    {
        [YXSpritesLoadingView errorInfo:@"Please Select Start Date"];
    }
    
    else if (enddate_view.hidden==NO && enddate_textfield.text.length == 0)
    {
        [YXSpritesLoadingView errorInfo:@"Please Select End Date"];
    }
    else
    {
        PaymentBooking2Controller *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"paymentbooking2"];
        obj.startdate_str=startdate_textfield.text;
        obj.enddate_str=enddate_textfield.text;
        obj.sitterid=_sitterid;
        obj.service_id=service_id;
        obj.noofvisit_str=noofvisit_str;
        [self.navigationController pushViewController:obj animated:YES];
    }
    
    
    
}

- (IBAction)noofpetsbtn_tap:(id)sender {
    
    UIAlertController *departureActnSht = [UIAlertController alertControllerWithTitle:@"How many times?"message:nil  preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (int j =0 ; j< nooftimes_ary.count; j++)
    {
        NSString *titleString =[NSString stringWithFormat:@"%@",[ nooftimes_ary[j] valueForKey:@"name"]];
        UIAlertAction *action = [UIAlertAction actionWithTitle:titleString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            NSLog(@"%@", nooftimes_ary[j]);
            noofpets_lbl.text=[NSString stringWithFormat:@"%@",[ nooftimes_ary[j] valueForKey:@"name"]];
            
            
            
        }];
        [departureActnSht addAction:action];
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [departureActnSht addAction:cancelAction];
    [self presentViewController:departureActnSht animated:YES completion:nil];
    
}

- (IBAction)timesindaybtn_lbl:(id)sender {
    
    UIAlertController *departureActnSht = [UIAlertController alertControllerWithTitle:@"How many visits?"message:nil  preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (int j =0 ; j< noofvisists_ary.count; j++)
    {
        NSString *titleString = [ noofvisists_ary[j] valueForKey:@"name"];
        UIAlertAction *action = [UIAlertAction actionWithTitle:titleString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            NSLog(@"%@", noofvisists_ary[j]);
            timesinaday_lbl.text=[noofvisists_ary[j] valueForKey:@"name"];
            
            noofvisit_str=@"";
            
            noofvisit_str=[NSString stringWithFormat:@"%@",[noofvisists_ary[j]valueForKey:@"value"]];
            
        }];
        [departureActnSht addAction:action];
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [departureActnSht addAction:cancelAction];
    [self presentViewController:departureActnSht animated:YES completion:nil];
    
}
@end
