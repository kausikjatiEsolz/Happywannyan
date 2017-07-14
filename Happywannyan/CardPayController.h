//
//  CardPayController.h
//  Happywannyan
//
//  Created by Kausik_Jati on 08/07/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardPayCell.h"



@interface CardPayController : UIViewController
{
    CardPayCell *CELL;
    IBOutlet UITableView *cardpay_tbl;
    NSMutableArray *main_ary,*ary;
    IBOutlet UIImageView *newcard_img;
    IBOutlet UIImageView *others_img;
    IBOutlet UIImageView *existing_img;
    IBOutlet UILabel *sendreqbtn_lbl;
    IBOutlet UIButton *sendreq_btn;
}
- (IBAction)existing_tap:(id)sender;

- (IBAction)newcard_tap:(id)sender;
- (IBAction)others_tap:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *footerview;
- (IBAction)back:(id)sender;

@end
