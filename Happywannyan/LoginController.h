//
//  LoginController.h
//  Happywannyan
//
//  Created by Rahul Singha Roy on 18/05/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Json_Class.h"

@interface LoginController : UIViewController
{
    __weak IBOutlet UIView *login_view;
    
    __weak IBOutlet UILabel *donot_acc_lbl;
    __weak IBOutlet UILabel *email_lbl;
    __weak IBOutlet UIButton *loginBtn;
    __weak IBOutlet UILabel *password;
    __weak IBOutlet UILabel *login_withfb_lbl;
    __weak IBOutlet UITextField *email_text;
    __weak IBOutlet UITextField *password_text;
    __weak IBOutlet UIButton *forgotpassword_btn;
    __weak IBOutlet UIButton *signup_btn;
    __weak IBOutlet UIView *lower_view;
    
    Json_Class *url_obj;
    
     

    
}
- (IBAction)back:(UIButton *)sender;
- (IBAction)sender:(UIButton *)sender;
- (IBAction)loginTap:(UIButton *)sender;
- (IBAction)fblogin:(UIButton *)sender;


@property(strong,nonatomic)NSString *loginForm;

@end
