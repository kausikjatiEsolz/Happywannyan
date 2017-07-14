//
//  PetListing_Cell.h
//  Happywannyan_App
//
//  Created by Kausik_Jati on 18/05/17.
//  Copyright © 2017 Kausik_Jati. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PetListing_Cell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *main_image;
@property (strong, nonatomic) IBOutlet UILabel *name_lbl;
@property (strong, nonatomic) IBOutlet UILabel *subname_lbl;
@property (strong, nonatomic) IBOutlet UILabel *day_lbl;
@property (strong, nonatomic) IBOutlet UIImageView *star_img1;
@property (strong, nonatomic) IBOutlet UIImageView *star_img2;
@property (strong, nonatomic) IBOutlet UIImageView *star_img3;
@property (strong, nonatomic) IBOutlet UIImageView *star_img4;
@property (strong, nonatomic) IBOutlet UIImageView *star_img5;
@property (strong, nonatomic) IBOutlet UILabel *comment_lbl;
@property (strong, nonatomic) IBOutlet UIView *location_view;
@property (strong, nonatomic) IBOutlet UIImageView *location_img;
@property (strong, nonatomic) IBOutlet UILabel *location_lbl;
@property (strong, nonatomic) IBOutlet UILabel *review_lbl;
@property (strong, nonatomic) IBOutlet UIView *main_view;
@property (strong, nonatomic) IBOutlet UILabel *lbl;
@property (weak, nonatomic) IBOutlet UILabel *service_name_all;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIView *starview;


@end
