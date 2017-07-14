//
//  ChatViewController.m
//  Happywannyan
//
//  Created by Kausik_Jati on 02/06/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import "ChatViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Json_Class.h"

#define RGB(r, g, b)	 [UIColor colorWithRed: (r) / 255.0 green: (g) / 255.0 blue: (b) / 255.0 alpha : 1]
#define RGBNEW(r, g, b)	 [UIColor colorWithRed: (r) / 255.0 green: (g) / 255.0 blue: (b) / 255.0 alpha : .2]

@interface ChatViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *array;
    
    UIFont *font_name;
    
    Json_Class *obj;
    

}

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //master
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    array = [NSMutableArray new];
    
    obj = [Json_Class new];
    
    
    font_name = [UIFont fontWithName:@"PingFang SC" size:14];
    
    
    /*
    NSArray *new = [[NSArray alloc]initWithObjects:@{@"id":@"3",@"user":@"S",@"msg":@"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",@"image":@""},@{@"id":@"3",@"user":@"R",@"msg":@"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",@"image":@""},@{@"id":@"3",@"user":@"S",@"msg":@"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",@"image":@""}, nil];
    NSArray *new1 = [[NSArray alloc]initWithObjects:@{@"id":@"2",@"user":@"R",@"msg":@"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since theLorem Ipsum has been the industry's standard dummy text ever since the 1500s",@"image":@"photo_sample_01"},@{@"id":@"2",@"user":@"S",@"msg":@"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since theLorem Ipsum has been the industry's standard dummy text ever since the 1500s Lorem Ipsum has been the industry's standard dummy text ever since theLorem Ipsum has been the industry's standard dummy text ever since the 1500s Lorem Ipsum has been the industry's standard dummy text ever since theLorem Ipsum has been the industry's standard dummy text ever since the 1500s Lorem Ipsum has been the industry's standard dummy text ever since theLorem Ipsum has been the industry's standard dummy text ever since the 1500s Lorem Ipsum has been the industry's standard dummy text ever since theLorem Ipsum has been the industry's standard dummy text ever since the 1500s Lorem Ipsum has been the industry's standard dummy text ever since theLorem Ipsum has been the industry's standard dummy text ever since the 1500s",@"image":@"photo_sample_01"},@{@"id":@"2",@"user":@"R",@"msg":@"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since theLorem Ipsum has been the industry's standard dummy text ever since the 1500sLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since theLorem Ipsum has been the industry's standard dummy text ever since the 1500sLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since theLorem Ipsum has been the industry's standard dummy text ever since the 1500sLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since theLorem Ipsum has been the industry's standard dummy text ever since the 1500sLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since theLorem Ipsum has been the industry's standard dummy text ever since the 1500sLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since theLorem Ipsum has been the industry's standard dummy text ever since the 1500sLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since theLorem Ipsum has been the industry's standard dummy text ever since the 1500sLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since theLorem Ipsum has been the industry's standard dummy text ever since the 1500sLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since theLorem Ipsum has been the industry's standard dummy text ever since the 1500sLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since theLorem Ipsum has been the industry's standard dummy text ever since the 1500sLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since theLorem Ipsum has been the industry's standard dummy text ever since the 1500s",@"image":@"photo_sample_01"}, nil];
    NSArray *new2 = [[NSArray alloc]initWithObjects:@{@"id":@"3",@"user":@"S",@"msg":@"",@"image":@"photo_sample_03"},@{@"id":@"3",@"user":@"S",@"msg":@"",@"image":@"photo_sample_04"},@{@"id":@"2",@"user":@"R",@"msg":@"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since theLorem Ipsum has been the industry's standard dummy text ever since the 1500s",@"image":@"photo_sample_01"},@{@"id":@"3",@"user":@"R",@"msg":@"",@"image":@"photo_sample_03"},@{@"id":@"3",@"user":@"S",@"msg":@"",@"image":@"photo_sample_04"},@{@"id":@"2",@"user":@"R",@"msg":@"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since theLorem Ipsum has been the industry's standard dummy text ever since the 1500s",@"image":@"photo_sample_01"}, nil];
    NSArray *new3 = [[NSArray alloc]initWithObjects:@{@"id":@"2",@"user":@"R",@"msg":@"",@"image":@"photo_sample_02"},@{@"id":@"2",@"user":@"R",@"msg":@"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since theLorem Ipsum has been the industry's standard dummy text ever since the 1500s",@"image":@"photo_sample_01"},@{@"id":@"2",@"user":@"R",@"msg":@"",@"image":@"photo_sample_02"},@{@"id":@"2",@"user":@"R",@"msg":@"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since theLorem Ipsum has been the industry's standard dummy text ever since the 1500s",@"image":@"photo_sample_01"},@{@"id":@"2",@"user":@"R",@"msg":@"",@"image":@"photo_sample_02"},@{@"id":@"2",@"user":@"R",@"msg":@"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since theLorem Ipsum has been the industry's standard dummy text ever since the 1500s",@"image":@"photo_sample_01"},@{@"id":@"2",@"user":@"R",@"msg":@"",@"image":@"photo_sample_02"},@{@"id":@"2",@"user":@"R",@"msg":@" 1500s",@"image":@"photo_sample_01"},@{@"id":@"2",@"user":@"S",@"msg":@"",@"image":@"photo_sample_02"},@{@"id":@"2",@"user":@"R",@"msg":@"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since theLorem Ipsum has been the industry's standard dummy text ever since the 1500s",@"image":@"photo_sample_01"},@{@"id":@"2",@"user":@"R",@"msg":@"",@"image":@"photo_sample_02"},@{@"id":@"2",@"user":@"R",@"msg":@"Lorem Ipsum 1500s",@"image":@"photo_sample_01"},@{@"id":@"2",@"user":@"S",@"msg":@"",@"image":@"photo_sample_02"},@{@"id":@"2",@"user":@"R",@"msg":@"Lorem Ipsum is simply since theLorem Ipsum has been the industry's standard dummy text ever since the 1500s",@"image":@"photo_sample_01"}, nil];
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@"12-04-17" forKey:@"date"];
    [dic setObject:new forKey:@"info"];
    
    
    NSMutableDictionary *dic1 = [NSMutableDictionary new];
    [dic1 setObject:@"13-04-17" forKey:@"date"];
    [dic1 setObject:new1 forKey:@"info"];
    
    
    NSMutableDictionary *dic2 = [NSMutableDictionary new];
    [dic2 setObject:@"15-04-17" forKey:@"date"];
    [dic2 setObject:new2 forKey:@"info"];
    
    NSMutableDictionary *dic3 = [NSMutableDictionary new];
    [dic3 setObject:@"16-04-17" forKey:@"date"];
    [dic3 setObject:new3 forKey:@"info"];
    
    
    [array addObject:dic];
    [array addObject:dic1];
    [array addObject:dic2];
    [array addObject:dic3];
     
     
     */
    
    
    NSString *url = [NSString stringWithFormat:@"%@messagedetails?user_id=116&message_id=128&lang_id=en&user_timezone=Asia/kolkata",App_Domain_Url];
    
    
    NSMutableURLRequest *requst = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    
    [obj GlobalDict:requst Globalstr:@"array" lodaer:YES Withblock:^(id result, NSError *error) {
        
        
        
        [array addObjectsFromArray:[result valueForKey:@"all_message_details"]];
        
        
        
        [chat_tbl reloadData];
        
        
    }];
    
    
    
    
    
    NSLog(@"array--->%@",array);
    
}

