//
//  FavoriteSittersController.h
//  Happywannyan
//
//  Created by Kausik_Jati on 21/06/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavoriteSittersCell.h"
#import "Json_Class.h"

@interface FavoriteSittersController : UIViewController<UITableViewDelegate>
{
    IBOutlet UITableView *favoritesitters_table;
    FavoriteSittersCell *CELL;
    Json_Class *url_obj;
    NSMutableArray *api_ary;
    NSString *bookingapi_str,*start_form;
    IBOutlet UILabel *nodata_lbl;
    IBOutlet UILabel *header_lbl;
}
- (IBAction)menu:(id)sender;

@end
