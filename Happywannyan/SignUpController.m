//
//  SignUpController.m
//  Happywannyan
//
//  Created by Rahul Singha Roy on 22/05/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import "SignUpController.h"
#import "Language_class.h"
#import "LoginController.h"
#import "FacebookController.h"
#import "Search_ViewController.h"
#import "Json_Class.h"
#import "YXSpritesLoadingView.h"

@interface SignUpController ()<UITextFieldDelegate>
{
    NSDictionary *user_info;
    
    Json_Class *url_obj;
    
    
    ///demo test
    
}

@end

@implementation SignUpController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    user_info = [[Language_class new] language];
    

    
    url_obj = [Json_Class new];
    
    yourEmail.text = [user_info valueForKey:@"youremail"];
    yourpassword.text = [user_info valueForKey:@"yourpassword"];
    
    tearms_lbl.text = [user_info valueForKey:@"signupterm"];
    
    
    tearms_lbl.hidden=YES;
    
   // [signupBtn setTitle:[user_info valueForKey:@"signup"] forState:UIControlStateNormal];
    
    signup_lbl.text=[user_info valueForKey:@"signup"];
    
    signupwithfb.text = [user_info valueForKey:@"signupwithfb"];
    loginpage.text = [user_info valueForKey:@"loginpage"];
    [login setTitle:[user_info valueForKey:@"login_now"] forState:UIControlStateNormal];
    
    signup_lbl.frame=CGRectMake(signupBtn.frame.origin.x+signupBtn.frame.size.width/8, signupBtn.frame.origin.y+10, signup_lbl.frame.size.width, signup_lbl.frame.size.height);
    
    
    
//    signupBtn.clipsToBounds = YES;
//    signupBtn.layer.cornerRadius = 15;
    
    [self shadow:signUpview];
    
    signUpview.layer.cornerRadius = 3;
    
    
    [login setTitle:[user_info valueForKey:@"loginnow"] forState:UIControlStateNormal];
    
    passwordtext.delegate = self;
    
    lower_view.hidden=YES;

    //////////demo
    
    
}

-(void)shadow:(UIView *)subview
{
    subview.layer.masksToBounds = NO;
    subview.layer.shadowOffset = CGSizeMake(0, 0);
    subview.layer.shadowRadius = 1;
    subview.layer.shadowOpacity = 0.5;
    subview.layer.shadowColor = [[UIColor darkGrayColor] CGColor];
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

- (IBAction)login_page:(UIButton *)sender {
    
    
    LoginController  *obj_sigup;
    
    for (UIViewController *obj in self.navigationController.viewControllers.reverseObjectEnumerator)
    {
        if ([obj isKindOfClass:[LoginController class]])
        {
            
            obj_sigup = (LoginController *) obj;
            
            break;
        }
    }
    
    if (obj_sigup==nil)
    { 
        LoginController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
        [self.navigationController pushViewController:obj animated:YES];
    }
    else
    {
        [self.navigationController popToViewController:obj_sigup animated:YES];
    }
    
}

- (IBAction)back:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)fbsignup:(UIButton *)sender {
    
     
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
                    
                    if (![self.signUpFrom isEqualToString:@"leftmenu"])
                    {
                        
                        Search_ViewController *search = [self.storyboard instantiateViewControllerWithIdentifier:@"search"];
                        
                        [self.navigationController pushViewController:search animated:YES];
                        
                    }
                    
                    
                    else
                        
                    {
                        
                        NSString *savedClassName = [[NSUserDefaults standardUserDefaults]objectForKey:@"currentViewController"];
                        
                        NSString *controller =[NSString stringWithFormat:@"%@",NSClassFromString(savedClassName)];
                        
                        NSLog(@"leftObj.controller_obj--->%@",controller);
                        
                        UIViewController *obj_sigup;
                        
                        for (UIViewController *obj in self.navigationController.viewControllers.reverseObjectEnumerator)
                        {
                            if ([[NSString stringWithFormat:@"%@",NSStringFromClass([obj class])] isEqualToString:controller])
                            {
                                
                                obj_sigup = (UIViewController *) obj;
                                
                                break;
                            }
                        }
                        
                        
                        //[self.navigationController popToViewController:obj_sigup animated:YES];
                        
                        [self pushToViewcontrollerNEW:obj_sigup];
                        
                    }

                    
                    
                }
                
            }];
            
            
            
            
            
        } failureHandler:^(NSDictionary *errorDetail) {
            
            
            
            
            
            
        }];
     
    
}
- (IBAction)signupTap:(UIButton *)sender {
    
    
    
    
    if ([self Emailtest:emailtext.text]==true)
    {
        emailtext.text=@"";
        emailtext.placeholder = @"Please enter Valid Email Id";
    }
    
    else if ([self TarminateWhiteSpace:passwordtext.text].length<6)
    {
        passwordtext.text=@"";
        //passwordtext.placeholder=@"Please Enter 5 Digit Alphanumeric Password";
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Alert"
                                     message:@"Please Enter 6 Digit,Symbol & Alphanumeric Password"
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok_btn = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:nil];
        
        [alert addAction:ok_btn];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if ([self isValidPassword:passwordtext.text]==false)
    {
        passwordtext.text=@"";
        //passwordtext.placeholder=@"Please Enter 5 Digit Alphanumeric Password";
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Alert"
                                     message:@"Please Enter 6 Digit,Symbol & Alphanumeric Password"
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok_btn = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:nil];
        
        [alert addAction:ok_btn];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    else
    {
        //int numberofCharacters = 0;
        
        [self signUP];
        
    }
    
    
    
    
    
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField==passwordtext)
    {
        
        
        NSLog(@"%@", [self isValidPassword:textField.text] ? @"YES" : @"NO");
        
        
    }
    
    
}


