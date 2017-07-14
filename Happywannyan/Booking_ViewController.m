//
//  Booking_ViewController.m
//  Happywannyan_App
//
//  Created by Kausik_Jati on 22/05/17.
//  Copyright © 2017 Kausik_Jati. All rights reserved.
//

#import "Booking_ViewController.h"
#import "BookingDetailsViewController.h"
#import "leftmenu.h"
#import "Json_Class.h"
#import "UIImageView+WebCache.h"
#import "Language_class.h"

@interface Booking_ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    leftmenu *leftMenu_obj;
    Json_Class *url_obj;
    NSDictionary *user_info;
    
}

@end

@implementation Booking_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    leftMenu_obj = [[leftmenu alloc]init];
    
    
    [leftMenu_obj Leftmenu:self sideMenu:leftMenu_obj];
    
    user_info = [[Language_class new] language];
    // Do any additional setup after loading the view.
    
    header_lbl.text=[user_info valueForKey:@"booking"];
    nodata_lbl.text=[user_info valueForKey:@"nodata_lbl"];
    
    
    
    
    
    booking_ary=[[NSMutableArray alloc]init];
    
    
    
    btn_ary=[[NSMutableArray alloc]initWithObjects:@{@"name":[user_info valueForKey:@"upcoming"]},@{@"name":[user_info valueForKey:@"current"]},@{@"name":[user_info valueForKey:@"pending"]},@{@"name":[user_info valueForKey:@"past"]},nil];
    
    
    
    
    booking_scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, header_view.frame.origin.y+header_view.frame.size.height, self.view.frame.size.width, 50)];
    int x = 0;
    for (int i = 0; i < btn_ary.count; i++)
    {
        
        CGSize size = [[[btn_ary objectAtIndex:i]valueForKey:@"name"] sizeWithAttributes:
                       @{NSFontAttributeName:
                             [UIFont fontWithName:@"PingFang SC" size:13.0f]}];
        
        //UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
      UIButton  *button = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, size.width+11, 50)];
        
        [button setTitle:[NSString stringWithFormat:@"%@", [[btn_ary objectAtIndex:i] valueForKey:@"name"]] forState:UIControlStateNormal];
        
        button.titleLabel.font=[UIFont fontWithName:@"PingFang SC" size:13.0f];
        
        [button setTitleColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        button.tag=i;
        
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        if (button.tag==0)
        {
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        [booking_scroll addSubview:button];
        
        x += button.frame.size.width;
        
        [booking_scroll setShowsHorizontalScrollIndicator:NO];
        
        
        
        
        
        
    }
    
    
    
    
    
    booking_scroll.contentSize = CGSizeMake(x, booking_scroll.frame.size.height);
    [self.view addSubview:booking_scroll];
    
    booking_tbl.frame=CGRectMake(0,booking_scroll.frame.origin.y+booking_scroll.frame.size.height,booking_tbl.frame.size.width,booking_tbl.frame.size.height);
    booking_tbl.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    
    
    nodata_lbl.hidden=YES;
    
    bookingapi_str=@"upcoming_booking_list";
    [self urldata:bookingapi_str page:@"0"];
    
    
}

- (IBAction)sidemenu:(id)sender {
}




