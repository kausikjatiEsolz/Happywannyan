//
//  LoginController.m
//  Happywannyan
//
//  Created by Rahul Singha Roy on 18/05/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import "LoginController.h"
#import "Language_class.h"
#import "leftmenu.h"
#import "SignUpController.h"
#import "Search_ViewController.h"
#import "YXSpritesLoadingView.h"
#import "Search_Cell.h"
#import "ForgotPasswordViewController.h"
#import "FacebookController.h"


@interface LoginController ()
{
    NSDictionary *user_info;
    UIView *loader_view;
}

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    url_obj=[Json_Class new];
    
    //    leftmenu *obj = [leftmenu new];
    //
    //    [obj Leftmenu:self sideMenu:obj];
    
    user_info = [[Language_class new] language];
    
    [self shadow:login_view];
    
    login_view.layer.cornerRadius = 3;
    
    
    email_lbl.text = [user_info valueForKey:@"email"];
    password.text = [user_info valueForKey:@"password"];
    
    loginBtn.clipsToBounds = YES;
    loginBtn.layer.cornerRadius = 15;
    
    [loginBtn setTitle:[user_info valueForKey:@"login"] forState:UIControlStateNormal];
    [forgotpassword_btn setTitle:[user_info valueForKey:@"forgotpassword"] forState:UIControlStateNormal];
    
    login_withfb_lbl.text=[user_info valueForKey:@"login_with_fb"];
    donot_acc_lbl.text=[user_info valueForKey:@"donot_have_account"];
    [signup_btn setTitle:[user_info valueForKey:@"signup_btn"] forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    
    email_text.autocorrectionType = UITextAutocorrectionTypeNo;
    password_text.autocorrectionType=UITextAutocorrectionTypeNo;
    
    
    
    
    email_text.text =@"koushik.sarkar@esolzmail.com";
    password_text.text =@"123456";
    
    
    lower_view.hidden=YES;
    
    
}


-(void)urldata
{
    [email_text resignFirstResponder];
    [password_text resignFirstResponder];
    
    NSString *url_str=[NSString stringWithFormat:@"%@app_login",App_Domain_Url];
    NSString *postdata=[NSString stringWithFormat:@"user_email=%@&password=%@",email_text.text,password_text.text];
    
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
            
           // [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%@",[[result valueForKey:@"info_array"] valueForKey:@"id"]] forKey:@"userid"];
            
            
            
            [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%@",[result valueForKeyPath:@"info_array.id"]] forKey:@"userid"];
            
            [[NSUserDefaults standardUserDefaults]setObject:useinfo forKey:@"userinfo"];
            
            if (![self.loginForm isEqualToString:@"leftmenu"])
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)shadow:(UIView *)subview
{
    subview.layer.masksToBounds = NO;
    subview.layer.shadowOffset = CGSizeMake(0, 0);
    subview.layer.shadowRadius = 1;
    subview.layer.shadowOpacity = 0.5;
    subview.layer.shadowColor = [[UIColor darkGrayColor] CGColor];
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
    
    if (![self.loginForm isEqualToString:@"leftmenu"])
    {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    else
    {
        [self pushToViewcontrollerNEW:nil];
    }
}

- (IBAction)sender:(UIButton *)sender {
    
    SignUpController *obj_sigup;
    
    for (UIViewController *obj in self.navigationController.viewControllers.reverseObjectEnumerator)
    {
        if ([obj isKindOfClass:[SignUpController class]])
        {
            
            obj_sigup = (SignUpController *) obj;
            
            break;
        }
    }
    
    if (obj_sigup==nil)
    {
        SignUpController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"signup"];
        obj.signUpFrom = self.loginForm;
        [self.navigationController pushViewController:obj animated:YES];
    }
    else
    {
        [self.navigationController popToViewController:obj_sigup animated:YES];
    }
    
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

-(BOOL)isValidPassword:(NSString *)checkString{
    NSString *stricterFilterString = @"^(?=.*\\d)(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    return [passwordTest evaluateWithObject:checkString];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)keyboardWillShow:(NSNotification*)notification
{
   // if (self.view.frame.size.height==568) {
     //   login_view.frame=CGRectMake(login_view.frame.origin.x, 91, login_view.frame.size.width, login_view.frame.size.height);
    //}
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    //if (self.view.frame.size.height==568) {
  //      login_view.frame=CGRectMake(login_view.frame.origin.x, 101, login_view.frame.size.width, login_view.frame.size.height);
//    }
}


- (IBAction)loginTap:(UIButton *)sender {
    
    if ([self Emailtest:email_text.text]==true)
    {
        email_text.text=@"";
        email_text.placeholder = @"Please enter Valid Email Id";
    }
    
    else if ([self TarminateWhiteSpace:password_text.text].length<6)
    {
        password_text.text=@"";
        //password_text.placeholder=@"Please Enter Password";
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
    //    else if ([self isValidPassword:password_text.text]==false)
    //    {
    //        password_text.text=@"";
    //
    //        UIAlertController * alert = [UIAlertController
    //                                     alertControllerWithTitle:@"Alert"
    //                                     message:@"Please Enter 5 Digit,Symbol & Alphanumeric Password"
    //                                     preferredStyle:UIAlertControllerStyleAlert];
    //        UIAlertAction* ok_btn = [UIAlertAction
    //                                 actionWithTitle:@"OK"
    //                                 style:UIAlertActionStyleDefault
    //                                 handler:nil];
    //
    //        [alert addAction:ok_btn];
    //
    //        [self presentViewController:alert animated:YES completion:nil];
    //
    //    }
    
    else
    {
        [self urldata];
        
    }
    
}

- (IBAction)fblogin:(UIButton *)sender {
    
    
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
          
                if (![self.loginForm isEqualToString:@"leftmenu"])
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
- (IBAction)forgot_password:(id)sender {
    
    ForgotPasswordViewController *forgot = [self.storyboard instantiateViewControllerWithIdentifier:@"forgot"];
    
    [self.navigationController pushViewController:forgot animated:YES];
    
}


@end
