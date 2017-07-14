//
//  PaymentBooking2Controller.h
//  Happywannyan
//
//  Created by Kausik_Jati on 30/06/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentBooking2Cell.h"
#import "TimeCell.h"
#import "Json_Class.h"

@interface PaymentBooking2Controller : UIViewController
{
    PaymentBooking2Cell *CELL;
    TimeCell *CELL1;
    IBOutlet UITableView *paymentbooking_tbl;
    IBOutlet UIButton *next_btn;
    IBOutlet UILabel *nextbtn_lbl;
    NSMutableArray *api_ary,*ary1,*time_ary,*data_ary;
    IBOutlet UITableView *time_tbl;
    IBOutlet UIView *blur_view;
    IBOutlet UILabel *timetbl_headerlbl;
    IBOutlet UIView *timetbl_view;
    IBOutlet UITextField *firstname_textfield;
    IBOutlet UITextField *lastname_textfield;
    IBOutlet UILabel *dropofftime_lbl;
    IBOutlet UILabel *pickuptime_lbl;
    Json_Class *url_obj;
}
@property (strong, nonatomic) IBOutlet UIView *tableheader_view;
@property (strong, nonatomic) IBOutlet UIView *tablefooter_view;
@property (strong, nonatomic) NSString *startdate_str,*enddate_str,*sitterid,*service_id,*noofvisit_str;

- (IBAction)back:(id)sender;
- (IBAction)pickup_tap:(id)sender;
- (IBAction)dropoff_tap:(id)sender;
- (IBAction)timetblclose_tap:(id)sender;
- (IBAction)nextbtn_tap:(id)sender;
@end
