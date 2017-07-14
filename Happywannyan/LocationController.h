//
//  LocationController.h
//  Happywannyan
//
//  Created by Rahul Singha Roy on 19/05/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "Json_Class.h"
@interface LocationController : UIViewController
{
    __weak IBOutlet UITableView *locationTable;
    __weak IBOutlet UIView *search_view;
    __weak IBOutlet GMSMapView *gmapView;
    __weak IBOutlet UITextField *location_txt;
    Json_Class *url_obj;
    NSMutableArray *location_ary,*location_ary1;
    IBOutlet UILabel *cell_lbl;
    
}
- (IBAction)back:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *location_btn;
@property (strong, nonatomic) IBOutlet UIButton *clr;
@property (strong, nonatomic) IBOutlet UIView *first_view;
@property (strong, nonatomic) IBOutlet UITableView *search_tbl;
@property (strong, nonatomic) NSMutableArray *geometry_ary;

@end
