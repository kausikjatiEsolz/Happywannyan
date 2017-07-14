//
//  PetListing_ViewController.h
//  Happywannyan_App
//
//  Created by Kausik_Jati on 18/05/17.
//  Copyright © 2017 Kausik_Jati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PetListing_Cell.h"
@interface PetListing_ViewController : UIViewController
{
    UIFont *text_font;
    IBOutlet UITableView *petlisting_tbl;
    PetListing_Cell *CELL;
    IBOutlet UIView *petlisting_header_view;
    IBOutlet UIButton *map_btn;
    IBOutlet UIButton *cardview_btn;
    IBOutlet UIButton *expand_button;
    
}
- (IBAction)back:(UIButton *)sender;

- (IBAction)mapPage:(UIButton *)sender;
- (IBAction)cardviewPage:(id)sender;
- (IBAction)expand:(id)sender;

@property (strong,nonatomic)UIButton *backPOP;
@property (strong, nonatomic) IBOutlet UILabel *header_lbl;
@property (strong,nonatomic) NSMutableArray *api_ary;
- (IBAction)filter:(UIButton *)sender;


@end
