//
//  AddAnotherPetViewController.m
//  Happywannyan
//
//  Created by Kausik_Jati on 27/05/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import "AddAnotherPetViewController.h"
#import "Json_Class.h"
#import "YXSpritesLoadingView.h"
#import "UIImageView+WebCache.h"

@interface AddAnotherPetViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    Json_Class *url_obj;
    
    NSMutableDictionary  *selected_data;
    
    NSData *imageData;
    
    NSArray *allpetdetails_ary,*petdetails_ary,*year_ary,*month_ary,*gendar_ary,*petsize_ary,*breed_ary,*pettype_ary,*pet1dog_ary,*pet1cat_ary,*pet2_ary,*pet2cat_ary,*pet2dog_ary;
    
    
    NSMutableArray *textfield_array,*textview_array,*select_array,*radio_array;
    
    
}

@end

@implementation AddAnotherPetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    save_btn.hidden=YES;
    
    selected_data = [NSMutableDictionary new];
    
    selection_ary=[[NSMutableArray alloc]init];
    
    savebtn_lbl.frame=CGRectMake(save_btn.frame.origin.x+save_btn.frame.size.width/8, save_btn.frame.origin.y+10, savebtn_lbl.frame.size.width, savebtn_lbl.frame.size.height);
    

    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
     
                                               object:nil];
    
    
    
    url_obj = [Json_Class new];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@parent_service",App_Domain_Url]];
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
    
    [request setURL:url];
    
    [url_obj GlobalDict:request Globalstr:@"array" lodaer:YES Withblock:^(id result, NSError *error) {
        
        
        allpetdetails_ary=[result valueForKey:@"allPetDetails"];

        
    }];
    
    
    
    if (self.edit.length>0)
    {
        
        choosepettype_btn.userInteractionEnabled = NO;
        choosepettype_lbl.text = self.edit;
        
        [self createView:self.data];
        
        save_btn.hidden = NO;
        
        
        
        
        
        
        
    }
    
}



