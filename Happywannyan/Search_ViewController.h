//
//  Search_ViewController.h
//  Happywannyan_App
//
//  Created by Kausik_Jati on 18/05/17.
//  Copyright © 2017 Kausik_Jati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Search_Cell.h"
#import "Json_Class.h"
#import "Search_walking_Cell.h"
#import "NMRangeSlider.h"
@interface Search_ViewController : UIViewController
{
    NSMutableArray *main_ary,*walkingtbl_ary,*allpetdetails_ary,*petage_ary,*petsize_ary,*otheroption_ary,*ary1,*ary2,*ary3;
    Search_Cell *CELL;
    Json_Class *url_obj;
    IBOutlet UIView *walking_view;
    IBOutlet UIScrollView *walking_scroll;
    IBOutlet UIView *search_mainview;
    IBOutlet UITableView *walking_tbl;
    Search_walking_Cell *CELL1;
    IBOutlet UIButton *search_btn;
    IBOutlet UIImageView *walking_headerview_img;
    IBOutlet UILabel *walking_headerview_lbl;
    IBOutlet UILabel *choosepettype_lbl;
    NSString *petsize_str,*petage_str,*pettype_str,*servicat_str,*minprice_str,*maxprice_str;
    IBOutlet UILabel *rangeslider_lbl_up;
    IBOutlet UILabel *rangeslider_lbl_down;
    
    IBOutlet NMRangeSlider *slider;
    
    __weak IBOutlet UIButton *gpsBtn;
    
    __weak IBOutlet UILabel *searchbtn_lbl;
    
    
    __weak IBOutlet UIButton *filterBtn;
    
}
- (IBAction)filter:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIView *headerview;
@property (strong, nonatomic) IBOutlet UIView *walking_headerview5;
@property (strong, nonatomic) IBOutlet UIView *walking_headerview1;
@property (strong, nonatomic) IBOutlet UIView *walking_headerview2;
@property (strong, nonatomic) IBOutlet UIView *walking_headerview3;
@property (strong, nonatomic) IBOutlet UIView *walking_headerview4;



- (IBAction)mennAction:(UIButton *)sender;
- (IBAction)calender_open:(UIButton *)sender;
- (IBAction)search_tap:(id)sender;
- (IBAction)clear_calender_tap:(id)sender;

//@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *date_btn;
@property (strong, nonatomic) IBOutlet UIButton *date_btn;
@property (strong, nonatomic) IBOutlet UIButton *location_btn;
@property (strong, nonatomic) IBOutlet UIButton *clr;
@property (strong, nonatomic) IBOutlet UIView *first_view;
@property (strong, nonatomic) IBOutlet UITableView *search_tbl;
@property (strong, nonatomic) IBOutlet UIButton *clr_calender;
@property (strong,nonatomic) NSString *filter;
- (IBAction)GPS:(UIButton *)sender;




@end
