//
//  WanNyanMeetUpController.m
//  Happywannyan
//
//  Created by Kausik_Jati on 23/06/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import "WanNyanMeetUpController.h"

@interface WanNyanMeetUpController ()

@end

@implementation WanNyanMeetUpController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    petsno=[[NSMutableArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5", nil];
    
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    //[datePicker setDate:[NSDate date]];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(meetingdate_btn:) forControlEvents:UIControlEventValueChanged];
    [meetingdate_textfield setInputView:datePicker];
    
    UIDatePicker *datePicker1 = [[UIDatePicker alloc]init];
    //[datePicker setDate:[NSDate date]];
    datePicker1.datePickerMode = UIDatePickerModeDate;
    [datePicker1 addTarget:self action:@selector(alternatedate_btn:) forControlEvents:UIControlEventValueChanged];
    [alternatedate_textfield setInputView:datePicker1];
    
    
    submitbtn_lbl.frame=CGRectMake(submit_btn.frame.origin.x+submit_btn.frame.size.width/8, submit_btn.frame.origin.y+10, submitbtn_lbl.frame.size.width, submitbtn_lbl.frame.size.height);
    
    clear1_btn.hidden=YES;
    clear2_btn.hidden=YES;
    
    message_textview.layer.cornerRadius=10.0f;
    
    [self shadow:first_view];
    [self shadow:second_view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];


    
    
    meetup_scroll.contentSize = CGSizeMake(0,meetup_scroll.frame.origin.y+meetup_scroll.frame.size.height);
    
    
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


-(void) meetingdate_btn:(id)sender
{
    
    UIDatePicker *picker = (UIDatePicker*)meetingdate_textfield.inputView;
    [picker setMinimumDate:[NSDate date]];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = picker.date;
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    meetingdate_textfield.text = [NSString stringWithFormat:@"%@",dateString];
    
//    if ([meetingdate_textfield.text isEqualToString:@""]) {
//        clear1_btn.hidden=YES;
//    }
//    else
//    {
//        clear1_btn.hidden=NO;
//    }

}


-(void) alternatedate_btn:(id)sender
{

    UIDatePicker *picker = (UIDatePicker*)alternatedate_textfield.inputView;
    [picker setMinimumDate:[NSDate date]];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = picker.date;
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    alternatedate_textfield.text = [NSString stringWithFormat:@"%@",dateString];
    
    
//    if ([alternatedate_textfield.text isEqualToString:@""]) {
//        clear2_btn.hidden=YES;
//    }
//    else
//    {
//        clear2_btn.hidden=NO;
//    }
    
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
    meetup_scroll.contentSize=CGSizeMake(0,meetup_scroll.frame.origin.y+meetup_scroll.frame.size.height+kbSize.height);
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    meetup_scroll.contentSize = CGSizeMake(0,meetup_scroll.frame.origin.y+meetup_scroll.frame.size.height-kbSize.height);
    currentKeyboardHeight = 0.0f;
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

//-(void)textFieldDidEndEditing:(UITextField *)textField{
//    [textField resignFirstResponder];
//}



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

- (IBAction)withpet_tap:(id)sender {
    
    if ([[withpet_btn imageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"check-box-empty"]]) {
         [withpet_btn setImage:[UIImage imageNamed:@"check-box-color"] forState:UIControlStateNormal];
    }
    else{
        [withpet_btn setImage:[UIImage imageNamed:@"check-box-empty"] forState:UIControlStateNormal];
    }
   
    
    
}

- (IBAction)noofpets_tap:(id)sender {
    
    UIAlertController *departureActnSht = [UIAlertController alertControllerWithTitle:@"Number Of Pets"message:nil  preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    
    for (int j =0 ; j< petsno.count; j++)
    {
        NSString *titleString =petsno[j];
        UIAlertAction *action = [UIAlertAction actionWithTitle:titleString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            petsno_lbl.text=petsno[j];
            
            
        }];
        
        [departureActnSht addAction:action];
    }
    
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
//        [self dismissViewControllerAnimated:YES completion:nil];
 //   }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [departureActnSht addAction:cancelAction];
    [self presentViewController:departureActnSht animated:YES completion:nil];
    
}

- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//- (IBAction)clear1_tap:(id)sender {
//    
//    meetingdate_textfield.text=@"";
//    clear1_btn.hidden=YES;
//}
//
//- (IBAction)clear2_tap:(id)sender {
//    
//    alternatedate_textfield.text=@"";
//    clear2_btn.hidden=YES;
//}

@end
