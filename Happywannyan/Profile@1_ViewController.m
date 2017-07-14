//
//  Profile@1_ViewController.m
//  Happywannyan_App
//
//  Created by Kausik_Jati on 23/05/17.
//  Copyright © 2017 Kausik_Jati. All rights reserved.
//

#import "Profile@1_ViewController.h"
#import "leftmenu.h"
#import "FavoriteSittersController.h"
#import "Json_Class.h"
#import "UIImageView+WebCache.h"
#import "WanNyanMeetUpController.h"
#import "ContactController.h"
#import "SearchMapController.h"
#import "PaymentBookingController.h"

@interface Profile_1_ViewController ()
{
    leftmenu *leftMenu_obj;
    
    Json_Class *url_obj;
    
    NSArray *review_list,*pet_info,*imagelist;
    
    NSMutableArray *servicelist;
    
    NSString *about;
    
    NSString *user_latlong;
}

@end

@implementation Profile_1_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    servicelist=[NSMutableArray new];
    
    leftMenu_obj = [[leftmenu alloc]init];
    
    [leftMenu_obj Leftmenu:self sideMenu:leftMenu_obj];
    
    text_font=[UIFont fontWithName:@"PingFang SC" size:13.0f];
    
    
    url_obj = [Json_Class new];
    
    pic_img.layer.cornerRadius=4;
    
    [self shadow:rightmenu_innerview];
    
    rightmenu_mainview.hidden=YES;
    
    rightmenu_innerview.layer.cornerRadius=5;
    
    
    nodata_lbl.hidden=YES;
    rightmenuview_btn.hidden=YES;

    [self urlData];
    
  
    
    
    service_table.hidden=YES;
    review_table.hidden=YES;
    collectionview_view.hidden=YES;
    
    
    reservationbtn_lbl.frame=CGRectMake(reservation_btn.frame.origin.x+reservation_btn.frame.size.width/8, reservation_btn.frame.origin.y+10, reservationbtn_lbl.frame.size.width, reservationbtn_lbl.frame.size.height);
    
    
    
    btn_ary=[[NSMutableArray alloc]initWithObjects:@"     About      |",@"   Services      |",@"   Reviews      |",@"   Photos       ", nil];
    
    profile_scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(5, second_headerview.frame.origin.y+second_headerview.frame.size.height, self.view.frame.size.width-10, 40)];
    profile_scroll.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
    int x = 0;
    for (int i = 0; i < btn_ary.count; i++) {
        CGSize size = [[btn_ary objectAtIndex:i] sizeWithAttributes:
                       @{NSFontAttributeName:
                             [UIFont fontWithName:@"PingFang SC" size:13.0f]}];
       // UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, size.width+11, 38)];
        
        [button setTitle:[NSString stringWithFormat:@"%@", [btn_ary objectAtIndex:i]] forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont fontWithName:@"PingFang SC" size:13.0f];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        button.tag=i;
       [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        if (button.tag==0) {
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, profile_scroll.frame.size.height-2, button.frame.size.width-5, 2)];
            lbl.backgroundColor=[UIColor colorWithRed:189/255.0 green:62/255.0 blue:73/255.0 alpha:1.0];
            [profile_scroll addSubview:lbl];
        }
        [profile_scroll addSubview:button];
        x += button.frame.size.width;
        [profile_scroll setShowsHorizontalScrollIndicator:NO];
        
    }
    profile_scroll.contentSize = CGSizeMake(x, profile_scroll.frame.size.height);
    [self.view addSubview:profile_scroll];

    profile_tbl.frame=CGRectMake(5,profile_scroll.frame.origin.y+profile_scroll.frame.size.height,profile_tbl.frame.size.width,self.view.frame.size.height-first_headerview.frame.size.height-second_headerview.frame.size.height-profile_scroll.frame.size.height-5);
    
}