- (void)keyboardWillShow:(NSNotification*)notification
{
    
    
}



- (void)keyboardWillHide:(NSNotification*)notification
{
    

}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"CellID";
    
    UITableViewCell *myCell=[tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(myCell==nil)
    {
        
        myCell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    
    myCell.backgroundColor = RGB(250, 250, 250);
    
    
    return myCell;
}



-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    for (__weak UIView *view in cell.subviews)
    {
        [view removeFromSuperview];
        
        //view = nil;
    }
    
    UIView *view_chat = [[UIView alloc]init];
    
   // view_chat.backgroundColor = [UIColor clearColor];
//    view_chat.clipsToBounds = YES;
//    view_chat.layer.cornerRadius = 15;
    
    
    UIImageView *pr0file;
    UILabel *name_lbl =[UILabel new];
    name_lbl.font = [UIFont fontWithName:@"PingFang SC" size:10];
    name_lbl.textColor = [UIColor grayColor];
   
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    
    UILabel *chrt_show_lbl = [[UILabel alloc]init];
    chrt_show_lbl.font =font_name ;
    chrt_show_lbl.numberOfLines = 999;
    chrt_show_lbl.textColor = [UIColor blackColor];
    
    UIImageView *image = [[UIImageView alloc]init];
    
    image.clipsToBounds =YES;
    
   
    
    image.hidden = YES;
    
    chrt_show_lbl.text = [[[[array objectAtIndex:indexPath.section] valueForKey:@"info"] objectAtIndex:indexPath.row] valueForKey:@"message_info"];
    
    
    
    
    if ([[[[[array objectAtIndex:indexPath.section] valueForKey:@"info"] objectAtIndex:indexPath.row] valueForKey:@"message_type_code"] isEqualToString:@"C"])
    {
        
        [pr0file removeFromSuperview];
        
        
        
        
        
        
         name_lbl.frame =  CGRectMake(tableView.frame.size.width-tableView.frame.size.width/1.3 - 10, 5, tableView.frame.size.width/1.3, 27);
        
        name_lbl.text = @"14:32";
        
        name_lbl.textAlignment = NSTextAlignmentRight;
        
        
        
        
        
        
        
        if ( chrt_show_lbl.text.length>0)
        {
            
             view_chat.frame = CGRectMake(tableView.frame.size.width-tableView.frame.size.width/1.3 - 10, name_lbl.frame.size.height+name_lbl.frame.origin.y, tableView.frame.size.width/1.3, cell.frame.size.height-40);
        }
        else
        {
            image.hidden = NO;
            view_chat.frame = CGRectMake(tableView.frame.size.width-tableView.frame.size.width/2-10, name_lbl.frame.size.height+name_lbl.frame.origin.y, tableView.frame.size.width/2 , cell.frame.size.height-40);
            
            
            image.frame = CGRectMake(2, 2, view_chat.frame.size.width-4, view_chat.frame.size.height-4);
            
            //image.image = [UIImage imageNamed:[[[[array objectAtIndex:indexPath.section] valueForKey:@"info"] objectAtIndex:indexPath.row] valueForKey:@"image"]];
        }

        
        gradient.frame = view_chat.bounds;
        gradient.colors = @[(id)RGBNEW(171, 221 , 255).CGColor, (id)RGB(171, 221 , 255).CGColor];
        gradient.startPoint = CGPointMake(0.0, 0.0);
        gradient.endPoint = CGPointMake(1.0, 0.0);
        
         [self setMaskTo:view_chat byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft| UIRectCornerBottomRight];
        [self setMaskTo:image byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft| UIRectCornerBottomRight];
        
        
         //image.layer.cornerRadius = view_chat.layer.cornerRadius;
        
        
    }
    
    
    else
    {
        
        pr0file = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 27, 27)];
        
        pr0file.backgroundColor = [UIColor whiteColor];
        pr0file.clipsToBounds = YES;
        pr0file.layer.cornerRadius = 5;
        
        pr0file.image = [UIImage imageNamed:@"new-user-image-default"];
        
        [cell addSubview:pr0file];
        
        
        
        name_lbl.frame =  CGRectMake(pr0file.frame.origin.x+pr0file.frame.size.width+3, 5, tableView.frame.size.width/1.3, pr0file.frame.size.height);
        
        name_lbl.textAlignment = NSTextAlignmentLeft;
        
        
        
        
        name_lbl.text = @"Angilena Jeo, 14:32";
        
        
        if ( chrt_show_lbl.text.length>0)
        {
             view_chat.frame = CGRectMake(pr0file.frame.origin.x+pr0file.frame.size.width+3, pr0file.frame.origin.y+pr0file.frame.size.height+2, tableView.frame.size.width/1.3, cell.frame.size.height-40);
            
        }
        else
        {
            image.hidden = NO;
            view_chat.frame = CGRectMake(pr0file.frame.origin.x+pr0file.frame.size.width+3, pr0file.frame.origin.y+pr0file.frame.size.height+2, tableView.frame.size.width/2, cell.frame.size.height-40);
            
            image.frame = CGRectMake(2, 2, view_chat.frame.size.width-4, view_chat.frame.size.height-4);
            
            //image.image = [UIImage imageNamed:[[[[array objectAtIndex:indexPath.section] valueForKey:@"info"] objectAtIndex:indexPath.row] valueForKey:@"image"]];
        }

        
        gradient.frame = view_chat.bounds;
        gradient.colors = @[(id)RGB(255, 191, 204).CGColor, (id)RGBNEW(255, 191, 204).CGColor];
        gradient.startPoint = CGPointMake(0.0, 0.0);
        gradient.endPoint = CGPointMake(1.0, 0.0);
        
        //chat_backimage.frame = CGRectMake(0 , 0, view_chat.frame.size.width, view_chat.frame.size.height);
        
        //chat_backimage.image = [UIImage imageNamed:@"Line"];
        
        
        [self setMaskTo:view_chat byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight];
        [self setMaskTo:image byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight];
        
        
        //image.layer.cornerRadius = view_chat.layer.cornerRadius;
    }
    
    
     chrt_show_lbl.frame = CGRectMake(15, 15, view_chat.frame.size.width-30, view_chat.frame.size.height-30);
    
    
    [view_chat.layer insertSublayer:gradient atIndex:0];
    
    
    
 