-(BOOL)isValidPassword:(NSString *)checkString{
    NSString *stricterFilterString = @"^(?=.*\\d)(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    return [passwordTest evaluateWithObject:checkString];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}


-(void)signUP
{
    [emailtext resignFirstResponder];
    [passwordtext resignFirstResponder];
    
    NSString *url_str=[NSString stringWithFormat:@"%@app_regirsation",App_Domain_Url];
    NSString *postdata=[NSString stringWithFormat:@"user_email=%@&password=%@&langid=%@",emailtext.text,passwordtext.text,[[NSUserDefaults standardUserDefaults] valueForKey:@"lan_code"]];
    
    postdata=[postdata stringByRemovingPercentEncoding];
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
    
    [request setURL:[NSURL URLWithString:url_str]];
    
    [request setHTTPMethod:@"POST"];
    
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:[postdata dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [url_obj GlobalDict:request Globalstr:@"array" lodaer:YES Withblock:^(id result, NSError *error) {
        
        
        NSString *response = [NSString stringWithFormat:@"%@",[result valueForKey:@"response"]];
        
        if ([response isEqualToString:@"1"])
        {
//            NSDictionary *useinfo = [result valueForKey:@"info_array"];
//            
//            [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%@",[[result valueForKey:@"info_array"] valueForKey:@"id"]] forKey:@"userid"];
//            [[NSUserDefaults standardUserDefaults]setObject:useinfo forKey:@"userinfo"];
            
            
            [self LogIn];
        }
        else
        {
            
            
            [YXSpritesLoadingView errorInfo:[result valueForKey:@"message"]];
            
        }
        
        
        
        
        
        
        
    }];
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

-(void)LogIn
{
    
    
    NSString *url_str=[NSString stringWithFormat:@"%@app_login",App_Domain_Url];
    NSString *postdata=[NSString stringWithFormat:@"user_email=%@&password=%@",emailtext.text,passwordtext.text];
    
    postdata=[postdata stringByRemovingPercentEncoding];
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
    
    [request setURL:[NSURL URLWithString:url_str]];
    
    [request setHTTPMethod:@"POST"];
    
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:[postdata dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [url_obj GlobalDict:request Globalstr:@"array" lodaer:YES Withblock:^(id result, NSError *error) {
        
        
        
        
        NSString *response = [NSString stringWithFormat:@"%@",[result valueForKey:@"response"]];
        
        if ([response isEqualToString:@"1"])
        {
            NSDictionary *useinfo = [result valueForKey:@"info_array"];
            
            [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%@",[[result valueForKey:@"info_array"] valueForKey:@"id"]] forKey:@"userid"];
            [[NSUserDefaults standardUserDefaults]setObject:useinfo forKey:@"userinfo"];
            
            
            if (![self.signUpFrom isEqualToString:@"leftmenu"])
            {
                
                Search_ViewController *search = [self.storyboard instantiateViewControllerWithIdentifier:@"search"];
                
                [self.navigationController pushViewController:search animated:YES];
                
            }
            
            
            else
                
            {
                
                NSString *savedClassName = [[NSUserDefaults standardUserDefaults]objectForKey:@"currentViewController"];
                
                NSString *controller =[NSString stringWithFormat:@"%@",NSClassFromString(savedClassName)];
                
                NSLog(@"leftObj.controller_obj--->%@",controller);
                
                UIViewController *obj_sigup;
                
                for (UIViewController *obj in self.navigationController.viewControllers.reverseObjectEnumerator)
                {
                    if ([[NSString stringWithFormat:@"%@",NSStringFromClass([obj class])] isEqualToString:controller])
                    {
                        
                        obj_sigup = (UIViewController *) obj;
                        
                        break;
                    }
                }
                
                
                //[self.navigationController popToViewController:obj_sigup animated:YES];
                
                [self pushToViewcontrollerNEW:obj_sigup];
                
            }
        }
        
        
        
        
        
        
        
    }];
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

-(NSString *)TarminateWhiteSpace:(NSString *)Str
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [Str stringByTrimmingCharactersInSet:whitespace];
    return trimmed;
}


@end
