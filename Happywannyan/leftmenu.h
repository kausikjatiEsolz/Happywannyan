//
//  leftmenu.h
//  Happywannyan
//
//  Created by Rahul Singha Roy on 18/05/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface leftmenu : UIView<UITableViewDelegate,UITableViewDataSource>
{
     CGPoint translation;
    
    UIView *demo;
    
    BOOL endPan;
    
     __strong UIView *back_view;
    
    NSArray *table_array;
    
    NSArray *login_array , *guest_array;
    
    __weak IBOutlet UILabel *name_lbl;
    NSDictionary *user_info;
    
    
    UIViewController *visibale_controller;
    
}

@property (weak, nonatomic) IBOutlet UIButton *signinorSignup;
@property (weak , nonatomic) UIViewController *controller_obj;
@property (nonatomic,strong) UIPanGestureRecognizer *pan;
@property (strong,nonatomic)IBOutlet UITableView *leftTable;
@property (weak, nonatomic) IBOutlet UIImageView *profile_image;


-(void)Leftmenu:(UIViewController *)viewcontroller sideMenu:(UIView *)side_menu;
- (IBAction)signinorSignup:(id)sender;

-(void)lefMenuopen:(UIButton *)sender;


@end
