//
//  FavoriteSittersCell.h
//  Happywannyan
//
//  Created by Kausik_Jati on 21/06/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoriteSittersCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *main_img;
@property (strong, nonatomic) IBOutlet UILabel *name_lbl;
@property (strong, nonatomic) IBOutlet UILabel *address_lbl;
@property (strong, nonatomic) IBOutlet UILabel *resrvation_lbl;
@property (strong, nonatomic) IBOutlet UIButton *meetup_btn;
@property (strong, nonatomic) IBOutlet UIButton *contact_btn;




@end
