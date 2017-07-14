//
//  ProfileController.m
//  Happywannyan
//
//  Created by Kausik_Jati on 10/07/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import "ProfileController.h"
#import "leftmenu.h"
#import "UIImageView+WebCache.h"
#import <GooglePlaces/GooglePlaces.h>
#import <CoreLocation/CoreLocation.h>

@interface ProfileController ()
{
    leftmenu *leftMenu_obj;
    Json_Class *url_obj;
    NSMutableDictionary *latlong_data,*api_dict;
    NSData *imageData;
    
}
@end

@implementation ProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    url_obj=[Json_Class new];
    
    latlong_data=[NSMutableDictionary new];
    api_dict=[NSMutableDictionary new];
    leftMenu_obj=[[leftmenu alloc]init];
    [leftMenu_obj Leftmenu:self sideMenu:leftMenu_obj];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
     
                                               object:nil];
    
    
    
    profile_img.layer.cornerRadius=profile_img.frame.size.width/2;
    profile_img.clipsToBounds=YES;
    
    
    savebtn_lbl.frame=CGRectMake(save_btn.frame.origin.x+save_btn.frame.size.width/8, save_btn.frame.origin.y+9, savebtn_lbl.frame.size.width, savebtn_lbl.frame.size.height);
    
    profile_scroll.contentSize=CGSizeMake(0, profile_scroll.frame.origin.y+profile_scroll.frame.size.height+50);
    
    
    firstname_textfield1.autocorrectionType=UITextAutocorrectionTypeNo;
    lastname_textfield1.autocorrectionType=UITextAutocorrectionTypeNo;
    firstname_textfield2.autocorrectionType=UITextAutocorrectionTypeNo;
    lastname_textfield2.autocorrectionType=UITextAutocorrectionTypeNo;
    
    
    [self urlData];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)keyboardWillShow:(NSNotification*)notification
{
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    profile_scroll.contentSize=CGSizeMake(0,profile_scroll.frame.origin.y+profile_scroll.frame.size.height+kbSize.height+50);
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    profile_scroll.contentSize = CGSizeMake(0,profile_scroll.frame.origin.y+profile_scroll.frame.size.height-kbSize.height);
    currentKeyboardHeight = 0.0f;
    
    profile_scroll.contentSize = CGSizeMake(0,profile_scroll.frame.origin.y+profile_scroll.frame.size.height+50);
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    keyboardToolbar.barStyle = UIBarStyleDefault;
    
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                      target:self action:@selector(TextViewDoneButtonPressed)];
    keyboardToolbar.items = @[doneBarButton];
    phoneno_textfield.inputAccessoryView = keyboardToolbar;
    return YES;
}

-(void)TextViewDoneButtonPressed
{
    [phoneno_textfield resignFirstResponder];
}

