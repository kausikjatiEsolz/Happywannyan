//
//  ChatViewController.h
//  Happywannyan
//
//  Created by Kausik_Jati on 02/06/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewController : UIViewController
{
    IBOutlet UITableView *chat_tbl;
    IBOutlet UITextField *chat_txt;
    IBOutlet UIView *userinput_view;
    CGFloat currentKeyboardHeight;
}
- (IBAction)back:(UIButton *)sender;
- (IBAction)send:(id)sender;
- (IBAction)attachment:(id)sender;
@end
