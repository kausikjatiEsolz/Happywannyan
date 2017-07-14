//
//  MessageDetailsController.h
//  Happywannyan
//
//  Created by Rahul Singha Roy on 25/05/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageDetailsController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    
    __weak IBOutlet UITableView *MsgTable;
}

@end
