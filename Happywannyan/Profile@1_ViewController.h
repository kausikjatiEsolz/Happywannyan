//
//  Profile@1_ViewController.h
//  Happywannyan_App
//
//  Created by Kausik_Jati on 23/05/17.
//  Copyright © 2017 Kausik_Jati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Profile@1_Cell.h"
#import "ServiceCell.h"
#import "ReviewCell.h"
#import "ImagesCell.h"
#import "WanNyanMeetUpController.h"
@interface Profile_1_ViewController : UIViewController
{
    IBOutlet UIScrollView *profile_scroll;
    NSMutableArray *btn_ary,*firstheader_ary,*secondheader_ary,*thirdheader_ary,*reviewlbl_ary;
    IBOutlet UIView *first_headerview;
    IBOutlet UIView *second_headerview;
    IBOutlet UILabel *lbl;
    IBOutlet UITableView *profile_tbl;
    UIFont *text_font;
    Profile_1_Cell *CELL;
    ServiceCell *CELL1;
    ReviewCell *CELL2;
    IBOutlet UIButton *reservation_btn;
    IBOutlet UITableView *service_table;
    IBOutlet UITableView *review_table;
    IBOutlet UICollectionView *images_collectionview;
    ImagesCell *CELL3;
    __weak IBOutlet UILabel *name_lbl;
    IBOutlet UIView *collectionview_view;
    
    __weak IBOutlet UILabel *nic_name;
    __weak IBOutlet UIImageView *pic_img;
    __weak IBOutlet UILabel *location_lbl;
    __weak IBOutlet UILabel *review_lbl;
    __weak IBOutlet UIView *starview;
    __weak IBOutlet UIView *rightmenu_innerview;
    __weak IBOutlet UIView *rightmenu_mainview;
    __weak IBOutlet UILabel *nodata_lbl;
    __weak IBOutlet UIButton *rightmenuview_btn;
    __weak IBOutlet UILabel *reservationbtn_lbl;
    
    
}
@property (strong, nonatomic) IBOutlet UIView *tblfirst_headerview;
@property (strong, nonatomic) IBOutlet UILabel *firstheader_lbl;
@property (strong, nonatomic) IBOutlet UIView *tblsecond_headerview;
@property (strong, nonatomic) IBOutlet UILabel *tblsecondview_lbl;
@property (strong, nonatomic) IBOutlet UILabel *tblthirdview_lbl;
@property (strong, nonatomic) IBOutlet UIView *tblthird_headerview;
@property (strong, nonatomic) IBOutlet UIView *tblfourthheader_view;
@property (strong, nonatomic) IBOutlet UILabel *tblfourthview_lbl;

@property(strong,nonatomic) NSString *sitterid;


- (IBAction)rightmenuview_tap:(id)sender;
//- (IBAction)meetup_tap:(id)sender;
- (IBAction)contact_tap:(id)sender;
- (IBAction)mappage_tap:(id)sender;
@end
