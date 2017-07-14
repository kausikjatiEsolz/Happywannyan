//
//  HelpController.h
//  Happywannyan
//
//  Created by Kausik Jati on 20/06/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Json_Class.h"

@interface HelpController : UIViewController<UIWebViewDelegate>
{
    __weak IBOutlet UIWebView *webview;
    Json_Class *url_obj;
    
}

- (IBAction)back:(UIButton *)sender;
@end
