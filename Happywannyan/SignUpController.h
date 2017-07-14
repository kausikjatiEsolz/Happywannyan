//
//  SignUpController.h
//  Happywannyan
//
//  Created by Rahul Singha Roy on 22/05/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpController : UIViewController
{
    __weak IBOutlet UILabel *yourEmail;
    __weak IBOutlet UILabel *yourpassword;
    __weak IBOutlet UILabel *tearms_lbl;
    __weak IBOutlet UIButton *signupBtn;
    __weak IBOutlet UILabel *signupwithfb;
    __weak IBOutlet UILabel *loginpage;
    
    __weak IBOutlet UIButton *login;
    __weak IBOutlet UIView *signUpview;
    
    
    __weak IBOutlet UITextField *emailtext;
    __weak IBOutlet UITextField *passwordtext;
    __weak IBOutlet UIView *lower_view;
    
    __weak IBOutlet UILabel *signup_lbl;
    
}
- (IBAction)login_page:(UIButton *)sender;
- (IBAction)back:(UIButton *)sender;
- (IBAction)fbsignup:(UIButton *)sender;


@property (strong,nonatomic)NSString *signUpFrom;

@end
