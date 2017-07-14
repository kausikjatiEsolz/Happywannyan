//
//  Messages_ViewController.h
//  Happywannyan_App
//
//  Created by Kausik_Jati on 22/05/17.
//  Copyright © 2017 Kausik_Jati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Messages_Cell.h"
#import "Json_Class.h"
@interface Messages_ViewController : UIViewController
{
    NSMutableArray *btn_ary,*allmsg_ary;
    IBOutlet UILabel *header_lbl;
    IBOutlet UIView *header_view;
    IBOutlet UIScrollView *message_scroll;
    IBOutlet UITableView *message_tbl;
    Messages_Cell *CELL;
    Json_Class *url_obj;
    NSString *start_form,*msg_section;
    IBOutlet UILabel *nodata_lbl;
}

- (IBAction)menu:(UIButton *)sender;


@end
