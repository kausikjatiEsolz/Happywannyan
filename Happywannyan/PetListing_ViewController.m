//
//  PetListing_ViewController.m
//  Happywannyan_App
//
//  Created by Kausik_Jati on 18/05/17.
//  Copyright © 2017 Kausik_Jati. All rights reserved.
//

#import "PetListing_ViewController.h"
#import "SearchMapController.h"
#import "Search_ViewController.h"
#import "UIImageView+WebCache.h"
#import "CardController.h"
#import "Profile@1_ViewController.h"

@interface PetListing_ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation PetListing_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    text_font=[UIFont fontWithName:@"PingFang SC" size:12];
    
    _backPOP = [[UIButton alloc]init];
    _backPOP.tag=0;
    
    petlisting_tbl.backgroundColor=[UIColor colorWithRed:(250/255.0) green:(250/255.0) blue:(250/255.0) alpha:1];
    
    
    petlisting_tbl.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    
    map_btn.hidden=NO;
    cardview_btn.hidden=NO;
    
    
    _api_ary = [[NSUserDefaults standardUserDefaults] valueForKey:@"result"];
    
    
    
    
    
    _header_lbl.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"search_location"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _api_ary.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    CELL=[petlisting_tbl dequeueReusableCellWithIdentifier:@"PetListing"forIndexPath:indexPath];
    
    CELL.name_lbl.text=[[_api_ary objectAtIndex:indexPath.row]valueForKey:@"nickname"];
    CELL.subname_lbl.text=[[_api_ary objectAtIndex:indexPath.row]valueForKey:@"business_name"];
    
    CELL.main_image.layer.cornerRadius=4;
    CELL.main_image.clipsToBounds=YES;
    
    [CELL.main_image sd_setImageWithURL:[NSURL URLWithString:[[_api_ary objectAtIndex:indexPath.row]valueForKey:@"photo_url"]] placeholderImage:[UIImage imageNamed:@"new-user-image-default"] options:SDWebImageTransformAnimatedImage];
    
    CELL.location_lbl.text=[[_api_ary objectAtIndex:indexPath.row]valueForKey:@"whole_address"];
    CELL.comment_lbl.text=[[_api_ary objectAtIndex:indexPath.row]valueForKey:@"Profile_summary"];
    
    CELL.service_name_all.text = [[_api_ary objectAtIndex:indexPath.row]valueForKey:@"service_name_all"];
    
    
    CELL.review_lbl.text = [NSString stringWithFormat:@"%@ Reviews",[[_api_ary objectAtIndex:indexPath.row]valueForKey:@"num_rvw"]];
    
    CELL.price.text = [NSString stringWithFormat:@"¥ %@",[[_api_ary objectAtIndex:indexPath.row]valueForKey:@"price_one"]];//[price_one][
    
    
    for (UIImageView *star in CELL.starview.subviews)
    {
        if ([star isKindOfClass:[UIImageView class]])
        {
            if (star.tag<=[[[_api_ary objectAtIndex:indexPath.row]valueForKey:@"ave_rating"] intValue])
            {
                star.image = [UIImage imageNamed:@"favorite"];
            }
            else
            {
                star.image = [UIImage imageNamed:@"star"];
            }
        }
    }
    
    
    CELL.selectionStyle=UITableViewCellSelectionStyleNone;
    
    CELL.main_view.backgroundColor=[UIColor whiteColor];
    UIColor *color = [UIColor blackColor];
    CELL.main_view.layer.shadowColor = [color CGColor];
    CELL.main_view.layer.shadowRadius = 1.0f;
    CELL.main_view.layer.shadowOpacity = 0.2;
    CELL.main_view.layer.shadowOffset = CGSizeZero;
    CELL.main_view.layer.masksToBounds = NO;
    
    CELL.backgroundColor=[UIColor colorWithRed:(250/255.0) green:(250/255.0) blue:(250/255.0) alpha:1];
    
    return CELL;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Profile_1_ViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"profile"];
    obj.sitterid = [[_api_ary objectAtIndex:indexPath.row]valueForKey:@"sitter_user_id"];
    [self.navigationController pushViewController:obj animated:YES];
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    CGSize size_=[self findHeightForText:[[_api_ary objectAtIndex:indexPath.row]valueForKey:@"Profile_summary"] havingWidth:petlisting_tbl.frame.size.width andFont:text_font];
    //
    //    return size_.height+10+10+10+10+5+5+120;
    
    
    return 249.0f;
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    //    CELL.comment_lbl.frame=CGRectMake(25,CELL.main_image.frame.origin.y+CELL.main_image.frame.size.height +10, CELL.comment_lbl.frame.size.width,[self findHeightForText:[[_api_ary objectAtIndex:indexPath.row]valueForKey:@"Profile_summary"] havingWidth:petlisting_tbl.frame.size.width andFont:text_font].height);
    //
    //    CELL.comment_lbl.font=[UIFont fontWithName:@"PingFang SC" size:11.0f];
    //    CELL.comment_lbl.numberOfLines = 999;
    //    CELL.comment_lbl.lineBreakMode= NSLineBreakByWordWrapping;
    //    CELL.comment_lbl.text=[[_api_ary objectAtIndex:indexPath.row]valueForKey:@"Profile_summary"];
    //
    //    CELL.lbl.frame=CGRectMake(25,CELL.comment_lbl.frame.origin.y + CELL.comment_lbl.frame.size.height +15, CELL.comment_lbl.frame.size.width,1);
    //    CELL.lbl.backgroundColor=[UIColor colorWithRed:(204/255.0) green:(204/255.0) blue:(204/255.0) alpha:1];
    //
    //
    //    CELL.location_view.frame=CGRectMake(13,CELL.comment_lbl.frame.origin.y+CELL.comment_lbl.frame.size.height+25 , CELL.location_view.frame.size.width, CELL.location_view.frame.size.height);
    //
    //    CELL.main_view.frame=CGRectMake(5,3, CELL.frame.size.width-10, CELL.frame.size.height);
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
    
    //[self.navigationController popViewControllerAnimated:YES];
    
    Search_ViewController *search;
    
    for (UIViewController *obj in self.navigationController.viewControllers.reverseObjectEnumerator)
    {
        if ([obj isKindOfClass:[Search_ViewController class]])
        {
            
            search = (Search_ViewController *) obj;
            
            break;
        }
    }
    
    search.filter = @"";
    
    [self.navigationController popToViewController:search animated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //    if (_backPOP.tag ==1)
    //    {
    //        [self.navigationController popViewControllerAnimated:YES];
    //    }
}

