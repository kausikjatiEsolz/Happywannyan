//
//  YourPetViewController.m
//  Happywannyan
//
//  Created by Kausik_Jati on 26/05/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import "YourPetViewController.h"
#import "UIImageView+WebCache.h"
#import "AddAnotherPetViewController.h"

@interface YourPetViewController ()

@end

@implementation YourPetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    url_obj=[Json_Class new];
    
    
    
   
//    [self urlData:@"0"];

    leftMenu_obj = [leftmenu new];
    
    [leftMenu_obj Leftmenu:self sideMenu:leftMenu_obj];

   // [self urlData:@"0"];
    
    //main_ary=[[NSMutableArray alloc]init];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  
     main_ary=[[NSMutableArray alloc]init];
    
    [yourpet_tbl reloadData];
    
    
    
   [self urlData:@"0"];
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return main_ary.count;
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CELL=[yourpet_tbl dequeueReusableCellWithIdentifier:@"YourPet"forIndexPath:indexPath];
    
    CELL.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CELL.delete_btn.tag=[indexPath row];
    
    [CELL.delete_btn addTarget:self action:@selector(delete_tap:) forControlEvents:UIControlEventTouchUpInside];
    
    CELL.edit_btn.tag=[indexPath row];
    
    [CELL.edit_btn addTarget:self action:@selector(edit_tap:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [CELL.main_img sd_setImageWithURL:[NSURL URLWithString:[[main_ary objectAtIndex:indexPath.row]valueForKey:@"pet_image"]] placeholderImage:[UIImage imageNamed:@"dog-placeholder"]];
    
    
    CELL.main_img.layer.cornerRadius=4;
    CELL.main_img.clipsToBounds=YES;
    
    CELL.petType.text=[[main_ary objectAtIndex:indexPath.row]valueForKey:@"pet_name"];
    
    NSArray *array = [[main_ary objectAtIndex:indexPath.row]valueForKey:@"other_info"];
    
    for (int i=0; i<array.count; i++)
    {
        if ([[[array objectAtIndex:i] valueForKey:@"input_name"] isEqualToString:@"Name"])
        {
            CELL.name_lbl.text = [[array objectAtIndex:i] valueForKey:@"show_name"];
        }
       else if ([[[array objectAtIndex:i] valueForKey:@"input_name"] isEqualToString:@"Years"])
        {
             CELL.year.text = [[array objectAtIndex:i] valueForKey:@"show_name"];
        }
       else if ([[[array objectAtIndex:i] valueForKey:@"input_name"] isEqualToString:@"Breed"])
       {
            CELL.Breed.text = [[array objectAtIndex:i] valueForKey:@"show_name"];
       }
       else if ([[[array objectAtIndex:i] valueForKey:@"input_name"] isEqualToString:@"Months"])
       {
           CELL.month.text = [[array objectAtIndex:i] valueForKey:@"show_name"];
       }
       else if ([[[array objectAtIndex:i] valueForKey:@"input_name"] isEqualToString:@"Size"])
       {
            CELL.size.text = [[array objectAtIndex:i] valueForKey:@"show_name"];
       }
       else if ([[[array objectAtIndex:i] valueForKey:@"input_name"] isEqualToString:@"Is your dog spayed or neutered?"])
       {
            CELL.first_que.text = [[array objectAtIndex:i] valueForKey:@"show_name"];
       }
       else if ([[[array objectAtIndex:i] valueForKey:@"input_name"] isEqualToString:@"Is your dog friendly with other pets?"])
       {
            CELL.second_que.text = [[array objectAtIndex:i] valueForKey:@"show_name"];
       }
       else if ([[[array objectAtIndex:i] valueForKey:@"input_name"] isEqualToString:@"Gender"])
       {
            CELL.gender.text = [[array objectAtIndex:i] valueForKey:@"show_name"];
       }
        
        
        
        
        
        
        
        
        
//        "input_name":"Name",
//        "":"jerry",
    }
    
    
    if (main_ary.count-1==indexPath.row)
    {
        
        NSLog(@"index-->%@",[main_ary objectAtIndex:indexPath.row]);
        
        if (![start_from isEqualToString:@"0"])
        {
            
            [self urlData:start_from];
            
        }
    }
    
    return CELL;
}


-(void)urlData:(NSString *)startfrom
{
    NSString *url_str=[NSString stringWithFormat:@"%@app_users_petinfo?user_id=%@&lang_id=%@&start_form=%@&per_page=10",App_Domain_Url,[[NSUserDefaults standardUserDefaults]valueForKey:@"userid"],[[NSUserDefaults standardUserDefaults]valueForKey:@"lan_code"],startfrom];
    
    NSString *urlUTF8=[url_str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
    
    [request setURL:[NSURL URLWithString:urlUTF8]];
    
    [url_obj GlobalDict:request Globalstr:@"array" lodaer:YES Withblock:^(id result, NSError *error)
     {
         
         NSString *response=[NSString stringWithFormat:@"%@",[result valueForKey:@"response"]];
         
         if ([response isEqualToString:@"1"]) {
            // main_ary=[result valueForKey:@"info_array"];
             
             [self insertDownloadedActions:[result valueForKey:@"info_array"] table:yourpet_tbl];
             
             start_from=[NSString stringWithFormat:@"%@", [result valueForKey:@"start_form"]];
             
           //  NSLog(@"%@",main_ary);
         }
         else
         {
             
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
        NSInteger currentCount = main_ary.count;
        
        for (int i = 0; i < dataToAdd.count; i++) {
            
            [indexPaths addObject:[NSIndexPath indexPathForRow:currentCount+i inSection:0]];
        }
        
        //
        
        
        // do the insertion
       [main_ary addObjectsFromArray:dataToAdd];
        
        // tell the table view to update (at all of the inserted index paths)
        
        // [table reloadData];
 
        
        
        
        [table beginUpdates];
        [table insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
        [table endUpdates];
    });
}

//-(void)urldata_delete
//{
//    NSString *url_str=[NSString stringWithFormat:@"%@app_users_deletePetprofile?user_id=%@&lang_id=%@&DelId=%@",App_Domain_Url,[[NSUserDefaults standardUserDefaults]valueForKey:@"userid"],[[NSUserDefaults standardUserDefaults]valueForKey:@"lan_code"],[[main_ary valueForKey:@"edit_id"] objectAtIndex:0]];
//    
//    NSString *urlUTF8=[url_str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
//    
//    [request setURL:[NSURL URLWithString:urlUTF8]];
//    
//    [url_obj GlobalDict:request Globalstr:@"array" lodaer:YES Withblock:^(id result, NSError *error)
//     {
//         
//         NSString *response=[NSString stringWithFormat:@"%@",[result valueForKey:@"response"]];
//         
//         if ([response isEqualToString:@"1"])
//         
//         
//         {
//             
//             NSLog(@"deleted");
//             
//             UIButton *btn =(UIButton*)sender;
//             
//             [main_ary removeObjectsAtIndexes:btn.tag];
//             [yourpet_tbl deleteRowsAtIndexPaths:myarray withRowAnimation:UITableViewRowAnimationAutomatic];
//             
//             [yourpet_tbl reloadData];
//             
//         }
//         
//         
//         
//         else
//         {
//             
//         }
//         
//         
//     }];
//}





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

- (IBAction)leftmenu:(UIButton *)sender {
    [leftMenu_obj lefMenuopen:sender];
}

- (IBAction)add_tap:(id)sender {
    
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddAnotherPetViewController *obj =[sb instantiateViewControllerWithIdentifier:@"addanotherpet"];
    
    obj.edit=@"";
    
    [self.navigationController pushViewController:obj animated:YES];

    
}

- (IBAction)delete_tap:(id)sender {
    
    
    UIButton *btn = (UIButton*)sender;
    
    {
        
UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                             message:@"Are you want to delete"
                                             preferredStyle:UIAlertControllerStyleAlert];

UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                          style:UIAlertActionStyleCancel
                                          handler:^(UIAlertAction *action)
                                          {
                                              
                                          }];
                 
UIAlertAction *delete = [UIAlertAction actionWithTitle:@"Delete"
                                          style:UIAlertActionStyleDestructive
                                          handler:^(UIAlertAction *action)
{
     NSString *url_str=[NSString stringWithFormat:@"%@app_users_deletePetprofile?user_id=%@&lang_id=%@&DelId=%@",App_Domain_Url,[[NSUserDefaults standardUserDefaults]valueForKey:@"userid"],[[NSUserDefaults standardUserDefaults]valueForKey:@"lan_code"],[[main_ary valueForKey:@"edit_id"] objectAtIndex:btn.tag]];
                                              
     NSString *urlUTF8=[url_str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                                              
      NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
                                              
     [request setURL:[NSURL URLWithString:urlUTF8]];
                                              
     [url_obj GlobalDict:request Globalstr:@"array" lodaer:YES Withblock:^(id result, NSError *error)
    {
       NSString *response=[NSString stringWithFormat:@"%@",[result valueForKey:@"response"]];
                                                   
        if ([response isEqualToString:@"1"])
                                                       
         {
             NSLog(@"deleted");
                                              
            [yourpet_tbl beginUpdates];
                                              
             NSLog(@"------> %ld",(long)btn.tag);
                                              
            NSIndexPath *index = [NSIndexPath indexPathForRow:btn.tag inSection:0];
                                              
             [yourpet_tbl deleteRowsAtIndexPaths: @[index]withRowAnimation:UITableViewRowAnimationLeft];
                                              
             [main_ary removeObjectAtIndex:btn.tag];
                                              
             [yourpet_tbl endUpdates];
                                              

           }
          else
          {
              
          }
              
        }];
                 
  }];
                 
                 
   [alert addAction:delete];
   [alert addAction:cancel];
                 
   [self presentViewController:alert animated:YES completion:nil];
                                          
              
    }
}



- (IBAction)edit_tap:(id)sender {
    
    
    //[super dealloc];
    UIButton *btn=(UIButton *)sender;
    
    NSLog(@"--------------------------------------->     %ld",(long)btn.tag);
    
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddAnotherPetViewController *obj =[sb instantiateViewControllerWithIdentifier:@"addanotherpet"];
    
    obj.edit=[[main_ary objectAtIndex:btn.tag]valueForKey:@"pet_name"];
    obj.pet_type_id=[[main_ary objectAtIndex:btn.tag]valueForKey:@"pet_type_id"];
    obj.edit_id=[[main_ary objectAtIndex:btn.tag]valueForKey:@"edit_id"];
    obj.data = [NSMutableArray new];
    [obj.data addObject:[main_ary objectAtIndex:btn.tag]];
    obj.imageLink =[[main_ary objectAtIndex:btn.tag]valueForKey:@"pet_image"];
    
    
    [self.navigationController pushViewController:obj animated:YES];
    
    
}



@end
