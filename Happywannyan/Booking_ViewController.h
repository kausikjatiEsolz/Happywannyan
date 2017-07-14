//
//  Booking_ViewController.h
//  Happywannyan_App
//
//  Created by Kausik_Jati on 22/05/17.
//  Copyright © 2017 Kausik_Jati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Booking_Cell.h"
@interface Booking_ViewController : UIViewController
{
    NSMutableArray *btn_ary,*booking_ary;
    IBOutlet UIScrollView *booking_scroll;
    IBOutlet UILabel *header_lbl;
    IBOutlet UIView *header_view;
    IBOutlet UITableView *booking_tbl;
    Booking_Cell *CELL;
    
   __weak IBOutlet UILabel *nodata_lbl;
    
    NSString *bookingapi_str,*start_form;
}
- (IBAction)menubtn:(UIButton *)sender;
@end