- (IBAction)mapPage:(UIButton *)sender {
    
    
    SearchMapController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"map"];
    
    obj.backPOPback = self.backPOP;
    //obj.data_Array= _api_ary;
    
    
    
    [self.navigationController pushViewController:obj animated:NO];
    
    
    
}

- (IBAction)cardviewPage:(id)sender {
    
    
    
    self.backPOP.tag=2;
    
    CardController *obj_new=[self.storyboard instantiateViewControllerWithIdentifier:@"card"];
    obj_new.backPOPback = self.backPOP;
    [self.navigationController pushViewController:obj_new animated:NO];
}

- (IBAction)expand:(id)sender {
    
    if (map_btn.hidden==YES) {
        [UIView animateWithDuration:0.3f animations:^{
            map_btn.frame=CGRectMake(map_btn.frame.origin.x,expand_button.frame.origin.y-expand_button.frame.size.height,map_btn.frame.size.width,map_btn.frame.size.height);
            map_btn.hidden=NO;
            cardview_btn.frame=CGRectMake(cardview_btn.frame.origin.x, expand_button.frame.origin.y-expand_button.frame.size.height-expand_button.frame.size.height, cardview_btn.frame.size.width, cardview_btn.frame.size.height);
            cardview_btn.hidden=NO;
            [expand_button setImage:[UIImage imageNamed:@"Group 4-1"] forState:UIControlStateNormal];
        }];
    }
    else
    {
        [UIView animateWithDuration:0.3f animations:^{
            
            
            map_btn.frame=CGRectMake(map_btn.frame.origin.x,expand_button.frame.origin.y,map_btn.frame.size.width,map_btn.frame.size.height);
            cardview_btn.frame=CGRectMake(cardview_btn.frame.origin.x, expand_button.frame.origin.y, cardview_btn.frame.size.width, cardview_btn.frame.size.height);
            [expand_button setImage:[UIImage imageNamed:@"Group 4-3"] forState:UIControlStateNormal];
        }completion:^(BOOL finished) {
            cardview_btn.hidden=YES;
            map_btn.hidden=YES;
        }];
    }
    
}



//-(void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//
//
//    [UIView animateWithDuration:0.3f animations:^{
//
//
//        map_btn.frame=CGRectMake(map_btn.frame.origin.x,expand_button.frame.origin.y,map_btn.frame.size.width,map_btn.frame.size.height);
//        cardview_btn.frame=CGRectMake(cardview_btn.frame.origin.x, expand_button.frame.origin.y, cardview_btn.frame.size.width, cardview_btn.frame.size.height);
//        [expand_button setImage:[UIImage imageNamed:@"Group 4-3"] forState:UIControlStateNormal];
//    }completion:^(BOOL finished) {
//        cardview_btn.hidden=NO;
//        map_btn.hidden=NO;
//    }];
//
//}
- (IBAction)filter:(UIButton *)sender {
    
    
    
    Search_ViewController *search;
    
    for (UIViewController *obj in self.navigationController.viewControllers.reverseObjectEnumerator)
    {
        if ([obj isKindOfClass:[Search_ViewController class]])
        {
            
            search = (Search_ViewController *) obj;
            
            break;
        }
    }
    
    search.filter = @"filter";
    
    [self.navigationController popToViewController:search animated:NO];
    
}
@end