-(void)shadow:(UIView *)subview
{
    UIColor *color = [UIColor blackColor];
    subview.layer.shadowColor = [color CGColor];
    subview.layer.shadowRadius = 2.0f;
    subview.layer.shadowOpacity = 1.5;
    subview.layer.shadowOffset = CGSizeZero;
    subview.layer.masksToBounds = NO;
}
- (IBAction)leftmenu:(id)sender {
    
    
     //[leftMenu_obj lefMenuopen:sender];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)rightmenu:(id)sender {
    
    if (rightmenu_mainview.hidden==YES) {
        
        [UIView animateWithDuration:0.3f animations:^{
            rightmenu_mainview.hidden=NO;
            rightmenuview_btn.hidden=NO;
        }];

    }
    else
    {
        rightmenu_mainview.hidden=YES;
        rightmenuview_btn.hidden=YES;
    }
    
    
}
- (IBAction)fevorite:(id)sender {
    
//    FavoriteSittersController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"favoritesitters"];
//    
//    [self.navigationController pushViewController:obj animated:YES];

    
    
}
- (IBAction)map:(id)sender {
}
- (IBAction)reservation:(id)sender {
    
    PaymentBookingController *paymentbooking = [self.storyboard instantiateViewControllerWithIdentifier:@"paymentbooking"];
    
    paymentbooking.data=[NSMutableArray new];
    paymentbooking.data=servicelist;
    paymentbooking.sitterid=_sitterid;
    
    [self.navigationController pushViewController:paymentbooking animated:YES];
    
    
    
}








