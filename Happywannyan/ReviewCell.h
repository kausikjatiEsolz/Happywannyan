//
//  ReviewCell.h
//  Happywannyan
//
//  Created by Kausik_Jati on 20/06/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *review_cellview;
@property (strong, nonatomic) IBOutlet UIImageView *main_img;
@property (strong, nonatomic) IBOutlet UILabel *name_lbl;
@property (strong, nonatomic) IBOutlet UILabel *date_lbl;
@property (strong, nonatomic) IBOutlet UILabel *comment_lbl;
@property (weak, nonatomic) IBOutlet UIView *star_view;

@end
