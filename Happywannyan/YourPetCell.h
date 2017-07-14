//
//  YourPetCell.h
//  Happywannyan
//
//  Created by Kausik_Jati on 26/05/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YourPetCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *main_img;
@property (strong, nonatomic) IBOutlet UILabel *name_lbl;
@property (strong, nonatomic) IBOutlet UILabel *petType;
@property (strong, nonatomic) IBOutlet UILabel *year;
@property (strong, nonatomic) IBOutlet UILabel *month;
@property (strong, nonatomic) IBOutlet UILabel *gender;
@property (strong, nonatomic) IBOutlet UILabel *size;
@property (strong, nonatomic) IBOutlet UILabel *Breed;
@property (strong, nonatomic) IBOutlet UILabel *first_que;
@property (strong, nonatomic) IBOutlet UILabel *second_que;
@property (strong, nonatomic) IBOutlet UIButton *delete_btn;
@property (strong, nonatomic) IBOutlet UIButton *edit_btn;

@end
