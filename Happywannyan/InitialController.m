//
//  ViewController.m
//  Happywannyan
//
//  Created by Rahul Singha Roy on 18/05/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import "InitialController.h"
#import "Language_class.h"
#import "LoginController.h"
#import "SignUpController.h"
#import "Search_ViewController.h"
#import "FacebookController.h"
#import "Json_Class.h"
 

@interface InitialController ()<UIScrollViewDelegate>
{
    
    NSDictionary *user_info;
    Json_Class *url_obj;
    
    
    
}

@end

@implementation InitialController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userid"] length]>0)
    {
    
    Search_ViewController *search = [self.storyboard instantiateViewControllerWithIdentifier:@"search"];
    
    [self.navigationController pushViewController:search animated:NO];
        
        
    }
    
    url_obj = [Json_Class new];
    
    user_info = [[Language_class new] language];
    
    first_lbl.text = [user_info valueForKey:@"login_lbl"];
    
    [skip_btn setTitle:[user_info valueForKey:@"skip"] forState:UIControlStateNormal];
    [login_btn setImage:[UIImage imageNamed:[user_info valueForKey:@"login_img"]]  forState:UIControlStateNormal];
    
    [signup_btn setImage:[UIImage imageNamed:[user_info valueForKey:@"signup_img"]]  forState:UIControlStateNormal];
    
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    image.image = [UIImage imageNamed:@"Landing  screen bg"];
    
    
    [scroll addSubview:image];
    
    scroll.contentSize = CGSizeMake(self.view.frame.size.width*2, 0);
    
    
    
    pagecontroller.numberOfPages = 2;
    pagecontroller.currentPage = 0;
    
    
    
    
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pagecontroller.currentPage=(scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)login_Tap:(UIButton *)sender {
    
    LoginController *login = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
    
    
    login.loginForm = _loginForm;
    [self.navigationController pushViewController:login animated:YES];
    
}

- (IBAction)signupTap:(UIButton *)sender {
    
    SignUpController *signup = [self.storyboard instantiateViewControllerWithIdentifier:@"signup"];
    signup.signUpFrom = _loginForm;
    [self.navigationController pushViewController:signup animated:YES];
    
}
- (IBAction)skip_login:(UIButton *)sender {
    
    Search_ViewController *search = [self.storyboard instantiateViewControllerWithIdentifier:@"search"];
    
    [[NSUserDefaults standardUserDefaults]setValue:@"" forKey:@"userid"];
    
    [self.navigationController pushViewController:search animated:YES];
    
}


-(IBAction)fbLogin:(id)sender
{
    FacebookController *fb_login = [FacebookController new];
    
    [fb_login facebook_login:self completionHandler:^(NSDictionary *userProfileInformation) {
        //NSLog(@"userProfileInformation--->%@",userProfileInformation);
        
        
        
        
        
        NSString *url_str=[NSString stringWithFormat:@"%@facebook_login",App_Domain_Url];
        NSString *postdata=[NSString stringWithFormat:@"email=%@&f_name=%@&l_name=%@&fb_id=%@",[userProfileInformation valueForKey:@"email"],[userProfileInformation valueForKey:@"first_name"],[userProfileInformation valueForKey:@"last_name"],[userProfileInformation valueForKey:@"id"]];
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
        
        [request setURL:[NSURL URLWithString:url_str]];
        
        [request setHTTPMethod:@"POST"];
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:[postdata dataUsingEncoding:NSUTF8StringEncoding]];
        [url_obj GlobalDict:request Globalstr:@"array" lodaer:YES Withblock:^(id result,NSError *error){
            
            NSLog(@"%@",result);
            
            NSString *response = [NSString stringWithFormat:@"%@",[result valueForKey:@"response"]];
            
            if ([response isEqualToString:@"1"])
            {
            
                NSDictionary *useinfo = [result valueForKey:@"info_array"];
                
                [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%@",[[result valueForKey:@"info_array"] valueForKey:@"id"]] forKey:@"userid"];
                [[NSUserDefaults standardUserDefaults]setObject:useinfo forKey:@"userinfo"];
            
            Search_ViewController *search = [self.storyboard instantiateViewControllerWithIdentifier:@"search"];
            
            [self.navigationController pushViewController:search animated:YES];
                
                
            }
            
        }];

        
        
        
        
    } failureHandler:^(NSDictionary *errorDetail) {
        
        
        
         
        
        
    }];
}

@end
