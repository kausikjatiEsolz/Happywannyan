//
//  FavoriteSittersController.m
//  Happywannyan
//
//  Created by Kausik_Jati on 21/06/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import "FavoriteSittersController.h"
#import "FavoriteSittersCell.h"
#import "WanNyanMeetUpController.h"
#import "ContactController.h"
#import "UIImageView+WebCache.h"
#import "leftmenu.h"
#import "Profile@1_ViewController.h"

@interface FavoriteSittersController ()
{
    leftmenu *leftMenu_obj;
}
@end

@implementation FavoriteSittersController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    url_obj=[Json_Class new];
    
    
    leftMenu_obj=[[leftmenu alloc]init];
    
    [leftMenu_obj Leftmenu:self sideMenu:leftMenu_obj];
    
    
    api_ary=[[NSMutableArray alloc]init];
    
    nodata_lbl.hidden=YES;
    
    
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"favourite"] isEqualToString:@"6"]) {
        
        [self urldata:@"users_favsetters_list" page:@"0"];
        header_lbl.text=@"Favourite Sitters";
    }
    else
    {
        [self urldata:@"users_setters_list" page:@"0"];
        header_lbl.text=@"Past Sitters";
    }
    
    
    
    
    
    
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return api_ary.count;
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CELL=[favoritesitters_table dequeueReusableCellWithIdentifier:@"favoritesitters"forIndexPath:indexPath];
    
    
    CELL.selectionStyle=UITableViewCellSelectionStyleNone;
    
    CELL.main_img.layer.cornerRadius=4;
    
    [CELL.main_img sd_setImageWithURL:[NSURL URLWithString:[[api_ary objectAtIndex:indexPath.row]valueForKey:@"image"] ] placeholderImage:[UIImage imageNamed:@"new-user-image-default"]];
    
    CELL.name_lbl.text=[[api_ary objectAtIndex:indexPath.row]valueForKey:@"full_name"];
    
    CELL.address_lbl.text=[[api_ary objectAtIndex:indexPath.row]valueForKey:@"location"];
    
    CELL.contact_btn.tag=indexPath.row;
    
    //[CELL.meetup_btn addTarget:self action:@selector(meetupbtn_tap:) forControlEvents:UIControlEventTouchUpInside];
    
    [CELL.contact_btn addTarget:self action:@selector(contactbtn_tap:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if (api_ary.count-1==indexPath.row)
    {
        if (![start_form isEqualToString:@"0"])
        {
            
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"favourite"] isEqualToString:@"6"]) {
                
                [self urldata:@"users_favsetters_list" page:start_form];
            }
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"favourite"] isEqualToString:@"7"]) {
                
                [self urldata:@"users_setters_list" page:start_form];
            }
        }
    }
    
    
    return CELL;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    Profile_1_ViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"profile"];
    obj.sitterid = [[api_ary objectAtIndex:indexPath.row]valueForKey:@"sitter_user_id"];
    [self.navigationController pushViewController:obj animated:YES];
    
    
}


-(void)urldata:(NSString *)api page:(NSString *)page_new
{
    NSString *url_str=[NSString stringWithFormat:@"%@%@?user_id=%@&start_form=%@&per_page=10",App_Domain_Url,api,[[NSUserDefaults standardUserDefaults]valueForKey:@"userid"],page_new];
    NSString *urlUTF8=[url_str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
    
    [request setURL:[NSURL URLWithString:urlUTF8]];
    
    [url_obj GlobalDict:request Globalstr:@"array" lodaer:YES Withblock:^(id result, NSError *error) {
        
        NSLog(@"%@",result);
        NSString *response = [NSString stringWithFormat:@"%@",[result valueForKey:@"response"]];
        
        if ([response isEqualToString:@"1"])
        {
            
            nodata_lbl.hidden=YES;
            
            [self insertDownloadedActions:[result valueForKey:@"info_array"] table:favoritesitters_table];
            
            start_form=[NSString stringWithFormat:@"%@", [result valueForKey:@"start_form"]];
            
            //   [favoritesitters_table reloadData];
            
        }
        else
        {
            //            [booking_ary removeAllObjects];
            //            [booking_tbl reloadData];
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
        NSInteger currentCount = api_ary.count;
        for (int i = 0; i < dataToAdd.count; i++) {
            
            [indexPaths addObject:[NSIndexPath indexPathForRow:currentCount+i inSection:0]];
        }
        
        // do the insertion
        [api_ary addObjectsFromArray:dataToAdd];
        
        // tell the table view to update (at all of the inserted index paths)
        [table beginUpdates];
        [table insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
        [table endUpdates];
    });
}



-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"          "  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        
        
        
        UIAlertController *deleteAlert = [UIAlertController alertControllerWithTitle:@"Delete?" message:@"Are you sure you want to delete this?" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * alert_action){
            
            
            [tableView beginUpdates];
            
            [favoritesitters_table deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            [api_ary removeObjectAtIndex:indexPath.row];
            
            
            [tableView endUpdates];
            
            
            if (api_ary == nil || api_ary.count == 0) {
                
                nodata_lbl.hidden=NO;
            }
            
            
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            
        }];
        
        [deleteAlert addAction:okAction];
        [deleteAlert addAction:cancelAction];
        [self presentViewController:deleteAlert animated:YES completion:nil];
    }];
    
    UITableViewCell *commentCell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    CGFloat height = commentCell.frame.size.height;
    
    UIImage *backgroundImage = [self deleteImageForHeight:height];
    
    
    deleteAction.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
    return @[deleteAction];
}
- (UIImage*)deleteImageForHeight:(CGFloat)height{
    
    CGRect frame = CGRectMake(0, 0, 62, height);
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(62, height), NO, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, frame);
    
    UIImage *image = [UIImage imageNamed:@"delete"];
    
    [image drawInRect:CGRectMake(frame.size.width/2.0 - 5, frame.size.height/2.0 - 20, 30,30)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
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

//- (IBAction)back:(id)sender {
//
//    [self.navigationController popViewControllerAnimated:YES];
//
//
//}
//-(IBAction)meetupbtn_tap:(id)sender
//{
//    WanNyanMeetUpController *obj_new=[self.storyboard instantiateViewControllerWithIdentifier:@"wannyanmeetup"];
//    [self presentViewController:obj_new animated:YES completion:nil];
//}

-(IBAction)contactbtn_tap:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    
    ContactController *obj=[self.storyboard instantiateViewControllerWithIdentifier:@"contact"];
    obj.sitterid = [[api_ary objectAtIndex:btn.tag]valueForKey:@"sitter_user_id"];
    [self presentViewController:obj animated:YES completion:nil];
}
- (IBAction)menu:(id)sender {
    
    [leftMenu_obj lefMenuopen:sender];
}
@end
