//
//  ContactController.h
//  Happywannyan
//
//  Created by Kausik_Jati on 26/06/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickUpTimeCell.h"
#import "Json_Class.h"

@interface ContactController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    __weak IBOutlet UIView *first_view;
    __weak IBOutlet UITextView *addmessage_textview;
    __weak IBOutlet UIView *second_view;
    __weak IBOutlet UITextField *startdate_textfield;
    __weak IBOutlet UITextField *enddate_textfield;
    __weak IBOutlet UILabel *starttime_lbl;
    __weak IBOutlet UILabel *endtime_lbl;
    __weak IBOutlet UIScrollView *contact_scroll;
    __weak IBOutlet UILabel *sendbtn_lbl;
    
    
    __weak IBOutlet UIButton *send_btn;
    __weak IBOutlet UIButton *nodate_btn;
    __weak IBOutlet UITableView *pickuptime_table;
    PickUpTimeCell *CELL1;
           IBOutlet UITextField *txt;
           CGFloat currentKeyboardHeight;
    __weak IBOutlet UIView *pickuptime_view;
    NSMutableArray *pickuptime_ary;
    __weak IBOutlet UIView *blur_view;
    __weak IBOutlet UIButton *tableclose_btn;
    __weak IBOutlet UILabel *tableheader_lbl;
    Json_Class *url_obj;
    NSString *dontdate_str;
}
@property(strong,nonatomic) NSString *sitterid;



- (IBAction)starttime_tap:(id)sender;
- (IBAction)endtime_tap:(id)sender;
- (IBAction)nodate_tap:(id)sender;
- (IBAction)timetablehide_tap:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)sendbtn_tap:(id)sender;
@end
