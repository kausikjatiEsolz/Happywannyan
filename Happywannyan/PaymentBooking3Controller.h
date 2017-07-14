//
//  PaymentBooking3Controller.h
//  Happywannyan
//
//  Created by Kausik_Jati on 03/07/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentBooking3Controller : UIViewController
{
    IBOutlet UIButton *paynow_btn;
    IBOutlet UILabel *paynowbtn_lbl;
    IBOutlet UILabel *service_lbl;
    IBOutlet UILabel *serviceprice_lbl;
    IBOutlet UITextField *startdate_textfield;
    IBOutlet UITextField *enddate_textfield;
    IBOutlet UILabel *noofnights_lbl;
    IBOutlet UILabel *noofpets_lbl;
    IBOutlet UILabel *trustsafetyfee_lbl;
    IBOutlet UILabel *totalamount_lbl;
    IBOutlet UILabel *policy_lbl;
    UITextField *txt;
    
}
@property(strong,nonatomic)NSMutableArray *data;


- (IBAction)infobtn_tap:(id)sender;
- (IBAction)paynowbtn_tap:(id)sender;
- (IBAction)back:(id)sender;
@end
