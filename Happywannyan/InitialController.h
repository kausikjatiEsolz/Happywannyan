//
//  InitialController.h
//  Happywannyan
//
//  Created by Rahul Singha Roy on 22/05/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InitialController : UIViewController
{
    //anubrata
    __weak IBOutlet UILabel *first_lbl;
    __weak IBOutlet UIButton *login_btn;
    __weak IBOutlet UIButton *signup_btn;
    __weak IBOutlet UIButton *skip_btn;
    __weak IBOutlet UIScrollView *scroll;
    //__weak IBOutlet UIImageView *img1;
    //    __weak IBOutlet UIImageView *img2;
    //     __weak IBOutlet UIImageView *move_img;
    __weak IBOutlet UIPageControl *pagecontroller;
    
    }
- (IBAction)skip_login:(UIButton *)sender;

@property(strong,nonatomic)NSString *loginForm;

@end
