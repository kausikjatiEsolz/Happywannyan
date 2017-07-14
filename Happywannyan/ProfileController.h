//
//  ProfileController.h
//  Happywannyan
//
//  Created by Kausik_Jati on 10/07/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Json_Class.h"

@interface ProfileController : UIViewController
{
    IBOutlet UIImageView *profile_img;
    IBOutlet UITextField *firstname_textfield1;
    IBOutlet UITextField *lastname_textfield1;
    IBOutlet UITextField *firstname_textfield2;
    IBOutlet UITextField *lastname_textfield2;
    IBOutlet UILabel *address_lbl1;
    IBOutlet UILabel *phonenocode_lbl;
    IBOutlet UITextField *phoneno_textfield;
    IBOutlet UIButton *termscheck_btn;
    IBOutlet UIButton *save_btn;
    IBOutlet UILabel *savebtn_lbl;
    IBOutlet UIScrollView *profile_scroll;
    IBOutlet UIButton *address_btn;
    CGFloat currentKeyboardHeight;
}
- (IBAction)termscheckbtn_tap:(id)sender;
- (IBAction)leftmenu_tap:(id)sender;
- (IBAction)savebtn_tap:(id)sender;
- (IBAction)photoupload_tap:(id)sender;
- (IBAction)addressbtn_tap:(id)sender;
@end
