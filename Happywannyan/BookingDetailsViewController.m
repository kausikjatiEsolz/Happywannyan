//
//  BookingDetailsViewController.m
//  Happywannyan
//
//  Created by Kausik_Jati on 25/05/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import "BookingDetailsViewController.h"
#import "UIImageView+WebCache.h"
@interface BookingDetailsViewController ()

@end

@implementation BookingDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    url_obj=[Json_Class new];
    
    main_ary=[[NSMutableArray alloc]init];
    
    text_font=[UIFont fontWithName:@"PingFang SC" size:14.0f];
    tbl_ary=[[NSMutableArray alloc]initWithObjects:@"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",@"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum", nil];
    
    
        messagebtn_lbl.frame=CGRectMake(message_btn.frame.origin.x+message_btn.frame.size.width/8, message_btn.frame.origin.y+13, messagebtn_lbl.frame.size.width, messagebtn_lbl.frame.size.height);
    
    
    cancelbtn_lbl.frame=CGRectMake(cancel_btn.frame.origin.x+cancel_btn.frame.size.width/8, cancel_btn.frame.origin.y+13, cancelbtn_lbl.frame.size.width, cancelbtn_lbl.frame.size.height);
    
    user_img.layer.cornerRadius=4;
    user_img.clipsToBounds=YES;
    
    bookingdetails_tbl.contentInset=UIEdgeInsetsMake(0, 0, 250, 0);
    
    
   // [self urlData:@"upcoming_booking_list"];
    
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tbl_ary.count;
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CELL=[bookingdetails_tbl dequeueReusableCellWithIdentifier:@"BookingDetails" forIndexPath:indexPath];
    
    return CELL;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    CGSize size_=[self findHeightForText:[NSString stringWithFormat:@"\n%@",table_str] havingWidth:bookingdetails_tbl.frame.size.width andFont:text_font];
    
        CGSize size_=[self findHeightForText:[tbl_ary objectAtIndex:indexPath.row] havingWidth:bookingdetails_tbl.frame.size.width andFont:text_font];
    
    
    return size_.height+400;
}



//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    
//        return _bookingdetailstbl_headerview.frame.size.height;
//
//}
//
//
//
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    
//        return _bookingdetailstbl_headerview;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return _bookingdetailstbl_footterview.frame.size.height;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    return _bookingdetailstbl_footterview;
//}

- (CGSize)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font
{
    CGSize size = CGSizeZero;
    if (text) {
        CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font } context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    return size;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
//    
//    CELL.bookingdetail_celllbl.frame=CGRectMake(16,CELL.bookingdetail_celllbl.frame.origin.y, CELL.frame.size.width-20,[self findHeightForText:[NSString stringWithFormat:@"\n%@",table_str] havingWidth:bookingdetails_tbl.frame.size.width andFont:text_font].height);
    
    CELL.bookingdetail_celllbl.frame=CGRectMake(16,CELL.size_lbl.frame.origin.y+CELL.size_lbl.frame.size.height+40, CELL.frame.size.width-20,[self findHeightForText:[tbl_ary objectAtIndex:indexPath.row] havingWidth:bookingdetails_tbl.frame.size.width andFont:text_font].height);
    
    CELL.bookingdetail_celllbl.font=[UIFont fontWithName:@"PingFang SC" size:12.0f];;
    
    CELL.bookingdetail_celllbl.numberOfLines = 999;
    CELL.bookingdetail_celllbl.lineBreakMode= NSLineBreakByWordWrapping;
//    CELL.bookingdetail_celllbl.text=[NSString stringWithFormat:@"\n%@",table_str];
    CELL.bookingdetail_celllbl.text=[tbl_ary objectAtIndex:indexPath.row];
    
    
    
    CELL.celllower_view.frame=CGRectMake(16, CELL.bookingdetail_celllbl.frame.origin.y+CELL.bookingdetail_celllbl.frame.size.height + 8, CELL.celllower_view.frame.size.width, CELL.celllower_view.frame.size.height);

    
}

