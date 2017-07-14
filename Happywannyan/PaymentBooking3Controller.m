//
//  PaymentBooking3Controller.m
//  Happywannyan
//
//  Created by Kausik_Jati on 03/07/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import "PaymentBooking3Controller.h"
#import "CardPayController.h"

@interface PaymentBooking3Controller ()
{
    UIDatePicker *datePicker,*datePicker1;
}
@end

@implementation PaymentBooking3Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    paynowbtn_lbl.frame=CGRectMake(paynow_btn.frame.origin.x+paynow_btn.frame.size.width/8, paynow_btn.frame.origin.y+10, paynowbtn_lbl.frame.size.width, paynowbtn_lbl.frame.size.height);
    
    service_lbl.text=[_data valueForKey:@"service_name"];
    serviceprice_lbl.text=[_data valueForKey:@"service_price"];
    startdate_textfield.text=[_data valueForKey:@"start_date"];
    enddate_textfield.text=[_data valueForKey:@"end_date"];
    noofnights_lbl.text=[NSString stringWithFormat:@"%@",[_data valueForKey:@"no_of_nights"]];
    noofpets_lbl.text=[NSString stringWithFormat:@"%@",[_data valueForKey:@"no_of_pet"]];
    trustsafetyfee_lbl.text=[NSString stringWithFormat:@"¥ %@",[_data valueForKey:@"trust_safety_price"]];
    totalamount_lbl.text=[NSString stringWithFormat:@"¥ %@",[_data valueForKey:@"total_price"]];
    policy_lbl.text=[_data valueForKey:@"cancel_policy"];
    
    
    datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(startdate_btn:) forControlEvents:UIControlEventValueChanged];
    [startdate_textfield setInputView:datePicker];
    
    datePicker1 = [[UIDatePicker alloc]init];
    datePicker1.datePickerMode = UIDatePickerModeDate;
    [datePicker1 addTarget:self action:@selector(enddate_btn:) forControlEvents:UIControlEventValueChanged];
    [enddate_textfield setInputView:datePicker1];
    
}


-(void) startdate_btn:(id)sender
{
    enddate_textfield.text=@"";
    datePicker = (UIDatePicker *)startdate_textfield.inputView;
    [datePicker setMinimumDate:[NSDate date]];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = datePicker.date;
    [dateFormat setDateFormat:@"dd MMMM yyyy"];
    
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
    [dateFormat setDateFormat:@"dd MMMM yyyy"];
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

- (IBAction)infobtn_tap:(id)sender {
}

- (IBAction)paynowbtn_tap:(id)sender {
    
    CardPayController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"cardpay"];
    [self.navigationController pushViewController:obj animated:YES];
    
    
}

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
