//
//  ContactController.m
//  Happywannyan
//
//  Created by Kausik_Jati on 26/06/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import "ContactController.h"

@interface ContactController ()
{
    UIDatePicker *datePicker,*datePicker1;
}
@end

@implementation ContactController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dontdate_str=@"0";
    
    pickuptime_ary=[[NSMutableArray alloc]initWithObjects:@"I'm Flexible",@"12:00 AM" ,@"12:30 AM" ,@"01:00 AM" ,@"01:30 AM" ,@"02:00 AM" ,@"02:30 AM" ,@"03:00 AM" ,@"03:30 AM" ,@"04:00 AM" ,@"04:30 AM" ,@"05:00 AM" ,@"05:30 AM" ,@"06:00 AM" ,@"06:30 AM" ,@"07:00 AM" ,@"07:30 AM" ,@"08:00 AM" ,@"08:30 AM" ,@"09:00 AM" ,@"09:30 AM" ,@"10:00 AM" ,@"10:30 AM" ,@"11:00 AM" ,@"11:30 AM" ,@"12:00 PM" ,@"12:30 PM" ,@"01:00 PM" ,@"01:30 PM" ,@"02:00 PM" ,@"02:30 PM" ,@"03:00 PM" ,@"03:30 PM" ,@"04:00 PM" ,@"04:30 PM" ,@"05:00 PM" ,@"05:30 PM" ,@"06:00 PM" ,@"06:30 PM" ,@"07:00 PM" ,@"07:30 PM" ,@"08:00 PM" ,@"08:30 PM" ,@"09:00 PM" ,@"09:30 PM" ,@"10:00 PM" ,@"10:30 PM" ,@"11:00 PM" ,@"11:30 PM" ,nil];
    
    pickuptime_view.layer.cornerRadius=10.0f;
    [self shadow:pickuptime_view];
    
    blur_view.hidden=YES;
    tableclose_btn.hidden=YES;
    pickuptime_view.hidden=YES;
    
    
    
    
    datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(startdate_btn:) forControlEvents:UIControlEventValueChanged];
    [startdate_textfield setInputView:datePicker];
    
    datePicker1 = [[UIDatePicker alloc]init];
    datePicker1.datePickerMode = UIDatePickerModeDate;
    [datePicker1 addTarget:self action:@selector(enddate_btn:) forControlEvents:UIControlEventValueChanged];
    [enddate_textfield setInputView:datePicker1];
    
    
    [self shadow:first_view];
    [self shadow:second_view];
    
    addmessage_textview.layer.cornerRadius=10.0f;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    sendbtn_lbl.frame=CGRectMake(send_btn.frame.origin.x+send_btn.frame.size.width/8, send_btn.frame.origin.y+10, sendbtn_lbl.frame.size.width, sendbtn_lbl.frame.size.height);
    
    contact_scroll.contentSize = CGSizeMake(0,contact_scroll.frame.origin.y+contact_scroll.frame.size.height);
    
    [addmessage_textview.superview bringSubviewToFront:addmessage_textview];
    
   // [pickuptime_table reloadData];
}

-(void)shadow:(UIView *)subview
{
    UIColor *color = [UIColor blackColor];
    subview.layer.shadowColor = [color CGColor];
    subview.layer.shadowRadius = 1.0f;
    subview.layer.shadowOpacity = 1.5;
    subview.layer.shadowOffset = CGSizeZero;
    subview.layer.masksToBounds = NO;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}


- (void)keyboardWillShow:(NSNotification*)notification
{
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    contact_scroll.contentSize=CGSizeMake(0,contact_scroll.frame.origin.y+contact_scroll.frame.size.height+kbSize.height);
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    contact_scroll.contentSize = CGSizeMake(0,contact_scroll.frame.origin.y+contact_scroll.frame.size.height-kbSize.height);
    currentKeyboardHeight = 0.0f;
    contact_scroll.contentSize = CGSizeMake(0,contact_scroll.frame.origin.y+contact_scroll.frame.size.height);
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


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return pickuptime_ary.count;
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CELL1=[pickuptime_table dequeueReusableCellWithIdentifier:@"pickuptime"forIndexPath:indexPath];
    
    CELL1.selectionStyle=UITableViewCellSelectionStyleNone;
    
    CELL1.pickuptime_lbl.text=[pickuptime_ary objectAtIndex:indexPath.row];
    
    return CELL1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [UIView transitionWithView:pickuptime_view duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void){
        
        if ([tableheader_lbl.text isEqualToString:@"Pick-Up Time"]) {
            starttime_lbl.text=[pickuptime_ary objectAtIndex:indexPath.row];
        }
        else
        {
            endtime_lbl.text=[pickuptime_ary objectAtIndex:indexPath.row];
        }
        pickuptime_view.hidden=YES;
        blur_view.hidden=YES;
        tableclose_btn.hidden=YES;
    } completion:nil];
    
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

- (IBAction)starttime_tap:(id)sender {
    
    tableheader_lbl.text=@"Pick-Up Time";
    
    [UIView transitionWithView:pickuptime_view duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void){
        pickuptime_view.hidden=NO;
        blur_view.hidden=NO;
        tableclose_btn.hidden=NO;
    } completion:nil];
}

- (IBAction)endtime_tap:(id)sender {
    
    tableheader_lbl.text=@"Drop-Off Time";
    [UIView transitionWithView:pickuptime_view duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void){
        pickuptime_view.hidden=NO;
        blur_view.hidden=NO;
        tableclose_btn.hidden=NO;
    } completion:nil];
    
    
}

- (IBAction)nodate_tap:(id)sender {
    
    if ([[nodate_btn imageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"check-box-empty"]]) {
        [nodate_btn setImage:[UIImage imageNamed:@"check-box-color"] forState:UIControlStateNormal];
        dontdate_str=@"";
        dontdate_str=@"1";
        
    }
    else{
        [nodate_btn setImage:[UIImage imageNamed:@"check-box-empty"] forState:UIControlStateNormal];
        dontdate_str=@"";
        dontdate_str=@"0";
        
    }

}

- (IBAction)timetablehide_tap:(id)sender {
    
    
    [UIView transitionWithView:pickuptime_view duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void){
        pickuptime_view.hidden=YES;
        blur_view.hidden=YES;
        tableclose_btn.hidden=YES;
    } completion:nil];

}

- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];

    
}

-(void)urlData
{
    NSString *url_str=[NSString stringWithFormat:@"%@contact_sitter?",App_Domain_Url];
    NSString *postdata=[NSString stringWithFormat:@"user_id=%@&langid=%@&sitter_id=%@&user_timezone=%@&add_message=%@&start_date=%@&end_date=%@&drop_off=%@&pick_up=%@&dont_date=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"userid"],[[NSUserDefaults standardUserDefaults]valueForKey:@"lan_code"],_sitterid,[NSTimeZone systemTimeZone].name,addmessage_textview.text,startdate_textfield.text,enddate_textfield.text,starttime_lbl.text,endtime_lbl.text,dontdate_str];
    
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
            

        }
    }];

}

- (IBAction)sendbtn_tap:(id)sender {
    
    
    
    [self urlData];
    
    
    
    
}
@end
