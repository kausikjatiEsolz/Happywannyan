//
//  Messages_ViewController.m
//  Happywannyan_App
//
//  Created by Kausik_Jati on 22/05/17.
//  Copyright © 2017 Kausik_Jati. All rights reserved.
//

#import "Messages_ViewController.h"
#import "leftmenu.h"
#import "UIImageView+WebCache.h"
#import "Language_class.h"
#import "ChatViewController.h"

@interface Messages_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    leftmenu *leftMenu_obj;
    NSDictionary *user_info;
}

@end

@implementation Messages_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    user_info = [[Language_class new] language];
    leftMenu_obj = [[leftmenu alloc]init];
    
    [leftMenu_obj Leftmenu:self sideMenu:leftMenu_obj];
    
    header_lbl.text=[user_info valueForKey:@"messages"];
    nodata_lbl.text=[user_info valueForKey:@"nodata_lbl"];
    
    
    allmsg_ary=[[NSMutableArray alloc]init];
    
    
    btn_ary=[[NSMutableArray alloc]initWithObjects:@{@"name":[user_info valueForKey:@"allmessages"]},@{@"name":[user_info valueForKey:@"reservation"]},@{@"name":[user_info valueForKey:@"general"]},nil];
    
    message_scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, header_view.frame.origin.y+header_view.frame.size.height, self.view.frame.size.width, 50)];
    
    //horizontal scroll with button
    
    int x = 0;
    for (int i = 0; i < btn_ary.count; i++)
    {
        
        CGSize size = [[[btn_ary objectAtIndex:i] valueForKey:@"name"] sizeWithAttributes:
                       @{NSFontAttributeName:
                             [UIFont fontWithName:@"PingFang SC" size:13.0f]}];
        
        //UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, size.width+11, 50)];
        
        
        [button setTitle:[NSString stringWithFormat:@"%@", [[btn_ary objectAtIndex:i] valueForKey:@"name"]] forState:UIControlStateNormal];
        
        button.titleLabel.font=[UIFont fontWithName:@"PingFang SC" size:13.0f];
        
        
        [button setTitleColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:.75] forState:UIControlStateNormal];
        
        
        button.tag=i;
        
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        if (button.tag==0)
        {
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        [message_scroll addSubview:button];
        
        x += button.frame.size.width;
        
        [message_scroll setShowsHorizontalScrollIndicator:NO];
        
        
    }
    
    message_scroll.contentSize = CGSizeMake(x, message_scroll.frame.size.height);
    [self.view addSubview:message_scroll];
    
    message_tbl.frame=CGRectMake(0,message_scroll.frame.origin.y+message_scroll.frame.size.height,message_tbl.frame.size.width,message_tbl.frame.size.height);
    
    message_tbl.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    
    nodata_lbl.hidden=YES;
    
    msg_section=@"all_message_list";
    
    [self urlData:msg_section page:@"0"];
    
    
    
}

