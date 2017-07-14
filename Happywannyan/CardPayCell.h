//
//  CardPayCell.h
//  Happywannyan
//
//  Created by Kausik_Jati on 08/07/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardPayCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *select_img;
@property (strong, nonatomic) IBOutlet UIImageView *cardtype_img;
@property (strong, nonatomic) IBOutlet UILabel *cardholdername_lbl;
@property (strong, nonatomic) IBOutlet UILabel *cardnumber_lbl;
@property (strong, nonatomic) IBOutlet UIView *carddetails_view;

@end