- (IBAction)choosepettype:(id)sender {
    
    UIAlertController *departureActnSht = [UIAlertController alertControllerWithTitle:@"Choose Pet Type"message:nil  preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    
    for (int j =0 ; j<allpetdetails_ary.count; j++)
    {
        NSString *titleString = [ allpetdetails_ary[j] valueForKey:@"name"];
        UIAlertAction *action = [UIAlertAction actionWithTitle:titleString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            NSLog(@"%@", allpetdetails_ary[j]);
            choosepettype_lbl.text=[allpetdetails_ary[j] valueForKey:@"name"];
            
            [self urlData:[ allpetdetails_ary[j] valueForKey:@"id"]];
            
           
//            pettype_str=[ allpetdetails_ary[j] valueForKey:@"id"];
//            NSLog(@"......................%@",pettype_str);
           
        }];
        
        [departureActnSht addAction:action];
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [departureActnSht addAction:cancelAction];
    [self presentViewController:departureActnSht animated:YES completion:nil];
    
}

- (IBAction)year:(id)sender{
    
    UIAlertController *departureActnSht = [UIAlertController alertControllerWithTitle:@"Choose Year"message:nil  preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (int j =0 ; j<[[year_ary  valueForKey:@"input_option"] count]; j++)
    {
        NSString *titleString = [[[year_ary valueForKey:@"input_option"] objectAtIndex:j] valueForKey:@"option_name"];
        UIAlertAction *action = [UIAlertAction actionWithTitle:titleString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            [self setData:year_ary sender:sender index:j];
            
            //=[allpetdetails_ary[j] valueForKey:@"option_name"];
            // [self urlData:[ allpetdetails_ary[j] valueForKey:@"id"]];
            
        }];
        
        [departureActnSht addAction:action];
    }
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [departureActnSht addAction:cancelAction];
    [self presentViewController:departureActnSht animated:YES completion:nil];
    
}

- (IBAction)month:(id)sender {
    
    UIAlertController *departureActnSht = [UIAlertController alertControllerWithTitle:@"Choose Month"message:nil  preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (int j =0 ; j<[[month_ary  valueForKey:@"input_option"] count]; j++)
    {
        NSString *titleString = [[[month_ary  valueForKey:@"input_option"] objectAtIndex:j] valueForKey:@"option_name"];
        UIAlertAction *action = [UIAlertAction actionWithTitle:titleString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            [self setData:month_ary sender:sender index:j];
            
            //=[allpetdetails_ary[j] valueForKey:@"option_name"];
            // [self urlData:[ allpetdetails_ary[j] valueForKey:@"id"]];
            
        }];
        
        [departureActnSht addAction:action];
    }
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [departureActnSht addAction:cancelAction];
    [self presentViewController:departureActnSht animated:YES completion:nil];
    
}

- (IBAction)gendar:(id)sender {
    
    UIAlertController *departureActnSht = [UIAlertController alertControllerWithTitle:@"Choose Gendar"message:nil  preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    
    for (int j =0 ; j<[[gendar_ary  valueForKey:@"input_option"] count]; j++)
    {
        
        
        NSString *titleString = [[[gendar_ary  valueForKey:@"input_option"] objectAtIndex:j] valueForKey:@"option_name"];
        UIAlertAction *action = [UIAlertAction actionWithTitle:titleString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            
            
            [self setData:gendar_ary sender:sender index:j];
            
            //=[allpetdetails_ary[j] valueForKey:@"option_name"];
            // [self urlData:[ allpetdetails_ary[j] valueForKey:@"id"]];
            
            
            
            
        }];
        
        [departureActnSht addAction:action];
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [departureActnSht addAction:cancelAction];
    [self presentViewController:departureActnSht animated:YES completion:nil];
    
}


-(void)setData:(NSArray *)array sender:(id)sender index:(int)index
{
    UIButton *btn = (UIButton *)sender;
    
    for (UILabel *lbl_name in scrollview_view.subviews)
    {
        if ([lbl_name isKindOfClass:[UILabel class]])
        {
            if (lbl_name.frame.origin.y+lbl_name.frame.origin.x  == btn.frame.origin.y+btn.frame.origin.x)
            {
                lbl_name.text = [[[array valueForKey:@"input_option"] objectAtIndex:index] valueForKey:@"option_name"];
                
                
                
                
                [selected_data setObject:[[array  valueForKey:@"input_option"] objectAtIndex:index] forKey:[NSString stringWithFormat:@"%@-%@",[array valueForKey:@"input_name"],[array valueForKey:@"input_type"]]];
                
                
                NSLog(@"seleted--->%@",selected_data);
                
                break;
            }
            
            
            
        }
    }
    
    
    
    
}



-(void)editDataSet:(NSString *)key array:(NSArray *)data_array
{
    for (int i=0; i<data_array.count; i++)
    {
        
        
        if ([[[data_array objectAtIndex:i] valueForKey:@"option_status"] intValue]==1)
        {
            
            
            [selected_data setObject:[data_array objectAtIndex:i] forKey:key];
            
            
            break;
        }
        
        
        
        
    }
}



- (IBAction)petsize:(id)sender {
    
    UIAlertController *departureActnSht = [UIAlertController alertControllerWithTitle:@"Choose Pet Size"message:nil  preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (int j =0 ; j<[[petsize_ary  valueForKey:@"input_option"] count]; j++)
    {
        NSString *titleString = [[[petsize_ary  valueForKey:@"input_option"] objectAtIndex:j] valueForKey:@"option_name"];
        UIAlertAction *action = [UIAlertAction actionWithTitle:titleString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            [self setData:petsize_ary sender:sender index:j];

            
            //=[allpetdetails_ary[j] valueForKey:@"option_name"];
            // [self urlData:[ allpetdetails_ary[j] valueForKey:@"id"]];
            
        }];
        
        [departureActnSht addAction:action];
    }

    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [departureActnSht addAction:cancelAction];
    [self presentViewController:departureActnSht animated:YES completion:nil];
    
}

- (IBAction)breed:(id)sender {
    
    UIAlertController *departureActnSht = [UIAlertController alertControllerWithTitle:@"Choose breed"message:nil  preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (int j =0 ; j<[[breed_ary  valueForKey:@"input_option"] count]; j++)
    {
        NSString *titleString = [[[breed_ary  valueForKey:@"input_option"] objectAtIndex:j] valueForKey:@"option_name"];
        UIAlertAction *action = [UIAlertAction actionWithTitle:titleString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
             [self setData:breed_ary sender:sender index:j];
            
            
        }];
        
        [departureActnSht addAction:action];
    }

    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [departureActnSht addAction:cancelAction];
    [self presentViewController:departureActnSht animated:YES completion:nil];
    
}

- (IBAction)pet1dog:(id)sender {
    
    UIAlertController *departureActnSht = [UIAlertController alertControllerWithTitle:@"Choose"message:nil  preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (int j =0 ; j<[[pet1dog_ary  valueForKey:@"input_option"] count]; j++)
    {
        NSString *titleString = [[[pet1dog_ary  valueForKey:@"input_option"] objectAtIndex:j] valueForKey:@"option_name"];
        UIAlertAction *action = [UIAlertAction actionWithTitle:titleString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            [self setData:pet1dog_ary sender:sender index:j];

            
        }];
        
        [departureActnSht addAction:action];
    }
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [departureActnSht addAction:cancelAction];
    [self presentViewController:departureActnSht animated:YES completion:nil];
    
}


- (IBAction)pet1cat:(id)sender {
    
    UIAlertController *departureActnSht = [UIAlertController alertControllerWithTitle:@"Choose"message:nil  preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (int j =0 ; j<[[pet1cat_ary  valueForKey:@"input_option"] count]; j++)
    {
        NSString *titleString = [[[pet1cat_ary  valueForKey:@"input_option"] objectAtIndex:j] valueForKey:@"option_name"];
        UIAlertAction *action = [UIAlertAction actionWithTitle:titleString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            [self setData:pet1cat_ary sender:sender index:j];
            
            
        }];
        
        [departureActnSht addAction:action];
    }
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [departureActnSht addAction:cancelAction];
    [self presentViewController:departureActnSht animated:YES completion:nil];
    
}

- (IBAction)pet2:(id)sender {
    
    UIAlertController *departureActnSht = [UIAlertController alertControllerWithTitle:@"Choose"message:nil  preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (int j =0 ; j<[[pet2_ary  valueForKey:@"input_option"] count]; j++)
    {
        NSString *titleString = [[[pet2_ary  valueForKey:@"input_option"] objectAtIndex:j] valueForKey:@"option_name"];
        UIAlertAction *action = [UIAlertAction actionWithTitle:titleString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            [self setData:pet2_ary sender:sender index:j];
            
            
        }];
        
        [departureActnSht addAction:action];
    }

    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [departureActnSht addAction:cancelAction];
    [self presentViewController:departureActnSht animated:YES completion:nil];
    
}

- (IBAction)pet2cat:(id)sender {
    
    UIAlertController *departureActnSht = [UIAlertController alertControllerWithTitle:@"Choose"message:nil  preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (int j =0 ; j<[[pet2cat_ary  valueForKey:@"input_option"] count]; j++)
    {
        NSString *titleString = [[[pet2cat_ary  valueForKey:@"input_option"] objectAtIndex:j] valueForKey:@"option_name"];
        UIAlertAction *action = [UIAlertAction actionWithTitle:titleString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            [self setData:pet2cat_ary sender:sender index:j];
            
            
        }];
        
        [departureActnSht addAction:action];
    }
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [departureActnSht addAction:cancelAction];
    [self presentViewController:departureActnSht animated:YES completion:nil];
    
}

- (IBAction)pet2dog:(id)sender {
    
    UIAlertController *departureActnSht = [UIAlertController alertControllerWithTitle:@"Choose"message:nil  preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (int j =0 ; j<[[pet2dog_ary  valueForKey:@"input_option"] count]; j++)
    {
        NSString *titleString = [[[pet2dog_ary  valueForKey:@"input_option"] objectAtIndex:j] valueForKey:@"option_name"];
        UIAlertAction *action = [UIAlertAction actionWithTitle:titleString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            [self setData:pet2dog_ary sender:sender index:j];
            
            
        }];
        
        [departureActnSht addAction:action];
    }
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [departureActnSht addAction:cancelAction];
    [self presentViewController:departureActnSht animated:YES completion:nil];
    
}


- (IBAction)othertype:(id)sender {
    
    UIAlertController *departureActnSht = [UIAlertController alertControllerWithTitle:@"Choose"message:nil  preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (int j =0 ; j<[[pettype_ary  valueForKey:@"input_option"] count]; j++)
    {
        NSString *titleString = [[[pettype_ary  valueForKey:@"input_option"] objectAtIndex:j] valueForKey:@"option_name"];
        UIAlertAction *action = [UIAlertAction actionWithTitle:titleString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            [self setData:pettype_ary sender:sender index:j];
            
            
        }];
        
        [departureActnSht addAction:action];
    }
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [departureActnSht addAction:cancelAction];
    [self presentViewController:departureActnSht animated:YES completion:nil];
    
}


- (IBAction)profilebtn_tap:(id)sender {
    
    {
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
    
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
//    _profile_pic.image = chosenImage;
    
    imageData = UIImagePNGRepresentation(chosenImage);
    
    for (UIImageView *img in scrollview_view.subviews)
    {
        if ([img isKindOfClass:[UIImageView class]])
        {
            if (img.frame.origin.x== self.view.frame.size.width/2-50) {
                
                
                
                img.image=chosenImage;
                break;
            }
            
            
            
        }
    }
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



- (void)keyboardWillShow:(NSNotification*)notification
{
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    addanotherpet_scroll.contentSize=CGSizeMake(0,addanotherpet_scroll.frame.origin.y+addanotherpet_scroll.frame.size.height+kbSize.height+300);
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    addanotherpet_scroll.contentSize = CGSizeMake(0,addanotherpet_scroll.frame.origin.y+addanotherpet_scroll.frame.size.height-kbSize.height);
    currentKeyboardHeight = 0.0f;
    
    addanotherpet_scroll.contentSize = CGSizeMake(0,addanotherpet_scroll.frame.origin.y+addanotherpet_scroll.frame.size.height+300);

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(void)urlData:(NSString *)pet_id
{
        
        NSString *url_str=[NSString stringWithFormat:@"%@app_users_petinfo?user_id=116&lang_id=en&pet_type_id=%@",App_Domain_Url,pet_id];
        NSString *urlUTF8=[url_str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
        
        [request setURL:[NSURL URLWithString:urlUTF8]];
        
        [url_obj GlobalDict:request Globalstr:@"array" lodaer:YES Withblock:^(id result, NSError *error) {
            
            NSLog(@"%@",result);
            
            NSString *response=[NSString stringWithFormat:@"%@",[result valueForKey:@"response"]];
            
            if ([response isEqualToString:@"1"])
            {
                [self createView:[result valueForKey:@"info_array"]];
            }
        }];
    
}


-(void)createView:(NSArray *)array_data
{
    
    
    petdetails_ary=array_data;
    
    for (UIView *view in [scrollview_view subviews])
    {
        [view removeFromSuperview];
    }
    
    
    UIImageView *profileimage=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-50, 20, 100, 100)];
    
    profileimage.image=[UIImage imageNamed:@"dog-placeholder"];
    
    profileimage.layer.cornerRadius=10.0f;
    profileimage.clipsToBounds=YES;
    
    if (_edit.length>0)
    {
        [profileimage sd_setImageWithURL:[NSURL URLWithString:self.imageLink] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            
            if (!error)
            {
                imageData = UIImagePNGRepresentation(image);
            }
            
            
        }];
    }
    
   
    
    
    
    [scrollview_view addSubview:profileimage];
    
    UIButton *profile_btn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-50, 20, 100, 100)];
    
    [profile_btn addTarget:self action:@selector(profilebtn_tap:) forControlEvents:UIControlEventTouchUpInside];
    
    [scrollview_view addSubview:profile_btn];
    
    NSArray *array = [[petdetails_ary valueForKey:@"other_info"] objectAtIndex:0];
    
    
    for (int i=0; i<array.count; i++)
    {
        if ([[[array objectAtIndex:i] valueForKey:@"input_type"] isEqualToString:@"text"])
        {
            UILabel *name_lbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 130, 100, 20)];
            
            name_lbl.text=@"Name";
            
            [name_lbl setFont:[UIFont fontWithName:@"PingFang SC" size:14]];
            
            name_lbl.textColor=[UIColor darkGrayColor];
            
            name_lbl.tag =108;
            
            [scrollview_view addSubview:name_lbl];
            
            
            UITextField *name_textfield=[[UITextField alloc]initWithFrame:CGRectMake(20, name_lbl.frame.origin.y+name_lbl.frame.size.height +10,  self.view.frame.size.width-40, 20)];
            
            
            name_textfield.autocorrectionType=UITextAutocorrectionTypeNo;
            
            name_textfield.delegate=self;
            
            name_textfield.placeholder=@"Enter Pet Name";
            
            [name_textfield setFont:[UIFont fontWithName:@"PingFang SC" size:15]];
            
            name_textfield.tag = [[[array objectAtIndex:i] valueForKey:@"option_id"] intValue];
            
            [scrollview_view addSubview:name_textfield];
            
            
            lbl=[[UILabel alloc]initWithFrame:CGRectMake(20, name_textfield.frame.origin.y+name_textfield.frame.size.height +5, self.view.frame.size.width-40, 1)];
            
            if (self.edit.length>0)
            {
                name_textfield.text = [[array objectAtIndex:i] valueForKey:@"show_name"];
                
                
               // [self editDataSet:[NSString stringWithFormat:@"%@-%@",[[array objectAtIndex:i] valueForKey:@"input_name"],[array [i]valueForKey:@"input_type"]] array:[[array objectAtIndex:i] valueForKey:@"input_option"]];
                
           
                
                
            }
            
            
            
            lbl.backgroundColor=[UIColor lightGrayColor];
            
            [scrollview_view addSubview:lbl];
        }
        
        else if ([[[array objectAtIndex:i] valueForKey:@"input_type"] isEqualToString:@"select"] && [[[array objectAtIndex:i] valueForKey:@"input_name"] isEqualToString:@"Years"])
        {
            
            year_ary=[array objectAtIndex:i];
            
            
            UILabel *years_lbl=[[UILabel alloc]initWithFrame:CGRectMake(20,lbl .frame.origin.y+lbl.frame.size.height +25, self.view.frame.size.width/2-20, 20)];
            
            years_lbl.text=@"Years";
            
            years_lbl.tag =108;
            
            [years_lbl setFont:[UIFont fontWithName:@"PingFang SC" size:14]];
            
            years_lbl.textColor=[UIColor darkGrayColor];
            
            [scrollview_view addSubview:years_lbl];
            
            UILabel *yearstext_lbl=[[UILabel alloc]initWithFrame:CGRectMake(20,years_lbl .frame.origin.y+years_lbl.frame.size.height +10, self.view.frame.size.width/2-40, 20)];
            
            
            [yearstext_lbl setFont:[UIFont fontWithName:@"PingFang SC" size:15]];
            
            [scrollview_view addSubview:yearstext_lbl];
            
            UIButton *years_btn=[[UIButton alloc]initWithFrame:CGRectMake(20,years_lbl .frame.origin.y+years_lbl.frame.size.height +10, self.view.frame.size.width/2-40, 20)];
            
            
            [years_btn addTarget:self action:@selector(year:) forControlEvents:UIControlEventTouchUpInside];
            
            [scrollview_view addSubview:years_btn];
            
            
            UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(years_btn.frame.origin.x+years_btn.frame.size.width-18,years_btn .frame.origin.y+5,15,10)];
            
            img.image=[UIImage imageNamed:@"Disclosure Indicator Copy"];
            
            [scrollview_view addSubview:img];
            
            
            lbl1=[[UILabel alloc]initWithFrame:CGRectMake(20, yearstext_lbl.frame.origin.y+yearstext_lbl.frame.size.height +5, self.view.frame.size.width/2-40, 1)];
          
            if (self.edit.length>0)
            {
                yearstext_lbl.text = [[array objectAtIndex:i] valueForKey:@"show_name"];
                
                
                [self editDataSet:[NSString stringWithFormat:@"%@-%@",[[array objectAtIndex:i] valueForKey:@"input_name"],[array [i]valueForKey:@"input_type"]] array:[[array objectAtIndex:i] valueForKey:@"input_option"]];
            }
            
            lbl1.backgroundColor=[UIColor lightGrayColor];
            
            [scrollview_view addSubview:lbl1];
            
        }
        
        else if ([[[array objectAtIndex:i] valueForKey:@"input_type"] isEqualToString:@"select"] && [[[array objectAtIndex:i] valueForKey:@"input_name"] isEqualToString:@"Months"])
        {
            
            month_ary=[array objectAtIndex:i] ;
            
            
            UILabel *month_lbl=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2+20,lbl .frame.origin.y+lbl.frame.size.height +25, self.view.frame.size.width/2-40, 20)];
            
            month_lbl.text=@"Months";
            
            month_lbl.tag =108;
            
            [month_lbl setFont:[UIFont fontWithName:@"PingFang SC" size:14]];
            
            month_lbl.textColor=[UIColor darkGrayColor];
            
            [scrollview_view addSubview:month_lbl];
            
            UILabel *monthtext_lbl=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2+20,month_lbl .frame.origin.y+month_lbl.frame.size.height +10, self.view.frame.size.width/2-40, 20)];
            
            [monthtext_lbl setFont:[UIFont fontWithName:@"PingFang SC" size:15]];
            
            [scrollview_view addSubview:monthtext_lbl];
            
            UIButton *month_btn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2+20,month_lbl .frame.origin.y+month_lbl.frame.size.height +10, self.view.frame.size.width/2-40, 20)];
            
            
            [month_btn addTarget:self action:@selector(month:) forControlEvents:UIControlEventTouchUpInside];
            
            [scrollview_view addSubview:month_btn];
            
            
            UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(month_btn.frame.origin.x+month_btn.frame.size.width-18,month_btn .frame.origin.y+5,15,10)];
            
            img.image=[UIImage imageNamed:@"Disclosure Indicator Copy"];
            
            [scrollview_view addSubview:img];
            
            
            lbl2=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2+20, monthtext_lbl.frame.origin.y+monthtext_lbl.frame.size.height +5, self.view.frame.size.width/2-40, 1)];
            
            
            if (self.edit.length>0)
            {
                monthtext_lbl.text = [[array objectAtIndex:i] valueForKey:@"show_name"];
                
                
                [self editDataSet:[NSString stringWithFormat:@"%@-%@",[[array objectAtIndex:i] valueForKey:@"input_name"],[array [i]valueForKey:@"input_type"]] array:[[array objectAtIndex:i] valueForKey:@"input_option"]];
            }
            
            lbl2.backgroundColor=[UIColor lightGrayColor];
            
            [scrollview_view addSubview:lbl2];
            
            
        }
        
        else if ([[[array objectAtIndex:i] valueForKey:@"input_type"] isEqualToString:@"select"] && [[[array objectAtIndex:i] valueForKey:@"input_name"] isEqualToString:@"Gender"])
        {
            
            gendar_ary=[array objectAtIndex:i] ;
            
            
            
            UILabel *gendar_lbl=[[UILabel alloc]initWithFrame:CGRectMake(20,lbl1.frame.origin.y+lbl1.frame.size.height +25, self.view.frame.size.width/2-20, 20)];
            
            gendar_lbl.text=@"Gendar";
            
            gendar_lbl.tag =108;
            
            
            [gendar_lbl setFont:[UIFont fontWithName:@"PingFang SC" size:14]];
            
            gendar_lbl.textColor=[UIColor darkGrayColor];
            
            [scrollview_view addSubview:gendar_lbl];
            
            
            UILabel *gendartext_lbl=[[UILabel alloc]initWithFrame:CGRectMake(20,gendar_lbl .frame.origin.y+gendar_lbl.frame.size.height +10, self.view.frame.size.width/2-40, 20)];
            
            [gendartext_lbl setFont:[UIFont fontWithName:@"PingFang SC" size:15]];
            
            [scrollview_view addSubview:gendartext_lbl];
            
            
            UIButton *gendar_btn=[[UIButton alloc]initWithFrame:CGRectMake(20,gendar_lbl .frame.origin.y+gendar_lbl.frame.size.height +10, self.view.frame.size.width/2-40, 20)];
            
            
            [gendar_btn addTarget:self action:@selector(gendar:) forControlEvents:UIControlEventTouchUpInside];
            
            [scrollview_view addSubview:gendar_btn];
            
            UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(gendar_btn.frame.origin.x+gendar_btn.frame.size.width-18,gendar_btn .frame.origin.y+5,15,10)];
            
            img.image=[UIImage imageNamed:@"Disclosure Indicator Copy"];
            
            [scrollview_view addSubview:img];
            
            
            
            lbl3=[[UILabel alloc]initWithFrame:CGRectMake(20, gendartext_lbl.frame.origin.y+gendartext_lbl.frame.size.height +5, self.view.frame.size.width/2-40, 1)];
            
            if (self.edit.length>0)
            {
                gendartext_lbl.text = [[array objectAtIndex:i] valueForKey:@"show_name"];
                
                
                [self editDataSet:[NSString stringWithFormat:@"%@-%@",[[array objectAtIndex:i] valueForKey:@"input_name"],[array [i]valueForKey:@"input_type"]] array:[[array objectAtIndex:i] valueForKey:@"input_option"]];
            }
            
            lbl3.backgroundColor=[UIColor lightGrayColor];
            
            [scrollview_view addSubview:lbl3];
            
            
        }
        else if ([[[array objectAtIndex:i] valueForKey:@"input_type"] isEqualToString:@"select"] && [[[array objectAtIndex:i] valueForKey:@"input_name"] isEqualToString:@"Size"])
        {
            
            petsize_ary=[array objectAtIndex:i] ;
            
            
            
            UILabel *size_lbl=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2+20,lbl2 .frame.origin.y+lbl2.frame.size.height +25, self.view.frame.size.width/2-40, 20)];
            
            size_lbl.text=@"Pet Size";
            
            size_lbl.tag =108;
            
            
            [size_lbl setFont:[UIFont fontWithName:@"PingFang SC" size:14]];
            
            size_lbl.textColor=[UIColor darkGrayColor];
            
            [scrollview_view addSubview:size_lbl];
            
            
            UILabel *sizetext_lbl=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2+20,size_lbl .frame.origin.y+size_lbl.frame.size.height +10, self.view.frame.size.width/2-40, 20)];
            
            [sizetext_lbl setFont:[UIFont fontWithName:@"PingFang SC" size:13]];
            
            [scrollview_view addSubview:sizetext_lbl];
            
            
            UIButton *size_btn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2+20,size_lbl .frame.origin.y+size_lbl.frame.size.height +10, self.view.frame.size.width/2-40, 20)];
            
            
            [size_btn addTarget:self action:@selector(petsize:) forControlEvents:UIControlEventTouchUpInside];
            
            [scrollview_view addSubview:size_btn];
            
            
            UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(size_btn.frame.origin.x+size_btn.frame.size.width-18,size_btn .frame.origin.y+5,15,10)];
            
            img.image=[UIImage imageNamed:@"Disclosure Indicator Copy"];
            
            [scrollview_view addSubview:img];
            
            
            lbl4=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2+20, sizetext_lbl.frame.origin.y+sizetext_lbl.frame.size.height +5, self.view.frame.size.width/2-40, 1)];
            
            
            if (self.edit.length>0)
            {
                sizetext_lbl.text = [[array objectAtIndex:i] valueForKey:@"show_name"];
                
                
                [self editDataSet:[NSString stringWithFormat:@"%@-%@",[[array objectAtIndex:i] valueForKey:@"input_name"],[array [i]valueForKey:@"input_type"]] array:[[array objectAtIndex:i] valueForKey:@"input_option"]];
            }
            
            lbl4.backgroundColor=[UIColor lightGrayColor];
            
            [scrollview_view addSubview:lbl4];
            
            
        }
        
        else if ([[[array objectAtIndex:i] valueForKey:@"input_type"] isEqualToString:@"select"] && [[[array objectAtIndex:i] valueForKey:@"input_name"] isEqualToString:@"Breed"])
            
        {
            
            breed_ary=[array objectAtIndex:i] ;
            
            
            UILabel *breed_lbl=[[UILabel alloc]initWithFrame:CGRectMake(20,lbl3.frame.origin.y+lbl3.frame.size.height +25, self.view.frame.size.width/2-20, 20)];
            
            breed_lbl.text=@"Breed";
            
            breed_lbl.tag =108;
            
            [breed_lbl setFont:[UIFont fontWithName:@"PingFang SC" size:14]];
            
            breed_lbl.textColor=[UIColor darkGrayColor];
            
            [scrollview_view addSubview:breed_lbl];
            
            
            UILabel *breedtext_lbl=[[UILabel alloc]initWithFrame:CGRectMake(20,breed_lbl .frame.origin.y+breed_lbl.frame.size.height +10, self.view.frame.size.width-40, 20)];
            
            [breedtext_lbl setFont:[UIFont fontWithName:@"PingFang SC" size:15]];
            
            [scrollview_view addSubview:breedtext_lbl];
            
            
            UIButton *breed_btn=[[UIButton alloc]initWithFrame:CGRectMake(20,breed_lbl .frame.origin.y+breed_lbl.frame.size.height +10, self.view.frame.size.width-40, 20)];
            
            
            [breed_btn addTarget:self action:@selector(breed:) forControlEvents:UIControlEventTouchUpInside];
            
            [scrollview_view addSubview:breed_btn];
            
            UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(breed_btn.frame.origin.x+breed_btn.frame.size.width-18,breed_btn .frame.origin.y+5,15,10)];
            
            img.image=[UIImage imageNamed:@"Disclosure Indicator Copy"];
            
            [scrollview_view addSubview:img];
            
            
            
            lbl5=[[UILabel alloc]initWithFrame:CGRectMake(20, breedtext_lbl.frame.origin.y+breedtext_lbl.frame.size.height +5, self.view.frame.size.width-40, 1)];
            
            if (self.edit.length>0)
            {
                breedtext_lbl.text = [[array objectAtIndex:i] valueForKey:@"show_name"];
                
                
                [self editDataSet:[NSString stringWithFormat:@"%@-%@",[[array objectAtIndex:i] valueForKey:@"input_name"],[array [i]valueForKey:@"input_type"]] array:[[array objectAtIndex:i] valueForKey:@"input_option"]];
            }
            
            lbl5.backgroundColor=[UIColor lightGrayColor];
            
            [scrollview_view addSubview:lbl5];
            
            
            
            
            
        }
        
        else if ([[[array objectAtIndex:i] valueForKey:@"input_type"] isEqualToString:@"select"] && [[[array objectAtIndex:i] valueForKey:@"input_name"] isEqualToString:@"Type of Other pet"])
            
        {
            
            pettype_ary=[array objectAtIndex:i] ;
            
            
            UILabel *breed_lbl=[[UILabel alloc]initWithFrame:CGRectMake(20,lbl3.frame.origin.y+lbl3.frame.size.height +25, self.view.frame.size.width/2-20, 20)];
            
            breed_lbl.text=@"Type of Other pet";
            
            breed_lbl.tag = 108;
            
            [breed_lbl setFont:[UIFont fontWithName:@"PingFang SC" size:14]];
            
            breed_lbl.textColor=[UIColor darkGrayColor];
            
            [scrollview_view addSubview:breed_lbl];
            
            
            UILabel *breedtext_lbl=[[UILabel alloc]initWithFrame:CGRectMake(20,breed_lbl .frame.origin.y+breed_lbl.frame.size.height +10, self.view.frame.size.width-40, 20)];
            
            [breedtext_lbl setFont:[UIFont fontWithName:@"PingFang SC" size:15]];
            
            [scrollview_view addSubview:breedtext_lbl];
            
            
            UIButton *breed_btn=[[UIButton alloc]initWithFrame:CGRectMake(20,breed_lbl .frame.origin.y+breed_lbl.frame.size.height +10, self.view.frame.size.width-40, 20)];
            
            
            [breed_btn addTarget:self action:@selector(othertype:) forControlEvents:UIControlEventTouchUpInside];
            
            [scrollview_view addSubview:breed_btn];
            
            UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(breed_btn.frame.origin.x+breed_btn.frame.size.width-18,breed_btn .frame.origin.y+5,15,10)];
            
            img.image=[UIImage imageNamed:@"Disclosure Indicator Copy"];
            
            [scrollview_view addSubview:img];
            
            
            
            lbl5=[[UILabel alloc]initWithFrame:CGRectMake(20, breedtext_lbl.frame.origin.y+breedtext_lbl.frame.size.height +5, self.view.frame.size.width-40, 1)];
            
            
            if (self.edit.length>0)
            {
                breedtext_lbl.text = [[array objectAtIndex:i] valueForKey:@"show_name"];
                
                
                [self editDataSet:[NSString stringWithFormat:@"%@-%@",[[array objectAtIndex:i] valueForKey:@"input_name"],[array [i]valueForKey:@"input_type"]] array:[[array objectAtIndex:i] valueForKey:@"input_option"]];
            }
            lbl5.backgroundColor=[UIColor lightGrayColor];
            
            [scrollview_view addSubview:lbl5];
            
            
            
            
            
        }
        
        
        else  if ([[[array objectAtIndex:i] valueForKey:@"input_type"] isEqualToString:@"textarea"])
        {
            UILabel *describe_lbl=[[UILabel alloc]initWithFrame:CGRectMake(20,lbl5.frame.origin.y+lbl5.frame.size.height +25, self.view.frame.size.width/2-20, 20)];
            
            describe_lbl.text=@"Describe Your Pet";
            
            [describe_lbl setFont:[UIFont fontWithName:@"PingFang SC" size:14]];
            
            describe_lbl.tag = 108;
            
            describe_lbl.textColor=[UIColor darkGrayColor];
            
            [scrollview_view addSubview:describe_lbl];
            
            
            UITextView *textview=[[UITextView alloc]initWithFrame:CGRectMake(20, describe_lbl.frame.origin.y+describe_lbl.frame.size.height +10,  self.view.frame.size.width-40, 100)];
            
            textview.autocorrectionType=UITextAutocorrectionTypeNo;
            
            textview.delegate=self;
            
            [textview setFont:[UIFont fontWithName:@"PingFang SC" size:15]];
            
            textview.backgroundColor=[UIColor colorWithRed:(204/255.0) green:(204/255.0) blue:(204/255.0) alpha:0.2];
            
            textview.layer.cornerRadius=5;
            
            textview.tag = [[[array objectAtIndex:i] valueForKey:@"option_id"] intValue];
            
            
            [scrollview_view addSubview:textview];
            
            
            lbl6=[[UILabel alloc]initWithFrame:CGRectMake(20, textview.frame.origin.y+textview.frame.size.height +10, self.view.frame.size.width-40, 1)];
            
            if (self.edit.length>0)
            {
                textview.text = [[array objectAtIndex:i] valueForKey:@"show_name"];
                
                
                //[self editDataSet:[NSString stringWithFormat:@"%@-%@",[[array objectAtIndex:i] valueForKey:@"input_name"],[array [i]valueForKey:@"input_type"]] array:[[array objectAtIndex:i] valueForKey:@"input_option"]];
            }
            
            lbl6.backgroundColor=[UIColor lightGrayColor];
            
            [scrollview_view addSubview:lbl6];
            
            
        }
        else  if ([[[array objectAtIndex:i] valueForKey:@"input_type"] isEqualToString:@"radio"] && [[[array objectAtIndex:i] valueForKey:@"input_name"] isEqualToString:@"Is your cat spayed or neutered?"])
        {
            
            pet1cat_ary=[array objectAtIndex:i] ;
            
            UILabel *pet1qn_lbl=[[UILabel alloc]initWithFrame:CGRectMake(20,lbl6.frame.origin.y+lbl6.frame.size.height +25, self.view.frame.size.width-40, 20)];
            
            pet1qn_lbl.text=@"Is your cat spayed or neutered?";
            
            [pet1qn_lbl setFont:[UIFont fontWithName:@"PingFang SC" size:14]];
            
            pet1qn_lbl.tag = 108;
            
            pet1qn_lbl.textColor=[UIColor darkGrayColor];
            
            [scrollview_view addSubview:pet1qn_lbl];
            
            
            UILabel *pet1qntext_lbl=[[UILabel alloc]initWithFrame:CGRectMake(20,pet1qn_lbl .frame.origin.y+pet1qn_lbl.frame.size.height +10, self.view.frame.size.width-40, 20)];
            
            [pet1qntext_lbl setFont:[UIFont fontWithName:@"PingFang SC" size:15]];
            
            
            
            [scrollview_view addSubview:pet1qntext_lbl];
            
            
            UIButton *pet1catqn_btn=[[UIButton alloc]initWithFrame:CGRectMake(20,pet1qn_lbl .frame.origin.y+pet1qn_lbl.frame.size.height +10, self.view.frame.size.width-40, 20)];
            
            [pet1catqn_btn addTarget:self action:@selector(pet1cat:) forControlEvents:UIControlEventTouchUpInside];
            
            [scrollview_view addSubview:pet1catqn_btn];
            
            UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(pet1catqn_btn.frame.origin.x+pet1catqn_btn.frame.size.width-18,pet1catqn_btn .frame.origin.y+5,15,10)];
            
            img.image=[UIImage imageNamed:@"Disclosure Indicator Copy"];
            
            [scrollview_view addSubview:img];
            
            
            
            lbl7=[[UILabel alloc]initWithFrame:CGRectMake(20, pet1qntext_lbl.frame.origin.y+pet1qntext_lbl.frame.size.height +5, self.view.frame.size.width-40, 1)];
            
            
            lbl7.backgroundColor=[UIColor lightGrayColor];
            
            
            if (self.edit.length>0)
            {
                pet1qntext_lbl.text = [[array objectAtIndex:i] valueForKey:@"show_name"];
                
                
                [self editDataSet:[NSString stringWithFormat:@"%@-%@",[[array objectAtIndex:i] valueForKey:@"input_name"],[array [i]valueForKey:@"input_type"]] array:[[array objectAtIndex:i] valueForKey:@"input_option"]];
            }
            [scrollview_view addSubview:lbl7];
            
            
            
        }
        else  if ([[[array objectAtIndex:i] valueForKey:@"input_type"] isEqualToString:@"radio"] && [[[array objectAtIndex:i] valueForKey:@"input_name"] isEqualToString:@"Is your dog spayed or neutered?"])
        {
            
            
            
            pet1dog_ary=[array objectAtIndex:i] ;
            
            UILabel *pet1qn_lbl=[[UILabel alloc]initWithFrame:CGRectMake(20,lbl6.frame.origin.y+lbl6.frame.size.height +25, self.view.frame.size.width-40, 20)];
            
            pet1qn_lbl.text=@"Is your dog spayed or neutered?";
            
            [pet1qn_lbl setFont:[UIFont fontWithName:@"PingFang SC" size:14]];
            
            pet1qn_lbl.textColor=[UIColor darkGrayColor];
            
            pet1qn_lbl.tag = 108;
            
            [scrollview_view addSubview:pet1qn_lbl];
            
            
            UILabel *pet1qntext_lbl=[[UILabel alloc]initWithFrame:CGRectMake(20,pet1qn_lbl .frame.origin.y+pet1qn_lbl.frame.size.height +10, self.view.frame.size.width-40, 20)];
            
            [pet1qntext_lbl setFont:[UIFont fontWithName:@"PingFang SC" size:15]];
            
            [scrollview_view addSubview:pet1qntext_lbl];
            
            
            UIButton *pet1qn_btn=[[UIButton alloc]initWithFrame:CGRectMake(20,pet1qn_lbl .frame.origin.y+pet1qn_lbl.frame.size.height +10, self.view.frame.size.width-40, 20)];
            
            
            [pet1qn_btn addTarget:self action:@selector(pet1dog:) forControlEvents:UIControlEventTouchUpInside];
            
            [scrollview_view addSubview:pet1qn_btn];
            
            UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(pet1qn_btn.frame.origin.x+pet1qn_btn.frame.size.width-18,pet1qn_btn .frame.origin.y+5,15,10)];
            
            img.image=[UIImage imageNamed:@"Disclosure Indicator Copy"];
            
            [scrollview_view addSubview:img];
            
            
            
            lbl7=[[UILabel alloc]initWithFrame:CGRectMake(20, pet1qntext_lbl.frame.origin.y+pet1qntext_lbl.frame.size.height +5, self.view.frame.size.width-40, 1)];
            
            if (self.edit.length>0)
            {
                pet1qntext_lbl.text = [[array objectAtIndex:i] valueForKey:@"show_name"];
                
                
                [self editDataSet:[NSString stringWithFormat:@"%@-%@",[[array objectAtIndex:i] valueForKey:@"input_name"],[array [i]valueForKey:@"input_type"]] array:[[array objectAtIndex:i] valueForKey:@"input_option"]];
            }
            
            lbl7.backgroundColor=[UIColor lightGrayColor];
            
            [scrollview_view addSubview:lbl7];
            
            
            
        }
        
        
        else  if ([[[array objectAtIndex:i] valueForKey:@"input_type"] isEqualToString:@"radio"] && [[[array objectAtIndex:i] valueForKey:@"input_name"] isEqualToString:@"Is your pet friendly with other pets?"])
        {
            
            pet2_ary=[array objectAtIndex:i] ;
            
            
            UILabel *pet2qn_lbl=[[UILabel alloc]initWithFrame:CGRectMake(20,lbl6.frame.origin.y+lbl6.frame.size.height +25, self.view.frame.size.width-40, 20)];
            
            pet2qn_lbl.text=@"Is your pet friendly with other pets?";
            
            [pet2qn_lbl setFont:[UIFont fontWithName:@"PingFang SC" size:14]];
            
            pet2qn_lbl.textColor=[UIColor darkGrayColor];
            
            pet2qn_lbl.tag = 108;
            
            [scrollview_view addSubview:pet2qn_lbl];
            
            
            UILabel *pet2qntext_lbl=[[UILabel alloc]initWithFrame:CGRectMake(20,pet2qn_lbl .frame.origin.y+pet2qn_lbl.frame.size.height +10, self.view.frame.size.width-40, 20)];
            
            [pet2qntext_lbl setFont:[UIFont fontWithName:@"PingFang SC" size:15]];
            
            [scrollview_view addSubview:pet2qntext_lbl];
            
            
            UIButton *pet2qn_btn=[[UIButton alloc]initWithFrame:CGRectMake(20,pet2qn_lbl .frame.origin.y+pet2qn_lbl.frame.size.height +10, self.view.frame.size.width-40, 20)];
            
            
            [pet2qn_btn addTarget:self action:@selector(pet2:) forControlEvents:UIControlEventTouchUpInside];
            
            [scrollview_view addSubview:pet2qn_btn];
            
            UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(pet2qn_btn.frame.origin.x+pet2qn_btn.frame.size.width-18,pet2qn_btn .frame.origin.y+5,15,10)];
            
            img.image=[UIImage imageNamed:@"Disclosure Indicator Copy"];
            
            [scrollview_view addSubview:img];
            
            
            
            lbl8=[[UILabel alloc]initWithFrame:CGRectMake(20, pet2qntext_lbl.frame.origin.y+pet2qntext_lbl.frame.size.height +5, self.view.frame.size.width-40, 1)];
            
            if (self.edit.length>0)
            {
                pet2qntext_lbl.text = [[array objectAtIndex:i] valueForKey:@"show_name"];
                
                
                [self editDataSet:[NSString stringWithFormat:@"%@-%@",[[array objectAtIndex:i] valueForKey:@"input_name"],[array [i]valueForKey:@"input_type"]] array:[[array objectAtIndex:i] valueForKey:@"input_option"]];
            }
            
            lbl8.backgroundColor=[UIColor lightGrayColor];
            
            [scrollview_view addSubview:lbl8];
            
        }
        else  if ([[[array objectAtIndex:i] valueForKey:@"input_type"] isEqualToString:@"radio"] && [[[array objectAtIndex:i] valueForKey:@"input_name"] isEqualToString:@"Is your cat friendly with other pets?"])
        {
            
            pet2cat_ary=[array objectAtIndex:i] ;
            
            
            UILabel *pet2qn_lbl=[[UILabel alloc]initWithFrame:CGRectMake(20,lbl7.frame.origin.y+lbl7.frame.size.height +25, self.view.frame.size.width-40, 20)];
            
            pet2qn_lbl.text=@"Is your cat friendly with other pets?";
            
            [pet2qn_lbl setFont:[UIFont fontWithName:@"PingFang SC" size:14]];
            
            pet2qn_lbl.textColor=[UIColor darkGrayColor];
            
            pet2qn_lbl.tag =108;
            
            [scrollview_view addSubview:pet2qn_lbl];
            
            
            UILabel *pet2qntext_lbl=[[UILabel alloc]initWithFrame:CGRectMake(20,pet2qn_lbl .frame.origin.y+pet2qn_lbl.frame.size.height +10, self.view.frame.size.width-40, 20)];
            
            [pet2qntext_lbl setFont:[UIFont fontWithName:@"PingFang SC" size:15]];
            
            [scrollview_view addSubview:pet2qntext_lbl];
            
            
            UIButton *pet2qn_btn=[[UIButton alloc]initWithFrame:CGRectMake(20,pet2qn_lbl .frame.origin.y+pet2qn_lbl.frame.size.height +10, self.view.frame.size.width-40, 20)];
            
            
            [pet2qn_btn addTarget:self action:@selector(pet2cat:) forControlEvents:UIControlEventTouchUpInside];
            
            [scrollview_view addSubview:pet2qn_btn];
            
            UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(pet2qn_btn.frame.origin.x+pet2qn_btn.frame.size.width-18,pet2qn_btn .frame.origin.y+5,15,10)];
            
            img.image=[UIImage imageNamed:@"Disclosure Indicator Copy"];
            
            [scrollview_view addSubview:img];
            
            
            
            lbl8=[[UILabel alloc]initWithFrame:CGRectMake(20, pet2qntext_lbl.frame.origin.y+pet2qntext_lbl.frame.size.height +5, self.view.frame.size.width-40, 1)];
            
            if (self.edit.length>0)
            {
                pet2qntext_lbl.text = [[array objectAtIndex:i] valueForKey:@"show_name"];
                
                
                [self editDataSet:[NSString stringWithFormat:@"%@-%@",[[array objectAtIndex:i] valueForKey:@"input_name"],[array [i]valueForKey:@"input_type"]] array:[[array objectAtIndex:i] valueForKey:@"input_option"]];
            }
            
            lbl8.backgroundColor=[UIColor lightGrayColor];
            
            [scrollview_view addSubview:lbl8];
        }
        else  if ([[[array objectAtIndex:i] valueForKey:@"input_type"] isEqualToString:@"radio"] && [[[array objectAtIndex:i] valueForKey:@"input_name"] isEqualToString:@"Is your dog friendly with other pets?"])
        {
            
            pet2dog_ary=[array objectAtIndex:i] ;
            
            
            UILabel *pet2qn_lbl=[[UILabel alloc]initWithFrame:CGRectMake(20,lbl7.frame.origin.y+lbl7.frame.size.height +25, self.view.frame.size.width-40, 20)];
            
            pet2qn_lbl.text=@"Is your dog friendly with other pets?";
            pet2qn_lbl.tag = 108;
            
            [pet2qn_lbl setFont:[UIFont fontWithName:@"PingFang SC" size:14]];
            
            pet2qn_lbl.textColor=[UIColor darkGrayColor];
            
            [scrollview_view addSubview:pet2qn_lbl];
            
            
            UILabel *pet2qntext_lbl=[[UILabel alloc]initWithFrame:CGRectMake(20,pet2qn_lbl .frame.origin.y+pet2qn_lbl.frame.size.height +10, self.view.frame.size.width-40, 20)];
            
            [pet2qntext_lbl setFont:[UIFont fontWithName:@"PingFang SC" size:15]];
            
            [scrollview_view addSubview:pet2qntext_lbl];
            
            
            UIButton *pet2qn_btn=[[UIButton alloc]initWithFrame:CGRectMake(20,pet2qn_lbl .frame.origin.y+pet2qn_lbl.frame.size.height +10, self.view.frame.size.width-40, 20)];
            
            
            [pet2qn_btn addTarget:self action:@selector(pet2dog:) forControlEvents:UIControlEventTouchUpInside];
            
            [scrollview_view addSubview:pet2qn_btn];
            
            UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(pet2qn_btn.frame.origin.x+pet2qn_btn.frame.size.width-18,pet2qn_btn .frame.origin.y+5,15,10)];
            
            img.image=[UIImage imageNamed:@"Disclosure Indicator Copy"];
            
            [scrollview_view addSubview:img];
            
            
            
            lbl8=[[UILabel alloc]initWithFrame:CGRectMake(20, pet2qntext_lbl.frame.origin.y+pet2qntext_lbl.frame.size.height +5, self.view.frame.size.width-40, 1)];
            
            
            if (self.edit.length>0)
            {
                pet2qntext_lbl.text = [[array objectAtIndex:i] valueForKey:@"show_name"];
                
                
                [self editDataSet:[NSString stringWithFormat:@"%@-%@",[[array objectAtIndex:i] valueForKey:@"input_name"],[array [i]valueForKey:@"input_type"]] array:[[array objectAtIndex:i] valueForKey:@"input_option"]];
            }
            
            lbl8.backgroundColor=[UIColor lightGrayColor];
            
            [scrollview_view addSubview:lbl8];
        }
        
    }
    
    
    addanotherpet_scroll.contentSize = CGSizeMake(0,addanotherpet_scroll.frame.origin.y+addanotherpet_scroll.frame.size.height+300);
    
    
    scrollview_view.frame=CGRectMake(0, choosepettype_lbl.frame.origin.y+choosepettype_lbl.frame.size.height+10, scrollview_view.frame.size.width, addanotherpet_scroll.frame.origin.y+addanotherpet_scroll.contentSize.height-82);
    
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
- (IBAction)savePet:(UIButton *)sender {
    
    [self SavePet];
    
}

