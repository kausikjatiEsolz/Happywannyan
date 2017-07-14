//
//  HelpController.m
//  Happywannyan
//
//  Created by Kausik Jati on 20/06/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import "HelpController.h"

@interface HelpController ()

@end

@implementation HelpController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    url_obj=[Json_Class new];
    
        NSString *url_str=[NSString stringWithFormat:@"%@help?",App_Domain_Url];
        NSString *urlUTF8=[url_str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
        
        [request setURL:[NSURL URLWithString:urlUTF8]];
        
        [url_obj GlobalDict:request Globalstr:@"array" lodaer:YES Withblock:^(id result, NSError *error) {
            
            NSLog(@"%@",result);
            NSString *response = [NSString stringWithFormat:@"%@",[result valueForKey:@"response"]];
            
            if ([response isEqualToString:@"1"])
            {
                NSString *str=[NSString stringWithFormat:@"%@",[result valueForKey:@"page"]];
                NSURL *url1=[NSURL URLWithString:str];
                NSURLRequest *request=[NSURLRequest requestWithURL:url1];
                [webview loadRequest:request];
            }
        }];
    
    
    
}


- (BOOL)webView:(UIWebView *)wv shouldStartLoadWithRequest:(NSURLRequest *)rq
{
//    [webview startAnimating];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back:(UIButton *)sender {
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