-(IBAction)click:(id)sender
{
    UIButton *tap = (UIButton *)sender;
    //    NSLog(@"%d",tap.tag);
    [tap setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    for(UIButton *view in [booking_scroll subviews]){
        if([view isKindOfClass:[UIButton class]]){
            if(view != tap){
                UIButton* btn1 = (UIButton*) view;
                [btn1 setTitleColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0] forState:UIControlStateNormal];
                
            }
        }
    }
    if (tap.tag==0) {
        if (![bookingapi_str isEqualToString:@"upcoming_booking_list"])
        {
            //[booking_ary removeAllObjects];
            bookingapi_str=@"upcoming_booking_list";
            [self urldata:bookingapi_str page:@"0"];
        }
    }
    else if (tap.tag==1) {
        if (![bookingapi_str isEqualToString:@"current_booking_list"])
        {
            //[booking_ary removeAllObjects];
            bookingapi_str=@"current_booking_list";
            [self urldata:bookingapi_str page:@"0"];
            
        }
    }
    else if (tap.tag==2) {
        if (![bookingapi_str isEqualToString:@"pending_booking_list"])
        {
            // [booking_ary removeAllObjects];
            bookingapi_str=@"pending_booking_list";
            [self urldata:bookingapi_str page:@"0"];
            
        }
    }
    else if (tap.tag==3) {
        if (![bookingapi_str isEqualToString:@"past_booking_list"])
        {
            // [booking_ary removeAllObjects];
            bookingapi_str=@"past_booking_list";
            [self urldata:bookingapi_str page:@"0"];
        }
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return booking_ary.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    CELL=[booking_tbl dequeueReusableCellWithIdentifier:@"Booking"forIndexPath:indexPath];
    
    CELL.user_img.layer.cornerRadius = 4;
    CELL.user_img.clipsToBounds = YES;
    
    [CELL.user_img sd_setImageWithURL:[NSURL URLWithString:[[[booking_ary objectAtIndex:indexPath.row]valueForKey:@"users_profile"] valueForKey:@"booked_user_image"]] placeholderImage:[UIImage imageNamed:@"new-user-image-default"]];
    
    CELL.name_lbl.text=[[[booking_ary objectAtIndex:indexPath.row]valueForKey:@"users_profile"]valueForKey:@"custom_quotes"];
    CELL.subname_lbl.text=[[[booking_ary objectAtIndex:indexPath.row]valueForKey:@"users_profile"]valueForKey:@"booked_user_name"];
    CELL.startdate_lbl.text=[[[booking_ary objectAtIndex:indexPath.row]valueForKey:@"booking_info"]valueForKey:@"booking_start_date"];
    CELL.enddate_lbl.text=[[[booking_ary objectAtIndex:indexPath.row]valueForKey:@"booking_info"]valueForKey:@"booking_end_date"];
    CELL.bookingid_lbl.text=[[[booking_ary objectAtIndex:indexPath.row]valueForKey:@"booking_info"]valueForKey:@"booking_id"];
    CELL.service_lbl.text=[[[booking_ary objectAtIndex:indexPath.row]valueForKey:@"booking_info"]valueForKey:@"booking_service"];
    CELL.totalpets_lbl.text=[[[booking_ary objectAtIndex:indexPath.row]valueForKey:@"booking_info"]valueForKey:@"booked_total_pet"];
    CELL.totalamount_lbl.text=[[[booking_ary objectAtIndex:indexPath.row]valueForKey:@"booking_info"]valueForKey:@"booked_total_amount"];
    
    
    CELL.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    if (booking_ary.count-1==indexPath.row)
    {
        if (![start_form isEqualToString:@"0"])
        {
            
            [self urldata:bookingapi_str page:start_form];
            
        }
    }
    
    
    
    return CELL;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // bookingdetails
    
    BookingDetailsViewController *obj =[self.storyboard instantiateViewControllerWithIdentifier:@"bookingdetails"];
    [self.navigationController pushViewController:obj animated:YES];
}

-(void)urldata:(NSString *)api page:(NSString *)page_new
{
    
    url_obj=[Json_Class new];
    
    NSString *url_str=[NSString stringWithFormat:@"%@%@?user_id=%@&lang_id=%@&start_form=%@&per_page=10&user_timezone=%@",App_Domain_Url,api,[[NSUserDefaults standardUserDefaults]valueForKey:@"userid"],[[NSUserDefaults standardUserDefaults]valueForKey:@"lan_code"],page_new,[NSTimeZone systemTimeZone].name];
    NSString *urlUTF8=[url_str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
    
    [request setURL:[NSURL URLWithString:urlUTF8]];
    
    [url_obj GlobalDict:request Globalstr:@"array" lodaer:YES Withblock:^(id result, NSError *error) {
        
        NSLog(@"%@",result);
        NSString *response = [NSString stringWithFormat:@"%@",[result valueForKey:@"response"]];
        
        if ([response isEqualToString:@"1"])
        {
            
            nodata_lbl.hidden=YES;
            
            if ([page_new isEqualToString:@"0"])
                
            {
                
                [booking_ary removeAllObjects];
                
                [booking_tbl reloadData];
                
            }
            
            [self insertDownloadedActions:[result valueForKey:@"booking_info_array"] table:booking_tbl];
            
            start_form=[NSString stringWithFormat:@"%@", [result valueForKey:@"start_form"]];
            
            
        }
        else
        {
            [booking_ary removeAllObjects];
            [booking_tbl reloadData];
            nodata_lbl.hidden=NO;
        }
    }];
    
}


-(void)insertDownloadedActions:(NSMutableArray *)dataToAdd table:(UITableView *)table
{
    
    int64_t delayInSeconds = 0.2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
        
        // build the index paths for insertion
        // since you're adding to the end of datasource, the new rows will start at count
        NSMutableArray *indexPaths = [NSMutableArray array];
        NSInteger currentCount = booking_ary.count;
        for (int i = 0; i < dataToAdd.count; i++) {
            
            [indexPaths addObject:[NSIndexPath indexPathForRow:currentCount+i inSection:0]];
        }
        
        // do the insertion
        [booking_ary addObjectsFromArray:dataToAdd];
        
        // tell the table view to update (at all of the inserted index paths)
        
        // [table reloadData];
        [table beginUpdates];
        [table insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
        [table endUpdates];
    });
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

- (IBAction)menubtn:(UIButton *)sender {
    
    [leftMenu_obj lefMenuopen:sender];
    
}
@end
