//
//  ForgotPasswordViewController.m
//  Happywannyan
//
//  Created by Kausik_Jati on 31/05/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "SignUpController.h"
#import "FacebookController.h"
#import "ResetPasswordViewController.h"

@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    url_obj=[Json_Class new];
    submit_btn.clipsToBounds = YES;
    
    //submit_btn.layer.cornerRadius = 20;
    
    [self shadow:forgot_view];
    
    forgot_view.layer.cornerRadius = 3;
    
    submitbtn_lbl.frame=CGRectMake(submit_btn.frame.origin.x+submit_btn.frame.size.width/8, submit_btn.frame.origin.y+10, submitbtn_lbl.frame.size.width, submitbtn_lbl.frame.size.height);
    
    
    
    lower_view.hidden=YES;
}

-(void)shadow:(UIView *)subview
{
    subview.layer.masksToBounds = NO;
    subview.layer.shadowOffset = CGSizeMake(0, 0);
    subview.layer.shadowRadius = 1;
    subview.layer.shadowOpacity = 0.5;
    subview.layer.shadowColor = [[UIColor darkGrayColor] CGColor];
}


- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)signup_tap:(id)sender {
    
    SignUpController *signup = [self.storyboard instantiateViewControllerWithIdentifier:@"signup"];
    [self.navigationController pushViewController:signup animated:YES];
}
- (IBAction)facbook_login:(id)sender {
    
    FacebookController *fb_login = [FacebookController new];
    
    [fb_login facebook_login:self completionHandler:^(NSDictionary *userProfileInformation) {
        NSLog(@"userProfileInformation--->%@",userProfileInformation);
        
    } failureHandler:^(NSDictionary *errorDetail) {
        
        
        
        
        
        
    }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}


-(BOOL)Emailtest:(NSString *)Email
{
    
    NSString *emailRegex = @"^[_A-Za-z0-9-+]+(\\.[_A-Za-z0-9-+]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z‌​]{2,4})$";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    NSRange aRange;
    
    if([emailTest evaluateWithObject:Email]) {
        
        aRange = [Email rangeOfString:@"." options:NSBackwardsSearch range:NSMakeRange(0, [Email length])];
        
        NSInteger indexOfDot = aRange.location;
        
        //NSLog(@"aRange.location:%d - %d",aRange.location, indexOfDot);
        
        if(aRange.location != NSNotFound) {
            
            NSString *topLevelDomain = [Email substringFromIndex:indexOfDot];
            
            topLevelDomain = [topLevelDomain lowercaseString];
            
            //NSLog(@"topleveldomains:%@",topLevelDomain);
            
            NSSet *TLD;
            
            TLD = [NSSet setWithObjects:@".aero", @".asia", @".biz", @".cat", @".com", @".coop", @".edu", @".gov", @".info", @".int", @".jobs", @".mil", @".mobi", @".museum", @".name", @".net", @".org", @".pro", @".tel", @".travel", @".ac", @".ad", @".ae", @".af", @".ag", @".ai", @".al", @".am", @".an", @".ao", @".aq", @".ar", @".as", @".at", @".au", @".aw", @".ax", @".az", @".ba", @".bb", @".bd", @".be", @".bf", @".bg", @".bh", @".bi", @".bj", @".bm", @".bn", @".bo", @".br", @".bs", @".bt", @".bv", @".bw", @".by", @".bz", @".ca", @".cc", @".cd", @".cf", @".cg", @".ch", @".ci", @".ck", @".cl", @".cm", @".cn", @".co", @".cr", @".cu", @".cv", @".cx", @".cy", @".cz", @".de", @".dj", @".dk", @".dm", @".do", @".dz", @".ec", @".ee", @".eg", @".er", @".es", @".et", @".eu", @".fi", @".fj", @".fk", @".fm", @".fo", @".fr", @".ga", @".gb", @".gd", @".ge", @".gf", @".gg", @".gh", @".gi", @".gl", @".gm", @".gn", @".gp", @".gq", @".gr", @".gs", @".gt", @".gu", @".gw", @".gy", @".hk", @".hm", @".hn", @".hr", @".ht", @".hu", @".id", @".ie", @" No", @".il", @".im", @".in", @".io", @".iq", @".ir", @".is", @".it", @".je", @".jm", @".jo", @".jp", @".ke", @".kg", @".kh", @".ki", @".km", @".kn", @".kp", @".kr", @".kw", @".ky", @".kz", @".la", @".lb", @".lc", @".li", @".lk", @".lr", @".ls", @".lt", @".lu", @".lv", @".ly", @".ma", @".mc", @".md", @".me", @".mg", @".mh", @".mk", @".ml", @".mm", @".mn", @".mo", @".mp", @".mq", @".mr", @".ms", @".mt", @".mu", @".mv", @".mw", @".mx", @".my", @".mz", @".na", @".nc", @".ne", @".nf", @".ng", @".ni", @".nl", @".no", @".np", @".nr", @".nu", @".nz", @".om", @".pa", @".pe", @".pf", @".pg", @".ph", @".pk", @".pl", @".pm", @".pn", @".pr", @".ps", @".pt", @".pw", @".py", @".qa", @".re", @".ro", @".rs", @".ru", @".rw", @".sa", @".sb", @".sc", @".sd", @".se", @".sg", @".sh", @".si", @".sj", @".sk", @".sl", @".sm", @".sn", @".so", @".sr", @".st", @".su", @".sv", @".sy", @".sz", @".tc", @".td", @".tf", @".tg", @".th", @".tj", @".tk", @".tl", @".tm", @".tn", @".to", @".tp", @".tr", @".tt", @".tv", @".tw", @".tz", @".ua", @".ug", @".uk", @".us", @".uy", @".uz", @".va", @".vc", @".ve", @".vg", @".vi", @".vn", @".vu", @".wf", @".ws", @".ye", @".yt", @".za", @".zm", @".zw", nil];
            
            if(topLevelDomain != nil && ([TLD containsObject:topLevelDomain])) {
                
                //NSLog(@"TLD contains topLevelDomain:%@",topLevelDomain);
                
                return false;
                
            }
            
            /*else {
             
             NSLog(@"TLD DOEST NOT contains topLevelDomain:%@",topLevelDomain);
             
             }*/
            
        }
    }
    return true;
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

- (IBAction)submit_tap:(id)sender {
    
    if ([self Emailtest:email_txt.text]==true) {
        email_txt.text=@"";
        email_txt.placeholder=@"Please Enter Valid Email-ID";
    }
    else
    {
        [self urldata];
    }
    
}

-(void)urldata
{
    {
        
        
        NSString *url_str=[NSString stringWithFormat:@"%@app_forget_password",App_Domain_Url];
        NSString *postdata=[NSString stringWithFormat:@"user_email=%@",email_txt.text];
        
        postdata=[postdata stringByRemovingPercentEncoding];
        
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
        
        [request setURL:[NSURL URLWithString:url_str]];
        
        [request setHTTPMethod:@"POST"];
        
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        [request setHTTPBody:[postdata dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        
        [url_obj GlobalDict:request Globalstr:@"array" lodaer:YES Withblock:^(id result, NSError *error) {
            
            
            NSLog(@"%@",result);
            
            NSString *response = [NSString stringWithFormat:@"%@",[result valueForKey:@"response"]];
            
            if ([response isEqualToString:@"1"])
            {
                NSDictionary *useinfo = [result valueForKey:@"info_array"];
                
                [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%@",[[result valueForKey:@"info_array"] valueForKey:@"id"]] forKey:@"userid"];
                [[NSUserDefaults standardUserDefaults]setObject:useinfo forKey:@"userinfo"];
                
                
                if (![self.forgotform isEqualToString:@"leftmenu"])
                {
                    
                    ResetPasswordViewController *reset = [self.storyboard instantiateViewControllerWithIdentifier:@"reset"];
                    [self.navigationController pushViewController:reset animated:YES];
                }
                
                
                else
                    
                {
                    
                    NSString *savedClassName = [[NSUserDefaults standardUserDefaults]objectForKey:@"currentViewController"];
                    
                    NSString *controller =[NSString stringWithFormat:@"%@",NSClassFromString(savedClassName)];
                    
                    NSLog(@"leftObj.controller_obj--->%@",controller);
                    
                    UIViewController *obj_forgot;
                    
                    for (UIViewController *obj in self.navigationController.viewControllers.reverseObjectEnumerator)
                    {
                        if ([[NSString stringWithFormat:@"%@",NSStringFromClass([obj class])] isEqualToString:controller])
                        {
                            
                            obj_forgot = (UIViewController *) obj;
                            
                            break;
                        }
                    }
                    
                    [self pushToViewcontrollerNEW:obj_forgot];
                    
                }

            }
            else if([response isEqualToString:@"0"])
            {
                email_txt.text=@"";
                email_txt.placeholder=[result valueForKey:@"message"];
            }
            
        }];
    }
}

-(void)pushToViewcontrollerNEW:(UIViewController *)obj
{
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromBottom;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    
    if (obj==nil)
    {
        [self.navigationController popViewControllerAnimated:NO];
    }
    
    else
    {
        
        [self.navigationController popToViewController:obj animated:NO];
        
    }
    
    
}

@end
