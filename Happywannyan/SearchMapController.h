//
//  SearchMapController.h
//  Happywannyan
//
//  Created by Rahul Singha Roy on 23/05/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface SearchMapController : UIViewController
{
    
    IBOutlet GMSMapView *maps;
    IBOutlet UIButton *back_btn;
    IBOutlet UIButton *expand_btn;
    IBOutlet UIButton *cardview_btn;
    __weak IBOutlet UILabel *header_lbl;
    
    
    __weak IBOutlet UIButton *filter;
    
}
- (IBAction)back:(UIButton *)sender;
- (IBAction)backTosearch:(UIButton *)sender;
- (IBAction)expand:(id)sender;
- (IBAction)cardview:(id)sender;

@property (strong,nonatomic)UIButton *backPOPback;
@property(strong,nonatomic)NSArray *data_Array;
@property(strong,nonatomic)NSString *check_lat_lon;

- (IBAction)filter:(UIButton *)sender;

@end
