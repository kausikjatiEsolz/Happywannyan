//
//  CardController.h
//  Happywannyan
//
//  Created by Kausik Jati on 13/06/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardController : UIViewController
{
    IBOutlet UIButton *petlist_btn;
    IBOutlet UIButton *map_btn;
    IBOutlet UIButton *expand_btn;
    __weak IBOutlet UIView *header_view;
    
    __weak IBOutlet UILabel *header_lbl;
    
    
}
- (IBAction)petlist_tap:(id)sender;
- (IBAction)map_tap:(id)sender;
- (IBAction)expand_tap:(id)sender;
- (IBAction)back:(id)sender;
@property (strong,nonatomic)NSString *fromMap;
@property(strong,nonatomic)UIButton *backPOPback;
- (IBAction)filter:(UIButton *)sender;
@end
