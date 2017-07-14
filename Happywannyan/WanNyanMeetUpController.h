//
//  WanNyanMeetUpController.h
//  Happywannyan
//
//  Created by Kausik_Jati on 23/06/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WanNyanMeetUpController : UIViewController
{
    __weak IBOutlet UITextField *meetingdate_textfield;
    __weak IBOutlet UITextField *alternatedate_textfield;
    __weak IBOutlet UIButton *withpet_btn;
    __weak IBOutlet UITextView *message_textview;
    __weak IBOutlet UIScrollView *meetup_scroll;
    CGFloat currentKeyboardHeight;
        IBOutlet UITextField *txt;
    __weak IBOutlet UIButton *clear2_btn;
    __weak IBOutlet UIButton *clear1_btn;
    __weak IBOutlet UIView *first_view;
    __weak IBOutlet UIView *second_view;
    NSMutableArray *petsno;
    __weak IBOutlet UILabel *petsno_lbl;
    __weak IBOutlet UIButton *submit_btn;
    __weak IBOutlet UILabel *submitbtn_lbl;
}
- (IBAction)withpet_tap:(id)sender;
- (IBAction)noofpets_tap:(id)sender;
- (IBAction)back:(id)sender;
//- (IBAction)clear1_tap:(id)sender;
//- (IBAction)clear2_tap:(id)sender;
@end