//    UIBezierPath *shadowPath_1 = [UIBezierPath bezierPathWithRect:view_chat.bounds];
//    view_chat.layer.masksToBounds = NO;
//    view_chat.layer.shadowColor = [UIColor blackColor].CGColor;
//    view_chat.layer.shadowOffset = CGSizeMake(.5, .5);
//    view_chat.layer.shadowOpacity = 0.2f;
//    view_chat.layer.shadowPath = shadowPath_1.CGPath;
    
    
    
    [cell addSubview:name_lbl];
    [cell addSubview:view_chat];
    [view_chat addSubview:image];
    [view_chat addSubview:chrt_show_lbl];
    
    
    
    
    
}



-(void) setMaskTo:(UIView*)view byRoundingCorners:(UIRectCorner)corners
{
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(10.0, 10.0)];
    
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    view.layer.mask = shape;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[array objectAtIndex:(int)section] valueForKey:@"info"] count] ;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return array.count;
}


- (CGSize)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font {
    CGSize size = CGSizeZero;
    
    if (text)
    {
        CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font} context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    return size;
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 21)];
    
    view.backgroundColor =RGB(250, 250, 250);//[UIColor clearColor];
    
    
    UILabel *date_lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 21)];
    date_lbl.font = [UIFont fontWithName:@"PingFang SC" size:10];
    
    
    
    
    
    
    float widthIs =  [[[array objectAtIndex:section] valueForKey:@"date"] boundingRectWithSize:date_lbl.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:date_lbl.font } context:nil] .size.width+20;
    
    
    date_lbl.frame = CGRectMake(view.frame.size.width/2 - widthIs/2,view.frame.size.height/2-21/2 , widthIs, 21);
    
    
    date_lbl.backgroundColor = [UIColor clearColor];
    
    date_lbl.text = [[array objectAtIndex:section] valueForKey:@"date"];
    
    date_lbl.textAlignment = NSTextAlignmentCenter;
    
    
    date_lbl.clipsToBounds = YES;
    date_lbl.layer.cornerRadius = 5;
    date_lbl.textColor = [UIColor blackColor];
    
    
    
    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(25, view.frame.size.height/2-0.5, tableView.frame.size.width/2-date_lbl.frame.size.width-10, 1)];
    
    lbl.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:.3f];
    
    [view addSubview:lbl];
    
    
    UILabel *lbl1 = [[UILabel alloc]initWithFrame:CGRectMake(date_lbl.frame.origin.x+date_lbl.frame.size.width+10, view.frame.size.height/2-0.5, lbl.frame.size.width, 1)];
    
    lbl1.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:.3f];
    
    [view addSubview:lbl1];
    
    [view addSubview:date_lbl];
    
    return view;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 21;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGSize height = [self findHeightForText:[[[[array objectAtIndex:indexPath.section] valueForKey:@"info"] objectAtIndex:indexPath.row] valueForKey:@"message_info"] havingWidth:tableView.frame.size.width/1.5 andFont:font_name];
    
    if ([[[[[array objectAtIndex:indexPath.section] valueForKey:@"info"] objectAtIndex:indexPath.row] valueForKey:@"message_info"] length]>0)
    {
        if (height.height<30)
        {
            return height.height+70 ;
        }
        else
        {
            return height.height+70;
            
        }
    }
    
    else
    {
        return tableView.frame.size.width/2;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1)];
    
    view.backgroundColor = RGB(250, 250, 250);
    
    return view;
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
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
    
    
    [self.navigationController popViewControllerAnimated: YES];
    
}

- (IBAction)send:(id)sender {
}

- (IBAction)attachment:(id)sender {
}
@end
