//
//  Booking_Cell.h
//  Happywannyan_App
//
//  Created by Kausik_Jati on 22/05/17.
//  Copyright © 2017 Kausik_Jati. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Booking_Cell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *name_lbl;
@property (strong, nonatomic) IBOutlet UILabel *subname_lbl;
@property (strong, nonatomic) IBOutlet UILabel *enddate_staticlbl;
@property (strong, nonatomic) IBOutlet UILabel *startdate_staticlbl;
@property (strong, nonatomic) IBOutlet UILabel *bookingid_staticlbl;
@property (strong, nonatomic) IBOutlet UILabel *startdate_lbl;
@property (strong, nonatomic) IBOutlet UILabel *enddate_lbl;
@property (strong, nonatomic) IBOutlet UILabel *bookingid_lbl;
@property (strong, nonatomic) IBOutlet UILabel *service_staticlbl;
@property (strong, nonatomic) IBOutlet UILabel *service_lbl;
@property (strong, nonatomic) IBOutlet UILabel *totalpets_staticlbl;
@property (strong, nonatomic) IBOutlet UILabel *totalpets_lbl;
@property (strong, nonatomic) IBOutlet UILabel *totalamount_staticlbl;
@property (strong, nonatomic) IBOutlet UILabel *totalamount_lbl;
@property (strong, nonatomic) IBOutlet UIImageView *user_img;

@end