-(void)urlData:(NSString *)booking_list
{
    NSString *url_str=[NSString stringWithFormat:@"%@%@?user_id=116&lang_id=en&start_form=0&per_page=5&user_timezone=&search_param=201706284AC5",App_Domain_Url,booking_list];
    NSString *urlUTF8=[url_str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
    
    [request setURL:[NSURL URLWithString:urlUTF8]];
    
     [url_obj GlobalDict:request Globalstr:@"array" lodaer:YES Withblock:^(id result, NSError *error) {
         
         NSString *response=[NSString stringWithFormat:@"%@",[result valueForKey:@"response"]];
         
         NSLog(@"%@",result);
         
         if ([response isEqualToString:@"1"]) {
             
             
             main_ary=[result valueForKey:@"booking_info_array"];
             
             [user_img sd_setImageWithURL:[NSURL URLWithString:[[[main_ary valueForKey:@"users_profile"] objectAtIndex:0]valueForKey:@"booked_user_image" ]] placeholderImage:[UIImage imageNamed:@"new-user-image-default"]];
             
            name_lbl.text=[[[main_ary valueForKey:@"users_profile" ] objectAtIndex:0]valueForKey:@"custom_quotes"];
             
             subname_lbl.text=[[[main_ary valueForKey:@"users_profile" ] objectAtIndex:0]valueForKey:@"booked_user_name"];
             
             
             startdate_lbl.text=[[[main_ary valueForKey:@"booking_info" ] objectAtIndex:0]valueForKey:@"booking_start_date"];
             
             enddate_lbl.text=[[[main_ary valueForKey:@"booking_info" ] objectAtIndex:0]valueForKey:@"booking_end_date"];
             
             bookingid_lbl.text=[[[main_ary valueForKey:@"booking_info" ] objectAtIndex:0]valueForKey:@"booking_id"];
             
             totalpet_lbl.text=[[[main_ary valueForKey:@"booking_info" ] objectAtIndex:0]valueForKey:@"booked_total_pet"];
             
             service_lbl.text=[[[main_ary valueForKey:@"booking_info" ] objectAtIndex:0]valueForKey:@"booking_service"];
             
             totalamount_lbl.text=[[[main_ary valueForKey:@"booking_info" ] objectAtIndex:0]valueForKey:@"booked_total_amount"];
             
             
             NSArray *array = [[[[main_ary valueForKey:@"pet_details"] objectAtIndex:0] valueForKey:@"pet_info"]objectAtIndex:0];
             
             for (int i=0; i<array.count; i++)
             {
                 if ([[[array objectAtIndex:i] valueForKey:@"name"] isEqualToString:@"Name"])
                 {
                     tableheadername_lbl.text = [[array objectAtIndex:i] valueForKey:@"value"];
                 }
                 else if ([[[array objectAtIndex:i] valueForKey:@"name"] isEqualToString:@"Years"])
                 {
                     tableheaderyear_lbl.text = [[array objectAtIndex:i] valueForKey:@"value"];
                 }
                 else if ([[[array objectAtIndex:i] valueForKey:@"name"] isEqualToString:@"Months"])
                 {
                     tableheadermonth_lbl.text = [[array objectAtIndex:i] valueForKey:@"value"];
                 }
                 else if ([[[array objectAtIndex:i] valueForKey:@"name"] isEqualToString:@"Breed"])
                 {
                     tableheaderbreed_lbl.text = [[array objectAtIndex:i] valueForKey:@"value"];
                 }
                 else if ([[[array objectAtIndex:i] valueForKey:@"value"] isEqualToString:@"Size"])
                 {
                     tableheadersize_lbl.text = [[array objectAtIndex:i] valueForKey:@"value"];
                 }
                 else if ([[[array objectAtIndex:i] valueForKey:@"name"] isEqualToString:@"Is your dog spayed or neutered?"])
                 {
                     tablefooterquestion1_lbl.text = [[array objectAtIndex:i] valueForKey:@"value"];
                 }
                 else if ([[[array objectAtIndex:i] valueForKey:@"name"] isEqualToString:@"Is your dog friendly with other pets?"])
                 {
                     tablefooterquestion2_lbl.text = [[array objectAtIndex:i] valueForKey:@"value"];
                 }
                 else if ([[[array objectAtIndex:i] valueForKey:@"name"] isEqualToString:@"Gender"])
                 {
                     tableheadergendar_lbl.text = [[array objectAtIndex:i] valueForKey:@"value"];
                 }
                 
                 
                 else if ([[[array objectAtIndex:i] valueForKey:@"name"] isEqualToString:@"Describe your dog"])
                 {
                     table_str= [[array objectAtIndex:i] valueForKey:@"value"];
                 }
                 
                 
                 
                 
                 
//                     "name":"Describe your dog",
//                     "value":"fhfgjhj"
//                 
                 
                 //        "input_name":"Name",
                 //        "":"jerry",
             }
             
        [tableheadermain_img sd_setImageWithURL:[NSURL URLWithString:[[[[main_ary valueForKey:@"pet_details"]objectAtIndex:0] valueForKey:@"pet_image" ]objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"new-user-image-default"]];
          //   NSLog(@".......%@",[[main_ary valueForKey:@"users_profile" ]valueForKey:@"custom_quotes"]);

             [bookingdetails_tbl reloadData];
         }
         else
         {
             
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

- (IBAction)back:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
