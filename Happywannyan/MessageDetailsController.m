//
//  MessageDetailsController.m
//  Happywannyan
//
//  Created by Rahul Singha Roy on 25/05/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import "MessageDetailsController.h"

@interface MessageDetailsController ()
{
    NSArray *chat_data;
    
    UIFont *text_font;
    
    
}

@end

@implementation MessageDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     text_font=[UIFont fontWithName:@"PingFang SC" size:12];
    
    chat_data = [[NSArray alloc]initWithObjects: @{@"img":[UIImage imageNamed:@"images"],@"user":@"S" , @"chat":@"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."},
    @{@"user":@"R", @"chat":@"",@"img":[UIImage imageNamed:@"images-2"]},
    @{@"user":@"S" , @"chat":@"Lorem Ipsum is simply dummy text of the printing and typesetting industry.",@"img":[UIImage imageNamed:@"images-1"]},
    @{@"user":@"R" , @"chat":@"It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",@"img":[UIImage imageNamed:@""]},nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return chat_data.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = [self findHeightForText:[[chat_data objectAtIndex:indexPath.row] valueForKey:@"chat"] havingWidth:tableView.frame.size.width/1.5 andFont:text_font];
    
    
    
    
    return size.height;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"CellID";
    
    UITableViewCell *myCell=[tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(myCell==nil)
    {
        
        myCell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    
    
    return myCell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[[chat_data objectAtIndex:indexPath.row] valueForKey:@"user"] isEqualToString:@"R"])
    {
        
        
        
    }
    else
    {
        
    }
}



- (CGSize)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font {
    CGSize size = CGSizeZero;
    if (text) {
        CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font } context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    return size;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