-(IBAction)click:(id)sender
{
    UIButton *tap = (UIButton *)sender;
    //    NSLog(@"%d",tap.tag);
    [tap setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    for(UIButton *view in [profile_scroll subviews]){
        if([view isKindOfClass:[UIButton class]]){
            if(view != tap){
                UIButton* btn1 = (UIButton*) view;
                [btn1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                
            }
        }
    }
    if (tap.tag==0) {
        lbl.frame=CGRectMake(0, profile_scroll.frame.size.height-2, tap.frame.size.width-5, 2);
        lbl.backgroundColor=[UIColor colorWithRed:189/255.0 green:62/255.0 blue:73/255.0 alpha:1.0];
        [profile_scroll addSubview:lbl];
        
        nodata_lbl.hidden=YES;
        profile_tbl.hidden=NO;
        service_table.hidden=YES;
        review_table.hidden=YES;
        collectionview_view.hidden=YES;
        
        if ((pet_info == nil || pet_info.count==0) && (firstheader_ary == nil || firstheader_ary.count==0) && (secondheader_ary == nil || secondheader_ary.count==0) && (thirdheader_ary == nil || thirdheader_ary.count==0))
        {
            nodata_lbl.hidden=NO;
        }
        else
        {
            nodata_lbl.hidden=YES;
        }
        
    }
   else if (tap.tag==1) {
        lbl.frame=CGRectMake(tap.frame.origin.x-5, profile_scroll.frame.size.height-2, tap.frame.size.width, 2);
        lbl.backgroundColor=[UIColor colorWithRed:189/255.0 green:62/255.0 blue:73/255.0 alpha:1.0];
        [profile_scroll addSubview:lbl];
       
       nodata_lbl.hidden=YES;
       profile_tbl.hidden=YES;
       service_table.hidden=NO;
       review_table.hidden=YES;
       collectionview_view.hidden=YES;
      
       if (servicelist == nil || servicelist.count==0)
       {
           nodata_lbl.hidden=NO;
       }
       else
       {
           nodata_lbl.hidden=YES;
       }
    }
   else if (tap.tag==2) {
       lbl.frame=CGRectMake(tap.frame.origin.x-5, profile_scroll.frame.size.height-2, tap.frame.size.width, 2);
       lbl.backgroundColor=[UIColor colorWithRed:189/255.0 green:62/255.0 blue:73/255.0 alpha:1.0];
       [profile_scroll addSubview:lbl];
       
       nodata_lbl.hidden=YES;
       profile_tbl.hidden=YES;
       service_table.hidden=YES;
       review_table.hidden=NO;
       collectionview_view.hidden=YES;
       
       if (reviewlbl_ary == nil || reviewlbl_ary.count==0)
       {
           nodata_lbl.hidden=NO;
       }
       else
       {
           nodata_lbl.hidden=YES;
       }
       
   }
   else if (tap.tag==3) {
       lbl.frame=CGRectMake(tap.frame.origin.x-5, profile_scroll.frame.size.height-2, tap.frame.size.width-5, 2);
       lbl.backgroundColor=[UIColor colorWithRed:189/255.0 green:62/255.0 blue:73/255.0 alpha:1.0];
       [profile_scroll addSubview:lbl];
       
       nodata_lbl.hidden=YES;
       profile_tbl.hidden=YES;
       service_table.hidden=YES;
       review_table.hidden=YES;
       collectionview_view.hidden=NO;

       if (imagelist == nil || imagelist.count==0)
       {
           nodata_lbl.hidden=NO;
       }
       else
       {
           nodata_lbl.hidden=YES;
       }
    }

}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==profile_tbl) {
        if (section==1) {
            return firstheader_ary.count;
        }
        else if (section==2) {
            return secondheader_ary.count;
        }
        else if (section==3) {
            return thirdheader_ary.count;
        }
        else
            return 0;
    }
   else if (tableView==service_table) {
        return servicelist.count;
    }
    else if (tableView==review_table)
    {
        return reviewlbl_ary.count;
    }
    else
    {
        return 0;
    }
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==profile_tbl) {
        CELL=[profile_tbl dequeueReusableCellWithIdentifier:@"Profile"forIndexPath:indexPath];
        return CELL;
    }
   else if (tableView==service_table) {
        CELL1=[service_table dequeueReusableCellWithIdentifier:@"service"forIndexPath:indexPath];
       
       CELL1.name_lbl.text = [[servicelist objectAtIndex:indexPath.row] valueForKey:@"service_name"];
       CELL1.comment_lbl.text = [[servicelist objectAtIndex:indexPath.row] valueForKey:@"description"];
       CELL1.price_lbl.text = [NSString stringWithFormat:@"%@ %@",[[servicelist objectAtIndex:indexPath.row] valueForKey:@"service_price"],[[servicelist objectAtIndex:indexPath.row] valueForKey:@"unit_name"]];
       
       CELL1.booknowbtn.tag=indexPath.row;
       
       [CELL1.booknowbtn addTarget:self action:@selector(booknowbtn_tap:) forControlEvents:UIControlEventTouchUpInside];
       
       
        return CELL1;
    }
    else if (tableView==review_table)
    {
        CELL2=[review_table dequeueReusableCellWithIdentifier:@"review"forIndexPath:indexPath];
        
        
        return CELL2;
    }
    else
    {
        return nil;
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==profile_tbl) {
        if (indexPath.section==1) {
            return 30;
        }
        else if (indexPath.section==2) {
            return 30;
        }
        else if (indexPath.section==3) {
            return 30;
        }
        else
        {
           return 0;
        }
    }
    else if (tableView==service_table)
    {
        return CELL1.servicetable_cellview.frame.size.height+3;
    }
    else if(tableView==review_table)
    {
        CGSize size=[self findHeightForText:[[reviewlbl_ary objectAtIndex:indexPath.row] valueForKey:@"review_message"] havingWidth:review_table.frame.size.width andFont:text_font];
        
        
        return size.height+CELL2.main_img.frame.size.height+50;
    }
    else
    {
        return 0;
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView==profile_tbl) {
        if (section==0) {
            
            CGSize size=[self findHeightForText:_firstheader_lbl.text havingWidth:profile_tbl.frame.size.width andFont:text_font];
            CGFloat height=size.height;
          
            return height+10;
            
        }
        else if (section==1){
            _tblsecondview_lbl.frame=CGRectMake(16, 1, _tblsecondview_lbl.frame.size.width, 1);
            return _tblsecond_headerview.frame.size.height;
        }
        else if (section==2){
            _tblthirdview_lbl.frame=CGRectMake(16, 20, _tblthirdview_lbl.frame.size.width, 1);
            return _tblthird_headerview.frame.size.height;
        }
        else if (section==3){
            _tblfourthview_lbl.frame=CGRectMake(16, 20, _tblfourthview_lbl.frame.size.width, 1);
            return _tblfourthheader_view.frame.size.height;
        }
        else
        {
            return 0;
        }
    }
  else if (tableView==service_table)
  {
      return 0;
  }
  else if (tableView==review_table)
  {
      return 0;
  }
  else
  {
      return 0;
  }
}




- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView==profile_tbl) {
        if (section==0) {
            return _tblfirst_headerview;
        }
        else if (section==1) {
            return _tblsecond_headerview;
        }
        else if (section==2) {
            return _tblthird_headerview;
        }
        else if (section==3) {
            return _tblfourthheader_view;
        }
        else
        {
            return nil;
        }
    }
    else if (tableView==service_table)
    {
        return nil;
    }
    else if (tableView==review_table)
    {
        return nil;
    }
    else
    {
        return nil;
    }
}





-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==profile_tbl) {
        return 4;
    }
    else if (tableView==service_table)
    {
       return 1;
    }
    else if (tableView==review_table)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}



- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (tableView==profile_tbl) {
        if (indexPath.section==1) {
            CELL.specialskillcell_lbl.text=[firstheader_ary objectAtIndex:indexPath.row];
            CELL.specialskillcell_lbl.textColor=[UIColor colorWithRed:(189/255.0) green:(62/255.0) blue:(73/255.0) alpha:1];
        }
        else if (indexPath.section==2) {
            CELL.specialskillcell_lbl.text=[secondheader_ary objectAtIndex:indexPath.row];
            CELL.specialskillcell_lbl.textColor=[UIColor blackColor];
        }
        else if (indexPath.section==3) {
            CELL.specialskillcell_lbl.text=[thirdheader_ary objectAtIndex:indexPath.row];
            CELL.specialskillcell_lbl.textColor=[UIColor colorWithRed:(189/255.0) green:(62/255.0) blue:(73/255.0) alpha:1];
        }
    }
    else if (tableView==service_table) {
    }
    else if (tableView==review_table)
    {
        CELL2.review_cellview.frame=CGRectMake(0, 0, CELL2.review_cellview.frame.size.width, CELL2.frame.size.height-3);
        
        CELL2.comment_lbl.frame=CGRectMake(16,CELL2.main_img.frame.origin.y+CELL2.main_img.frame.size.height+10, CELL2.comment_lbl.frame.size.width,[self findHeightForText:[[reviewlbl_ary objectAtIndex:indexPath.row] valueForKey:@"review_message"] havingWidth:review_table.frame.size.width andFont:text_font].height);
        
        CELL2.comment_lbl.font=[UIFont fontWithName:@"PingFang SC" size:12.0f];
        CELL2.comment_lbl.numberOfLines = 999;
        CELL2.comment_lbl.lineBreakMode= NSLineBreakByWordWrapping;
        CELL2.comment_lbl.text=[[reviewlbl_ary objectAtIndex:indexPath.row] valueForKey:@"review_message"];
        
        
        [CELL2.main_img sd_setImageWithURL:[NSURL URLWithString:[[reviewlbl_ary objectAtIndex:indexPath.row] valueForKey:@"review_user_img"]] placeholderImage:nil options:SDWebImageTransformAnimatedImage];
        
        
        CELL2.name_lbl.text=[[reviewlbl_ary objectAtIndex:indexPath.row] valueForKey:@"review_user_name"];
        
        for (UIImageView *img_fav in CELL2.star_view.subviews)
        {
            if ([img_fav isKindOfClass:[UIImageView class]])
            {
                if (img_fav.tag<=[[[reviewlbl_ary objectAtIndex:indexPath.row] valueForKey:@"review_rating"] intValue])
                {
                    img_fav.image = [UIImage imageNamed:@"favorite"];
                }
                else
                {
                    img_fav.image = [UIImage imageNamed:@"star"];
                }
            }
        }
    }
    else
    {
    }
}



