//
//  ResetPasswordViewController.h
//  Happywannyan
//
//  Created by Kausik_Jati on 01/06/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Json_Class.h"
@interface ResetPasswordViewController : UIViewController
{
    IBOutlet UITextField *verification_txt;
    IBOutlet UITextField *newpassword_txt;
    IBOutlet UIView *reset_view;
    IBOutlet UIButton *submit_btn;
    Json_Class *url_obj;
    __weak IBOutlet UILabel *submitbtn_lbl;
}
- (IBAction)back:(id)sender;

- (IBAction)submit_tap:(id)sender;
@property(strong,nonatomic)NSString *resetform;
@end