-(IBAction)click:(id)sender
{
    UIButton *tap = (UIButton *)sender;
    NSLog(@"%ld",(long)tap.tag);
    [tap setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    for(UIButton *view in [message_scroll subviews])
    {
        if([view isKindOfClass:[UIButton class]])
        {
            if(view != tap)
            {
                UIButton* btn1 = (UIButton*) view;
                [btn1 setTitleColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:.75] forState:UIControlStateNormal];
                
            }
        }
    }
    
    if (tap.tag==0) {
        if (![msg_section isEqualToString:@"all_message_list"]) {
            msg_section=@"all_message_list";
            [self urlData:msg_section page:@"0"];
        }
        
    }
    //    if (tap.tag==1) {
    //        if (![msg_section isEqualToString:@"unread_message_list"]) {
    //            msg_section=@"unread_message_list";
    //            [self urlData:msg_section page:@"0"];
    //        }
    //
    //    }
    //    if (tap.tag==2) {
    //        if (![msg_section isEqualToString:@"unrespond_message_list"]) {
    //            msg_section=@"unrespond_message_list";
    //            [self urlData:msg_section page:@"0"];
    //
    //        }
    //            }
    if (tap.tag==1) {
        if (![msg_section isEqualToString:@"reservation_message_list"]) {
            msg_section=@"reservation_message_list";
            [self urlData:msg_section page:@"0"];
        }
        
    }
    //    if (tap.tag==4) {
    //        if (![msg_section isEqualToString:@"meetgreet_message_list"]) {
    //            msg_section=@"meetgreet_message_list";
    //            [self urlData:msg_section page:@"0"];
    //        }
    //            }
    if (tap.tag==2) {
        
        
        if (![msg_section isEqualToString:@"generalinquiry_message_list"])
        {
            msg_section=@"generalinquiry_message_list";
            [self urlData:msg_section page:@"0"];
        }
        
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return allmsg_ary.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    CELL=[message_tbl dequeueReusableCellWithIdentifier:@"Messages"forIndexPath:indexPath];
    CELL.user_img.layer.cornerRadius = 4;
    CELL.user_img.clipsToBounds = YES;
    
    CELL.name_lbl.text=[[allmsg_ary objectAtIndex:indexPath.row]valueForKey:@"message_type"];
    CELL.subname_lbl.text=[[allmsg_ary objectAtIndex:indexPath.row]valueForKey:@"usersname"];
    
    CELL.time_lbl.text=[NSString stringWithFormat:@"%@ ago",[[allmsg_ary objectAtIndex:indexPath.row]valueForKey:@"time_difference"]];
    CELL.comment_lbl.text=[[allmsg_ary objectAtIndex:indexPath.row]valueForKey:@"message_info"];
    [CELL.user_img sd_setImageWithURL:[NSURL URLWithString:[[allmsg_ary objectAtIndex:indexPath.row]valueForKey:@"usersimage"]] placeholderImage:[UIImage imageNamed:@"new-user-image-default"]];
    
    
    CELL.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    if (allmsg_ary.count-1 == indexPath.row)
    {
        if (![start_form isEqualToString:@"0"]) {
            
            [self urlData:msg_section page:start_form];
            
        }
        
    }
    return CELL;
}


-(void)urlData:(NSString *)api page:(NSString *)page
{
    url_obj=[Json_Class new];
    
    
    NSString *url_str=[NSString stringWithFormat:@"%@%@?user_id=%@&lang_id=%@&start_form=%@&per_page=10&user_timezone=%@",App_Domain_Url,api,[[NSUserDefaults standardUserDefaults]valueForKey:@"userid"],[[NSUserDefaults standardUserDefaults]valueForKey:@"lan_code"],page,[NSTimeZone systemTimeZone].name];
    
    NSString *urlUTF8=[url_str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
    
    [request setURL:[NSURL URLWithString:urlUTF8]];
    
    [url_obj GlobalDict:request Globalstr:@"array" lodaer:YES Withblock:^(id result, NSError *error) {
        
        
        NSLog(@"%@",result);
        NSString *response = [NSString stringWithFormat:@"%@",[result valueForKey:@"response"]];
        
        if ([response isEqualToString:@"1"]) {
            
            
            
            if ([[result valueForKey:@"all_message"] count]==0)
            {
                [allmsg_ary removeAllObjects];
                nodata_lbl.hidden=NO;
            }
            else
            {
                nodata_lbl.hidden=YES;
            }
            
            
            
            if ([page isEqualToString:@"0"])
            {
                [allmsg_ary removeAllObjects];
                
                [message_tbl reloadData];
            }
            
            // [allmsg_ary addObjectsFromArray:[result valueForKey:@"all_message"]];
            
            
            [self insertDownloadedActions:[result valueForKey:@"all_message"] table:message_tbl];
            
            start_form=[NSString stringWithFormat:@"%@", [result valueForKey:@"start_form"]];
            
            
            
            
        }
        else
        {
            [allmsg_ary removeAllObjects];
            nodata_lbl.hidden=NO;
            [message_tbl reloadData];
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
        NSInteger currentCount = allmsg_ary.count;
        for (int i = 0; i < dataToAdd.count; i++) {
            
            [indexPaths addObject:[NSIndexPath indexPathForRow:currentCount+i inSection:0]];
        }
        
        // do the insertion
        [allmsg_ary addObjectsFromArray:dataToAdd];
        
        // tell the table view to update (at all of the inserted index paths)
        
        // [table reloadData];
        [table beginUpdates];
        [table insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
        [table endUpdates];
    });
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"chat"];
    [self.navigationController pushViewController:obj animated:YES];
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

- (IBAction)menu:(UIButton *)sender {
    
    [leftMenu_obj lefMenuopen:sender];
    
}
@end
