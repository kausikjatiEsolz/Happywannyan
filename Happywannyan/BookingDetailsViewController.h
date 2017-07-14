//
//  BookingDetailsViewController.h
//  Happywannyan
//
//  Created by Kausik_Jati on 25/05/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookingDetailsCell.h"
#import "Json_Class.h"
@interface BookingDetailsViewController : UIViewController
{
    NSMutableArray *tbl_ary,*main_ary;
    IBOutlet UITableView *bookingdetails_tbl;
    BookingDetailsCell *CELL;
    UIFont *text_font;
    Json_Class *url_obj;
    IBOutlet UIImageView *user_img;
    IBOutlet UILabel *name_lbl;
    IBOutlet UILabel *subname_lbl;
    IBOutlet UILabel *startdate_lbl;
    IBOutlet UILabel *enddate_lbl;
    IBOutlet UILabel *bookingid_lbl;
    IBOutlet UILabel *service_lbl;
    IBOutlet UILabel *totalpet_lbl;
    IBOutlet UILabel *totalamount_lbl;
    IBOutlet UILabel *tableheadername_lbl;
    IBOutlet UILabel *tableheaderyear_lbl;
    IBOutlet UILabel *tableheadermonth_lbl;
    IBOutlet UILabel *tableheadergendar_lbl;
    IBOutlet UILabel *tableheaderbreed_lbl;
    IBOutlet UILabel *tableheadersize_lbl;
    IBOutlet UILabel *tablefooterquestion1_lbl;
    IBOutlet UILabel *tablefooterquestion2_lbl;
    IBOutlet UIImageView *tableheadermain_img;
    NSString *table_str;
    IBOutlet UIButton *message_btn;
    IBOutlet UILabel *messagebtn_lbl;
    IBOutlet UIButton *cancel_btn;
    IBOutlet UILabel *cancelbtn_lbl;
}
//@property (strong, nonatomic) IBOutlet UIView *bookingdetailstbl_headerview;
//@property (strong, nonatomic) IBOutlet UIView *bookingdetailstbl_footterview;
- (IBAction)back:(UIButton *)sender;

@end
