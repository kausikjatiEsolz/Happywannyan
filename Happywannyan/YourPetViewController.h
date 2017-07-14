//
//  YourPetViewController.h
//  Happywannyan
//
//  Created by Kausik_Jati on 26/05/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YourPetCell.h"
#import "leftmenu.h"
#import "Json_Class.h"
@interface YourPetViewController : UIViewController
{
    IBOutlet UITableView *yourpet_tbl;
    YourPetCell *CELL;
    leftmenu *leftMenu_obj;
    Json_Class *url_obj;
    NSMutableArray *main_ary;
    NSString *start_from;
}
- (IBAction)leftmenu:(UIButton *)sender;
- (IBAction)add_tap:(id)sender;
- (IBAction)delete_tap:(id)sender;
@end