- (IBAction)choosepettypebtn_tap:(id)sender
{
    
    UIAlertController *departureActnSht = [UIAlertController alertControllerWithTitle:@"Choose Pet Type"message:nil  preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    
    for (int j =0 ; j<allpetdetails_ary.count; j++)
    {
        NSString *titleString = [ allpetdetails_ary[j] valueForKey:@"name"];
        UIAlertAction *action = [UIAlertAction actionWithTitle:titleString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            
            
            NSLog(@"%@", allpetdetails_ary[j]);
            choosepettype_lbl.text=[allpetdetails_ary[j] valueForKey:@"name"];
            [self urlData:[ allpetdetails_ary[j] valueForKey:@"id"]];
            
            save_btn.hidden=NO;
            
            pettype_str=[ allpetdetails_ary[j] valueForKey:@"id"];
            NSLog(@"......................%@",pettype_str);
        }];
        
        [departureActnSht addAction:action];
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        
        // [self dismissViewControllerAnimated:departureActnSht completion:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [departureActnSht addAction:cancelAction];
    [self presentViewController:departureActnSht animated:YES completion:nil];
    
}


-(void)SavePet
{
    
    NSString *name=@"";
    
    UILabel *red_lbl;
    
    //NSString *
    
    for (id Object in scrollview_view.subviews)
    {
        
        if ([Object isKindOfClass:[UITextField class]])
        {
            UITextField *text = (UITextField *)Object;
            
            
            if (text.text.length==0)
            {
            
                break;
            }
            else
            {
            
                red_lbl.textColor = [UIColor darkGrayColor];
                
            NSMutableDictionary *dic = [NSMutableDictionary new];
            [dic setObject:text.text forKey:@"value"];
            [dic setObject:[NSString stringWithFormat:@"%ld",(long)text.tag] forKey:@"id"];
            
            [selected_data setObject:dic forKey:[NSString stringWithFormat:@"%ld-textfield",(long)text.tag]];
                
            }
            
        }
        else if([Object isKindOfClass:[UITextView class]])
        {
            
            UITextView *text = (UITextView *)Object;
            
            if (text.text.length==0)
            {
                
                break;
            }
            
            else
            {
                red_lbl.textColor = [UIColor darkGrayColor];
            
                NSMutableDictionary *dic = [NSMutableDictionary new];

            [dic setObject:text.text forKey:@"value"];
            [dic setObject:[NSString stringWithFormat:@"%ld",(long)text.tag] forKey:@"id"];
            
            [selected_data setObject:dic forKey:[NSString stringWithFormat:@"%ld-textview",(long)text.tag]];
        
        
            }
        
    }
        
        else if ([Object isKindOfClass:[UILabel class]])
        {
            UILabel *lbl_new = (UILabel *)Object;
            
            
            
            if (lbl_new.tag == 108)
            {
                lbl_new.textColor = [UIColor redColor];
                name = lbl_new.text;
                
                red_lbl = lbl_new;
            }
            
            
            if (lbl_new.tag !=108 && lbl_new.frame.size.height !=1)
            {
                //red_lbl.textColor = [UIColor darkGrayColor];
                
                if (lbl_new.text.length==0)
                {
                    break;
                    
                    
                }
                else
                {
                    name = @"done";
                    red_lbl.textColor = [UIColor darkGrayColor];
                }
            }
            
            

            
        }
        
        
}
    
    
    
    NSLog(@"name--->%@",name);
    
    //NSLog(@"select--->%@\nradio----%@\ntextfield---->%@textview---->%@",select_array,radio_array,textfield_array,textview_array);
    
    if (![name isEqualToString:@"done"])
    {
        
 
    }
    
    
   else if (imageData.length==0)
    {
        [YXSpritesLoadingView errorInfo:@"Please Select Pet Photo"];
    }
    
    
    else
    {
        if (self.edit.length>0)
        {
            
            NSLog(@"tapped");
            
            textfield_array = [NSMutableArray new];
            textview_array = [NSMutableArray new];
            select_array = [NSMutableArray new];
            radio_array = [NSMutableArray new];
            
            for (NSString *key in selected_data)
            {
                if ([key containsString:@"-select"])
                {
                    [select_array addObject:[selected_data valueForKey:key]];
                }
                else if ([key containsString:@"-radio"])
                {
                    [radio_array addObject:[selected_data valueForKey:key]];
                }
                else if ([key containsString:@"-textview"])
                {
                    [textview_array addObject:[selected_data valueForKey:key]];
                }
                else if ([key containsString:@"-textfield"])
                {
                    [textfield_array addObject:[selected_data valueForKey:key]];
                }
                
            }
            
            
            
            NSDictionary *paramitter = [[NSDictionary alloc]initWithObjectsAndKeys:[self jsonEncode:select_array],@"select",[self jsonEncode:radio_array],@"radio",[self jsonEncode:textfield_array],@"text",[self jsonEncode:textview_array],@"textarea",[[NSUserDefaults standardUserDefaults]valueForKey:@"userid"],@"user_id",[[NSUserDefaults standardUserDefaults]valueForKey:@"lan_code"],@"langid",_pet_type_id,@"pettypeid",_edit_id,@"edit_pet_id",nil];
            
            
            
            
            [url_obj post_dataWithImage:[NSString stringWithFormat:@"%@app_users_addpetinfo?",App_Domain_Url] Post_data:paramitter image:imageData paramNameForImage:@"petimg" Withblock:^(id result, NSError *error) {
                
                
                
                
                NSLog(@"result--->%@",result);
                
                NSString *response=[NSString stringWithFormat:@"%@",[result valueForKey:@"response"]];
                
                [YXSpritesLoadingView errorInfo:[NSString stringWithFormat:@"%@",[result valueForKey:@"message"]]];
                
                //NSString *response=[NSString stringWithFormat:@"%@",[result valueForKey:@"response"]];
                
                if ([response isEqualToString:@"1"]) {
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }
                
                
                
            }];
            
        }
        else
        {
            
            
            
            textfield_array = [NSMutableArray new];
            textview_array = [NSMutableArray new];
            select_array = [NSMutableArray new];
            radio_array = [NSMutableArray new];
            
            for (NSString *key in selected_data)
            {
                if ([key containsString:@"-select"])
                {
                    [select_array addObject:[selected_data valueForKey:key]];
                }
                else if ([key containsString:@"-radio"])
                {
                    [radio_array addObject:[selected_data valueForKey:key]];
                }
                else if ([key containsString:@"-textview"])
                {
                    [textview_array addObject:[selected_data valueForKey:key]];
                }
                else if ([key containsString:@"-textfield"])
                {
                    [textfield_array addObject:[selected_data valueForKey:key]];
                }
                
            }
            
            
            
            NSDictionary *paramitter = [[NSDictionary alloc]initWithObjectsAndKeys:[self jsonEncode:select_array],@"select",[self jsonEncode:radio_array],@"radio",[self jsonEncode:textfield_array],@"text",[self jsonEncode:textview_array],@"textarea",[[NSUserDefaults standardUserDefaults]valueForKey:@"userid"],@"user_id",[[NSUserDefaults standardUserDefaults]valueForKey:@"lan_code"],@"langid",pettype_str,@"pettypeid",nil];
            
            
            
            
            [url_obj post_dataWithImage:[NSString stringWithFormat:@"%@app_users_addpetinfo?",App_Domain_Url] Post_data:paramitter image:imageData paramNameForImage:@"petimg" Withblock:^(id result, NSError *error) {
                
                
                
                
                NSLog(@"result--->%@",result);
                
                NSString *response=[NSString stringWithFormat:@"%@",[result valueForKey:@"response"]];
                
                
                [YXSpritesLoadingView errorInfo:[NSString stringWithFormat:@"%@",[result valueForKey:@"message"]]];
                
                //NSString *response=[NSString stringWithFormat:@"%@",[result valueForKey:@"response"]];
                
                if ([response isEqualToString:@"1"]) {
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }
                
                
                
            }];
            
            
        }
    }
    
    
    
}


-(NSString *)jsonEncode:(NSArray *)array
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    //jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return jsonString;
}


@end
