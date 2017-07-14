//
//  BookingDetailsCell.h
//  Happywannyan
//
//  Created by Kausik_Jati on 25/05/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookingDetailsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *bookingdetail_celllbl;
@property (strong, nonatomic) IBOutlet UIImageView *main_img;
@property (strong, nonatomic) IBOutlet UILabel *name_lbl;
@property (strong, nonatomic) IBOutlet UILabel *year_lbl;
@property (strong, nonatomic) IBOutlet UILabel *month_lbl;
@property (strong, nonatomic) IBOutlet UILabel *gender;
@property (strong, nonatomic) IBOutlet UILabel *breed_lbl;
@property (strong, nonatomic) IBOutlet UILabel *size_lbl;
@property (strong, nonatomic) IBOutlet UILabel *petqn1_lbl;
@property (strong, nonatomic) IBOutlet UILabel *petqn2_lbl;
@property (strong, nonatomic) IBOutlet UIView *celllower_view;

@end
