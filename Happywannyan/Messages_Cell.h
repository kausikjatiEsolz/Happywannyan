//
//  Messages_Cell.h
//  Happywannyan_App
//
//  Created by Kausik_Jati on 22/05/17.
//  Copyright © 2017 Kausik_Jati. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Messages_Cell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *user_img;
@property (strong, nonatomic) IBOutlet UILabel *name_lbl;
@property (strong, nonatomic) IBOutlet UILabel *subname_lbl;
@property (strong, nonatomic) IBOutlet UILabel *time_lbl;
@property (strong, nonatomic) IBOutlet UILabel *comment_lbl;

@end
