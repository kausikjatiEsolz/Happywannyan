//
//  ResetPasswordViewController.m
//  Happywannyan
//
//  Created by Kausik_Jati on 01/06/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "LoginController.h"
@interface ResetPasswordViewController ()

@end

@implementation ResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    url_obj=[Json_Class new];
    submit_btn.clipsToBounds = YES;
    
    //submit_btn.layer.cornerRadius = 20;
    
    [self shadow:reset_view];
    
    reset_view.layer.cornerRadius = 3;
    
        submitbtn_lbl.frame=CGRectMake(submit_btn.frame.origin.x+submit_btn.frame.size.width/8, submit_btn.frame.origin.y+10, submitbtn_lbl.frame.size.width, submitbtn_lbl.frame.size.height);
    
    
}

-(void)shadow:(UIView *)subview
{
    subview.layer.masksToBounds = NO;
    subview.layer.shadowOffset = CGSizeMake(0, 0);
    subview.layer.shadowRadius = 1;
    subview.layer.shadowOpacity = 0.5;
    subview.layer.shadowColor = [[UIColor darkGrayColor] CGColor];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

-(BOOL)isValidPassword:(NSString *)checkString{
    NSString *stricterFilterString = @"^(?=.*\\d)(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    return [passwordTest evaluateWithObject:checkString];
}

-(NSString *)TarminateWhiteSpace:(NSString *)Str
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [Str stringByTrimmingCharactersInSet:whitespace];
    return trimmed;
}


-(void)urldata
{
    {
        
        
        NSString *url_str=[NSString stringWithFormat:@"%@resetpassword",App_Domain_Url];
        NSString *postdata=[NSString stringWithFormat:@"cur_code=%@&new_pass=%@",verification_txt.text,newpassword_txt.text];
        
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
                
                
                if (![self.resetform isEqualToString:@"leftmenu"])
                {
                    
                    LoginController *login = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
                    [self.navigationController pushViewController:login animated:YES];
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
                verification_txt.text=@"";
                verification_txt.placeholder=[result valueForKey:@"message"];
                newpassword_txt.text=@"";
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

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submit_tap:(id)sender {
    
    if ([self TarminateWhiteSpace:verification_txt.text].length==0)
    {
        verification_txt.text=@"";
        verification_txt.placeholder = @"Please enter Verifacation Code";
    }
    
    else if ([self TarminateWhiteSpace:newpassword_txt.text].length<6)
    {
        newpassword_txt.text=@"";
        //newpassword_txt.placeholder=@"Please Enter 5 Digit Alphanumeric Password";
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
    else if ([self isValidPassword:newpassword_txt.text]==false)
    {
        newpassword_txt.text=@"";
        //newpassword_txt.placeholder=@"Please Enter 5 Digit Alphanumeric Password";
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
        [self urldata];
    }
    
}
@end
