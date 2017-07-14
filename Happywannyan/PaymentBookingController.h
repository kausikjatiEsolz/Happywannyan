//
//  PaymentBookingController.h
//  Happywannyan
//
//  Created by Kausik_Jati on 29/06/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentBookingController : UIViewController
{
    IBOutlet UIButton *next_btn;
    IBOutlet UILabel *nextbtn_lbl;
    IBOutlet UILabel *chooseservice_lbl;
    IBOutlet UITextField *startdate_textfield;
    IBOutlet UIImageView *downarrow_img;
    IBOutlet UIImageView *calender_img;
    IBOutlet UILabel *underline_lbl;
    IBOutlet UILabel *price_lbl;
    
    
    
    
    IBOutlet UITextField *enddate_textfield;
    IBOutlet UITextField *txt;
    IBOutlet UIView *startdate_view;
    IBOutlet UIView *enddate_view;
    IBOutlet UIView *noofpat_view;
    IBOutlet UIView *timesinday_view;
    IBOutlet UILabel *noofpets_lbl;
    IBOutlet UILabel *timesinaday_lbl;
    NSString *service_id,*noofvisit_str;
    
}

@property(strong,nonatomic)NSMutableArray *data;
@property(strong,nonatomic) NSString *sitterid;

- (IBAction)back:(id)sender;

- (IBAction)chooseservice_tap:(id)sender;
- (IBAction)nextbtn_tap:(id)sender;
- (IBAction)noofpetsbtn_tap:(id)sender;
- (IBAction)timesindaybtn_lbl:(id)sender;

@end
