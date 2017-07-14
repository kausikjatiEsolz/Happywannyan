//
//  CalenderController.h
//  Happywannyan
//
//  Created by Rahul Singha Roy on 22/05/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSLCalendarView.h"


@interface CalenderController : UIViewController
{
    __weak IBOutlet UILabel *date_lable;
    __weak IBOutlet UILabel *calender_lbl;
    __weak IBOutlet UIButton *cancel_btn;
    __weak IBOutlet UIButton *ok_btn;
    __weak IBOutlet UIButton *dismissBtn;
    __weak IBOutlet UIButton *tutorilashow_never;
    
}
//@property (weak, nonatomic) IBOutlet UIView *calender_view;
@property (weak, nonatomic) IBOutlet DSLCalendarView *calender_view;
- (IBAction)back:(UIButton *)sender;
@property(strong,nonatomic)UIButton *date_button;
- (IBAction)OK:(UIButton *)sender;
@property (strong, nonatomic) UIButton *clr_calender;
@property (weak, nonatomic) IBOutlet UIView *tutorial_view;
- (IBAction)dismissAction:(UIButton *)sender;
- (IBAction)tutorial_show:(UIButton *)sender;
- (IBAction)tutorial_show_never:(UIButton *)sender;


-(void)showtutorial;

@end
