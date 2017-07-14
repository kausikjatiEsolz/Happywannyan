//
//  ServiceCell.h
//  Happywannyan
//
//  Created by Kausik_Jati on 20/06/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *name_lbl;
@property (strong, nonatomic) IBOutlet UILabel *comment_lbl;
@property (strong, nonatomic) IBOutlet UILabel *price_lbl;
@property (strong, nonatomic) IBOutlet UIView *servicetable_cellview;
@property (strong, nonatomic) IBOutlet UIButton *booknowbtn;

@end