-(void)urlData
{
    NSString *url_str=[NSString stringWithFormat:@"%@app_users_about?user_id=%@&lang_id=%@",App_Domain_Url,[[NSUserDefaults standardUserDefaults]valueForKey:@"userid"],[[NSUserDefaults standardUserDefaults]valueForKey:@"lan_code"]];
    NSString *urlUTF8=[url_str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
    
    [request setURL:[NSURL URLWithString:urlUTF8]];
    
    [url_obj GlobalDict:request Globalstr:@"array" lodaer:YES Withblock:^(id result, NSError *error) {
        
        NSLog(@"%@",result);
        NSString *response = [NSString stringWithFormat:@"%@",[result valueForKey:@"response"]];
        
        if ([response isEqualToString:@"1"])
        {
            
            api_dict=[result valueForKey:@"users_information"];
            
            firstname_textfield1.text=[api_dict valueForKeyPath:@"firstname"];
            
            lastname_textfield1.text=[api_dict valueForKeyPath:@"lastname"];
            
            firstname_textfield2.text=[api_dict valueForKeyPath:@"firstname_phonetic"];
            
            lastname_textfield2.text=[api_dict valueForKeyPath:@"lastname_phonetic"];
            
            [address_btn setTitle: [api_dict valueForKeyPath:@"address"] forState:UIControlStateNormal];
            
            phonenocode_lbl.text=[api_dict valueForKeyPath:@"phone_code"];
            
            phoneno_textfield.text=[api_dict valueForKeyPath:@"mobilenum"];
            //            [profile_img sd_setImageWithURL:[NSURL URLWithString:[result valueForKeyPath:@"users_information.photo"]]placeholderImage:[UIImage imageNamed:@"new-user-image-default"]];
            
            [profile_img sd_setImageWithURL:[NSURL URLWithString:[api_dict valueForKeyPath:@"photo"]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
                
                if (!error)
                {
                    imageData = UIImagePNGRepresentation(image);
                }
                
                
            }];
            
            
        }
    }];
    
    
    
    
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

- (IBAction)termscheckbtn_tap:(id)sender {
    
    if ([[termscheck_btn imageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"check-box-empty"]]) {
        [termscheck_btn setImage:[UIImage imageNamed:@"check-box-color"] forState:UIControlStateNormal];
    }
    else{
        [termscheck_btn setImage:[UIImage imageNamed:@"check-box-empty"] forState:UIControlStateNormal];
    }
    
}

- (IBAction)leftmenu_tap:(id)sender {
    
    [leftMenu_obj lefMenuopen:sender];
}

- (IBAction)savebtn_tap:(id)sender {
    
    
    
    
    
    
    //NSLog(@"%@",api_dict);
    
   
    
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    
    for (NSString *key in api_dict)
    {
        if ([key isEqualToString:@"address"])
        {
            [dic setValue:address_btn.titleLabel.text forKey:key];
        }
        else if([key isEqualToString:@"mobilenum"])
        {
            [dic setValue:phoneno_textfield.text forKey:key];
        }
        else if([key isEqualToString:@"lastname_phonetic"])
        {
            [dic setValue:lastname_textfield2.text forKey:key];
        }
        else if([key isEqualToString:@"firstname_phonetic"])
        {
            [dic setValue:firstname_textfield2.text forKey:key];
        }
        else if([key isEqualToString:@"lastname"])
        {
            [dic setValue:lastname_textfield1.text forKey:key];
        }
        else if([key isEqualToString:@"firstname"])
        {
            [dic setValue:firstname_textfield1.text forKey:key];
        }
        else if([key isEqualToString:@"lat_addr"])
        {
            if (latlong_data.count>0)
            {
                [dic setValue:[latlong_data valueForKey:@"lat"] forKey:key];
            }
            else
            {
                [dic setValue:[api_dict valueForKey:key] forKey:key];
            }
            
        }
        else if([key isEqualToString:@"long_addr"])
        {
            if (latlong_data.count>0)
            {
                [dic setValue:[latlong_data valueForKey:@"long"] forKey:key];
            }
            else
            {
                [dic setValue:[api_dict valueForKey:key] forKey:key];
            }
        }
        else
        {
            [dic setValue:[api_dict valueForKey:key] forKey:key];
        }
    }
    
    
     NSDictionary *paramiter = [[NSDictionary alloc]initWithObjectsAndKeys:dic,@"users_information",nil];
    
    
     NSDictionary *paramitter_send = [[NSDictionary alloc]initWithObjectsAndKeys:[self jsonEncode:paramiter],@"user_info",[[NSUserDefaults standardUserDefaults]valueForKey:@"userid"],@"user_id",[[NSUserDefaults standardUserDefaults]valueForKey:@"lan_code"],@"langid",nil];
    
    
    

    
    
    NSLog(@"dic--->%@",paramiter);
    
    
    [url_obj post_dataWithImage:[NSString stringWithFormat:@"%@app_users_edit?",App_Domain_Url] Post_data:paramitter_send image:imageData paramNameForImage:@"photo" Withblock:^(id result, NSError *error) {
        
        NSLog(@"result--->%@",result);
        
    }];
    
    
    
}
-(NSString *)jsonEncode:(NSDictionary *)array
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    //jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return jsonString;
}

- (IBAction)photoupload_tap:(id)sender {
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:nil
                                message:nil
                                preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* button0 = [UIAlertAction
                              actionWithTitle:@"Cancel"
                              style:UIAlertActionStyleCancel
                              handler:^(UIAlertAction * action)
                              {
                              }];
    
    UIAlertAction* button1 = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //  The user tapped on "Camera"
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.delegate = self;
        
        picker.allowsEditing = YES;
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:^{}];
        
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction* button2 = [UIAlertAction actionWithTitle:@"Gallary" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //  The user tapped on "Upload"
        UIImagePickerController *pickerView = [[UIImagePickerController alloc] init];
        
        pickerView.allowsEditing = YES;
        
        pickerView.delegate = self;
        
        [pickerView setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        
        [self presentViewController:pickerView animated:YES completion:^{}];
        
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:button0];
    [alert addAction:button1];
    [alert addAction:button2];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    imageData = UIImagePNGRepresentation(chosenImage);
    profile_img.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (IBAction)addressbtn_tap:(id)sender {
    
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    GMSAutocompleteFilter *filter = [[GMSAutocompleteFilter alloc] init];
    filter.country = @"JP";
    
    acController.autocompleteFilter = filter;
    
    [self presentViewController:acController animated:YES completion:nil];
    
    
}

- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    
    [latlong_data setObject:place.formattedAddress forKey:@"formatted_address"];
    [latlong_data setObject:[NSString stringWithFormat:@"%f",place.coordinate.latitude] forKey:@"lat"];
    [latlong_data setObject:[NSString stringWithFormat:@"%f",place.coordinate.longitude] forKey:@"long"];
    [latlong_data setObject:[NSString stringWithFormat:@"%f",place.viewport.northEast.latitude] forKey:@"ne_lat"];
    [latlong_data setObject:[NSString stringWithFormat:@"%f",place.viewport.northEast.longitude] forKey:@"ne_lng"];
    [latlong_data setObject:[NSString stringWithFormat:@"%f",place.viewport.southWest.latitude] forKey:@"sw_lat"];
    [latlong_data setObject:[NSString stringWithFormat:@"%f",place.viewport.southWest.longitude] forKey:@"sw_lng"];
    
    
    
    NSLog(@"la--->%@",latlong_data);
    
    [address_btn setTitle:place.name forState:UIControlStateNormal];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}



- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}

- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}



- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
