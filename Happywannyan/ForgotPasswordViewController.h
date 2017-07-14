//
//  ForgotPasswordViewController.h
//  Happywannyan
//
//  Created by Kausik_Jati on 31/05/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Json_Class.h"
@interface ForgotPasswordViewController : UIViewController
{
    IBOutlet UIButton *submit_btn;
    IBOutlet UITextField *email_txt;
    Json_Class *url_obj;
    IBOutlet UIView *forgot_view;
    IBOutlet UIView *lower_view;
    __weak IBOutlet UILabel *submitbtn_lbl;
}
- (IBAction)submit_tap:(id)sender;
@property(strong,nonatomic)NSString *forgotform;
@end