- (CGSize)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font
{
    CGSize size = CGSizeZero;
    if (text) {
        CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font } context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    return size;
}


- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath


{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    float cellWidth = screenWidth / 4.0-17;
    CGSize size = CGSizeMake(cellWidth, cellWidth);
    
    return size;
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
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return imagelist.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    
    CELL3=[images_collectionview dequeueReusableCellWithReuseIdentifier:@"images" forIndexPath:indexPath];
    
    [CELL3.image sd_setImageWithURL:[NSURL URLWithString:[imagelist objectAtIndex:indexPath.row]] placeholderImage:nil options:SDWebImageRefreshCached];
    
    return CELL3;
}

-(void)urlData
{
    NSString *url_str=[NSString stringWithFormat:@"%@app_users_sitterinfo",App_Domain_Url];
    NSString *postdata=[NSString stringWithFormat:@"sitter_user_id=%@&user_id=%@&langid=%@&user_timezone=%@",_sitterid,[[NSUserDefaults standardUserDefaults]valueForKey:@"userid"],[[NSUserDefaults standardUserDefaults]valueForKey:@"lan_code"],[NSTimeZone systemTimeZone].name];
    
    postdata=[postdata stringByRemovingPercentEncoding];
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
    
    [request setURL:[NSURL URLWithString:url_str]];
    
    [request setHTTPMethod:@"POST"];
    
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:[postdata dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [url_obj GlobalDict:request Globalstr:@"array" lodaer:YES Withblock:^(id result, NSError *error) {
        
        
        
        NSLog(@"result--->%@",result);
        
        
        if ([[NSString stringWithFormat:@"%@",[result valueForKey:@"response"]]isEqualToString:@"1"])
        {
            user_latlong = [NSString stringWithFormat:@"%@,%@",[[[result valueForKey:@"info_array"] valueForKey:@"basic_info"] valueForKey:@"lat"],[[[result valueForKey:@"info_array"] valueForKey:@"basic_info"] valueForKey:@"long"]];
            
            servicelist = [[result valueForKey:@"info_array"] valueForKey:@"servicelist"];
            
            imagelist = [[result valueForKey:@"info_array"] valueForKey:@"imagelist"];
            
            reviewlbl_ary = [[result valueForKey:@"info_array"] valueForKey:@"review_list"];
            
            firstheader_ary = [[result valueForKey:@"info_array"] valueForKey:@"special_skills"];
            
            secondheader_ary = [[result valueForKey:@"info_array"] valueForKey:@"spe_accommodation"];
            
            thirdheader_ary = [[[[result valueForKey:@"info_array"] valueForKey:@"pet_requirment"] valueForKey:@"pet_info"] valueForKey:@"pet_req_name"];
            
            
            [service_table reloadData];
            
            [images_collectionview reloadData];
            
            
            [review_table reloadData];
            
            
            
            
            
            about=[[[result valueForKey:@"info_array"] valueForKey:@"about_info"] valueForKey:@"description"] ;
            
            
            _firstheader_lbl.text=about;
            
            _firstheader_lbl.frame=CGRectMake(18,6, _firstheader_lbl.frame.size.width,[self findHeightForText:_firstheader_lbl.text havingWidth:profile_tbl.frame.size.width andFont:text_font].height);
            
            _firstheader_lbl.font=[UIFont fontWithName:@"PingFang SC" size:12.0f];
            _firstheader_lbl.numberOfLines = 999;
            //_firstheader_lbl.lineBreakMode= NSLineBreakByWordWrapping;
            
            
            location_lbl.text =[[[result valueForKey:@"info_array"] valueForKey:@"basic_info"] valueForKey:@"place_sitter"] ;
            
            [pic_img sd_setImageWithURL:[NSURL URLWithString:[[[result valueForKey:@"info_array"] valueForKey:@"basic_info"] valueForKey:@"place_sitter"]] placeholderImage:[UIImage imageNamed:@"new-user-image-default"] options:SDWebImageTransformAnimatedImage];
            
            name_lbl.text = [[[result valueForKey:@"info_array"] valueForKey:@"basic_info"] valueForKey:@"nickname"];
            
            nic_name.text = [[[result valueForKey:@"info_array"] valueForKey:@"basic_info"] valueForKey:@"businessname"];
            
            review_lbl.text = [NSString stringWithFormat:@"%@ Reviews",[[[result valueForKey:@"info_array"] valueForKey:@"basic_info"] valueForKey:@"no_of_review"]];
            
            
            for (UIImageView *img_fav in starview.subviews)
            {
                if ([img_fav isKindOfClass:[UIImageView class]])
                {
                    if (img_fav.tag<=[[[[result valueForKey:@"info_array"] valueForKey:@"basic_info"] valueForKey:@"ave_rating"] intValue])
                    {
                        img_fav.image = [UIImage imageNamed:@"favorite"];
                    }
                    else
                    {
                        img_fav.image = [UIImage imageNamed:@"star"];
                    }
                }
            }
            
            profile_tbl.contentInset = UIEdgeInsetsMake(0, 0, 70, 0);
            service_table.contentInset=UIEdgeInsetsMake(35, 0, 75, 0);
            review_table.contentInset=UIEdgeInsetsMake(40, 0, 75, 0);
            images_collectionview.contentInset=UIEdgeInsetsMake(50, 0, 75, 0);
            
            
            [profile_tbl reloadData];
            
        }
        
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    rightmenuview_btn.hidden=YES;
}

- (IBAction)rightmenuview_tap:(id)sender {
    
    
    
        [UIView animateWithDuration:0.3f animations:^{
            rightmenu_mainview.hidden=YES;
            rightmenuview_btn.hidden=YES;
        }];
    
    
}

//- (IBAction)meetup_tap:(id)sender {
//    
//    WanNyanMeetUpController *obj_new=[self.storyboard instantiateViewControllerWithIdentifier:@"wannyanmeetup"];
//    [self presentViewController:obj_new animated:YES completion:nil];
//    
//    rightmenu_mainview.hidden=YES;
//}

- (IBAction)contact_tap:(id)sender {
    
    ContactController *obj_new=[self.storyboard instantiateViewControllerWithIdentifier:@"contact"];
    
    obj_new.sitterid=_sitterid;
    [self presentViewController:obj_new animated:YES completion:nil];
    
    rightmenu_mainview.hidden=YES;
    
}

- (IBAction)mappage_tap:(id)sender {
    
    if (user_latlong.length>5)
    {
        SearchMapController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"map"];
        
        obj.check_lat_lon = user_latlong;
        
        [self.navigationController pushViewController:obj animated:NO];
    }
    
}

- (IBAction)booknowbtn_tap:(id)sender
{
//   UIButton *btn = (UIButton*)sender;
//    
//    PaymentBookingController *paymentbooking = [self.storyboard instantiateViewControllerWithIdentifier:@"paymentbooking"];
//    
//    paymentbooking.data=[NSMutableArray new];
//    paymentbooking.data=[servicelist objectAtIndex:btn.tag];
//    [self.navigationController pushViewController:paymentbooking animated:YES];
}

@end
