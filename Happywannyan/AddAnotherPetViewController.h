//
//  AddAnotherPetViewController.h
//  Happywannyan
//
//  Created by Kausik_Jati on 27/05/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface AddAnotherPetViewController : UIViewController
{

    UILabel *lbl,*lbl1,*lbl2,*lbl3,*lbl4,*lbl5,*lbl6,*lbl7,*lbl8;
    IBOutlet UIScrollView *addanotherpet_scroll;
    IBOutlet UIButton *choosepettype_btn;
    IBOutlet UILabel *choosepettype_lbl;
    IBOutlet UIButton *save_btn;
    IBOutlet UILabel *savebtn_lbl;
    IBOutlet UIView *scrollview_view;
    NSMutableArray *selection_ary;
    UIImageView *image;
    NSString *pettype_str;
    CGFloat currentKeyboardHeight;
}
- (IBAction)savePet:(UIButton *)sender;
- (IBAction)choosepettypebtn_tap:(id)sender;
//@property (strong, nonatomic) IBOutlet UIView *headerview;
//@property (strong, nonatomic) IBOutlet UIView *footerview;
- (IBAction)back:(id)sender;

@property(strong,nonatomic)NSMutableArray *data;
@property (strong,nonatomic)NSString *edit,*imageLink,*edit_id,*pet_type_id;

@end
