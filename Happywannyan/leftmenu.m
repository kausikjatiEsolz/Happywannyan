//
//  leftmenu.m
//  Happywannyan
//
//  Created by Rahul Singha Roy on 18/05/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import "leftmenu.h"
#import "Language_class.h"
#import "Messages_ViewController.h"
#import "Booking_ViewController.h"
#import "Search_ViewController.h"
#import "Profile@1_ViewController.h"
#import "InitialController.h"
#import "UIImageView+WebCache.h"
#import "LoginController.h"
#import "YourPetViewController.h"
#import "HelpController.h"
#import "FavoriteSittersController.h"
#import "PaymentBookingController.h"
#import "ProfileController.h"

@implementation leftmenu
@synthesize profile_image;

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(id)initWithFrame:(CGRect)frame
{
    
    
    self=[super initWithFrame:frame];
    
    if (self)
    {
        self=[[[NSBundle mainBundle] loadNibNamed:@"View" owner:self options:nil]objectAtIndex:0];
        
        
       
    }
    
   
    user_info = [[Language_class new] language];
    
    
    login_array = [[NSArray alloc]initWithObjects:@{@"name":[user_info valueForKey:@"search"] , @"image":@"Search Icon"},@{@"name":[user_info valueForKey:@"message"] , @"image":@"messages"},@{@"name":[user_info valueForKey:@"booking"] , @"image":@"Booking"},@{@"name":[user_info valueForKey:@"yourpet"] , @"image":@"your pet"},@{@"name":[user_info valueForKey:@"payment"] , @"image":@"payment"},@{@"name":[user_info valueForKey:@"profile"] , @"image":@"profile"},@{@"name":[user_info valueForKey:@"favorite_sitters"] , @"image":@"like-1"},@{@"name":[user_info valueForKey:@"past_sitters"] , @"image":@"Combined Shape"},@{@"name":[user_info valueForKey:@"help"] , @"image":@"question-mark"},@{@"name":[user_info valueForKey:@"logout"] , @"image":@"Log out"}, nil];
    
    guest_array = [[NSArray alloc]initWithObjects:@{@"name":[user_info valueForKey:@"help"] , @"image":@"help"}, nil];
    
    
    profile_image.clipsToBounds = YES;
    profile_image.layer.cornerRadius = profile_image.frame.size.height/2;
    
    
    NSLog(@"imglink--->%@",[NSString stringWithFormat:@"%@",[[[NSUserDefaults standardUserDefaults] valueForKey:@"userinfo"] valueForKey:@"image_path"]]);
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userid"] length]>0)
    {
        table_array = login_array;
        
        _signinorSignup.hidden = YES;
        
        name_lbl.frame = CGRectMake(name_lbl.frame.origin.x, name_lbl.frame.origin.y, name_lbl.frame.size.width, profile_image.frame.size.height);
        
        
        
        if ([[[[NSUserDefaults standardUserDefaults] valueForKey:@"userinfo"] valueForKey:@"firstname"] length]>0 || [[[[NSUserDefaults standardUserDefaults] valueForKey:@"userinfo"] valueForKey:@"lastname"] length]>0)
        {
            name_lbl.text = [NSString stringWithFormat:@"%@ %@",[[[NSUserDefaults standardUserDefaults] valueForKey:@"userinfo"] valueForKey:@"firstname"],[[[NSUserDefaults standardUserDefaults] valueForKey:@"userinfo"] valueForKey:@"lastname"]];
        }
        else
        {
            name_lbl.text = [NSString stringWithFormat:@"%@",[[[NSUserDefaults standardUserDefaults] valueForKey:@"userinfo"] valueForKey:@"emailid"]];
        }
        
        
        
        if ([[[[NSUserDefaults standardUserDefaults] valueForKey:@"userinfo"] valueForKey:@"image_path"] length]>0)
        {
            [profile_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[[NSUserDefaults standardUserDefaults] valueForKey:@"userinfo"] valueForKey:@"image_path"]]]];
        }
        else
        {
            profile_image.image =[UIImage imageNamed:@"Avatar"];
        }
        
        
    }
    
    else
    {
        table_array = guest_array;
        
        _signinorSignup.hidden = NO;
        
        name_lbl.frame = CGRectMake(name_lbl.frame.origin.x, name_lbl.frame.origin.y, name_lbl.frame.size.width, profile_image.frame.size.height/2);
        
        name_lbl.text = @"Guest";
        
        
        profile_image.image =[UIImage imageNamed:@"Avatar"];
    }
    
    
    
    
    
    
    _leftTable.delegate = self;
    _leftTable.dataSource = self;
    
    
    [_leftTable reloadData];
    
    return self;
    
    
}

-(void)Leftmenu:(UIViewController *)viewcontroller sideMenu:(UIView *)side_menu;
{
    //sel = [Left_Menu new];
    side_menu.frame = CGRectMake(-viewcontroller.view.frame.size.width/1.3, 0,viewcontroller.view.frame.size.width/1.3, viewcontroller.view.frame.size.height);
    
    side_menu.hidden = YES;
    
    
    
    
    //UIPanGestureRecognizer *leftmenu = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(left_menuPan:)];
    
    
    back_view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, viewcontroller.view.frame.size.width, viewcontroller.view.frame.size.height)];
    
    back_view.backgroundColor = [UIColor blackColor];
    
    UITapGestureRecognizer *letterTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeMenu)];
    
    [back_view addGestureRecognizer:letterTapRecognizer];
    
    back_view.alpha = 0;
    
    back_view.hidden=YES;
    
    [viewcontroller.view addSubview:back_view];
    [viewcontroller.view addSubview:side_menu];
    // [viewcontroller.view addGestureRecognizer:leftmenu];
    
    demo= side_menu;
    _controller_obj = viewcontroller;
    
    
    
}

- (IBAction)signinorSignup:(id)sender {
    
    
    
    
    
    //visibale_controller = _controller_obj;
    
    
    
    
    
    NSLog(@"_controller_obj--->%@",_controller_obj);
    
    
    
    
    
    [self closeMenu];
    
    
    
    [[NSUserDefaults standardUserDefaults] setObject:NSStringFromClass([_controller_obj class]) forKey:@"currentViewController"];
    
    //[[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
    InitialController *login = [_controller_obj.storyboard instantiateViewControllerWithIdentifier:@"initail"];
    
    
    
    
    
    login.loginForm =@"leftmenu";
    
    
    
    //[_controller_obj.navigationController pushViewController:login animated:YES];
    
    
    
    [self pushToViewcontrollerNEW:login];
    
    
    
    
    
}

-(void)left_menuPan:(UIPanGestureRecognizer*)recognizer {
    
    
    demo.hidden = NO;
    back_view.hidden = NO;
    
    
    
    
    
    translation = [recognizer translationInView:_controller_obj.view];
    CGPoint vel = [recognizer velocityInView:_controller_obj.view];
    
    
    //NSLog(@"vel---->%f",vel.x);
    
    CGRect recognizerFrame = recognizer.view.frame;
    recognizerFrame.origin.x += translation.x;
    recognizerFrame.origin.y += translation.y;
    
    
    
    NSLog(@"translation.x--->%f",translation.x);
    
    
    if (demo.frame.origin.x<=0 )
    {
        
        if (endPan==NO)
        {
            demo.frame = CGRectMake(translation.x-demo.frame.size.width, 0, demo.frame.size.width, demo.frame.size.height);
            
            if (back_view.alpha<.6f)
            {
                
                back_view.alpha = recognizerFrame.origin.x/550;
            }
            
            endPan=NO;
        }
        else
        {
            demo.frame = CGRectMake(translation.x, 0, demo.frame.size.width, demo.frame.size.height);
            
            if (back_view.alpha<.6f)
            {
                back_view.alpha = -1 *((550/recognizerFrame.origin.x)/550);
            }
            
            
            
        }
        
        
        NSLog(@"alpha--->%f",back_view.alpha);
        
    }
    
    
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        NSLog(@"UIGestureRecognizerStateEnded");
        
        
        
        if (vel.x > 0)
        {
            // user dragged towards the right
            
            [UIView animateWithDuration:.25f animations:^{
                
                demo.frame = CGRectMake(0, 0, _controller_obj.view.frame.size.width/1.3, _controller_obj.view.frame.size.height);
                
                back_view.alpha = .51f;
                
            }completion:^(BOOL finished) {
                
                
                
                
                if (demo.frame.origin.x>=0)
                {
                    endPan = YES;
                }
                else
                {
                    endPan = NO;
                }
                
                
            }];
            
            
            
            
            
        }
        else
        {
            // user dragged towards the left
            
            
            [UIView animateWithDuration:.25f animations:^{
                demo.frame = CGRectMake(-_controller_obj.view.frame.size.width/1.3, 0, _controller_obj.view.frame.size.width/1.3, _controller_obj.view.frame.size.height );
                
                back_view.alpha = 0;
                
                
            }completion:^(BOOL finished) {
                
                
                demo.hidden =YES;
                back_view.hidden=YES;
                
                if (demo.frame.origin.x>=0)
                {
                    endPan = YES;
                }
                else
                {
                    endPan = NO;
                }
                
            }];
            
            
            
        }
        
    }
    
    
    //[recognizer setTranslation:CGPointMake(0, 0) inView:demo];
    
    
    
}


#pragma Tableview Methods


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"CellID";
    
    UITableViewCell *myCell=[tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(myCell==nil)
    {
        
        myCell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    
    //NSLog(@"business-->%@",business);
    
    
    return myCell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)myCell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    for (id obj  in myCell.subviews)
    {
        [obj removeFromSuperview];
    }
    
    
    
    
    
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(tableView.frame.size.width/8, myCell.frame.size.height/2 - 20/2, 20, 20)];
    
    imageview.image = [UIImage imageNamed:[[table_array objectAtIndex:indexPath.row] valueForKey:@"image"]];
    
    [myCell addSubview:imageview];
    
    
    
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width + 15, 0, myCell.frame.size.width-(imageview.frame.origin.x+imageview.frame.size.width+15), myCell.frame.size.height)];
    
    name.backgroundColor = [UIColor clearColor];
    name.textColor = [UIColor whiteColor];
    name.font = [UIFont fontWithName:@"PingFang SC" size:14];
    name.text = [[table_array objectAtIndex:indexPath.row] valueForKey:@"name"];
    
    [myCell addSubview:name];
    
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor =[UIColor clearColor]; //[UIColor colorWithRed:(189/255.0) green:(62/255.0) blue:(73/255.0) alpha:1.0];
    [myCell setSelectedBackgroundView:bgColorView];
    
    
    
    myCell.backgroundColor =self.backgroundColor;
    
    
    
    
    
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return table_array.count ;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self closeMenu];
    
    
    if (indexPath.row!=7 && indexPath.row!=6)
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"favourite"];
        
    }
    
    //    if ([[[table_array objectAtIndex:indexPath.row]valueForKey:@"name"] length]>0)
    //    {
    //[side_menuDelegate left_menu:(int)indexPath.row];
    
    //}
    if (indexPath.row==0)
    {
        
        
        if (![[[_controller_obj.navigationController viewControllers] lastObject] isKindOfClass:[Search_ViewController class]])
        {
            
            NSLog(@"navigation1st--->%@",_controller_obj.navigationController.viewControllers);
            
            Search_ViewController *obj_sigup;
            
            for (UIViewController *obj in _controller_obj.navigationController.viewControllers.reverseObjectEnumerator)
            {
                if ([obj isKindOfClass:[Search_ViewController class]])
                {
                    
                    obj_sigup = (Search_ViewController *) obj;
                    
                    break;
                }
            }
            
            
            obj_sigup.filter = @"";
            
            if (obj_sigup==nil)
            {
                Search_ViewController *message = [_controller_obj.storyboard instantiateViewControllerWithIdentifier:@"search"];
                //[_controller_obj.navigationController pushViewController:message animated:YES];
                
                [self pushToViewcontroller:message];
            }
            else
            {
                CATransition* transition = [CATransition animation];
                transition.duration = 0.2;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
                transition.type = kCATransitionFromRight; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
                //transition.subtype = kCATransitionFromTop; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
                [_controller_obj.navigationController.view.layer addAnimation:transition forKey:nil];
                [[_controller_obj navigationController] popToViewController:obj_sigup animated:NO];
                
                // [_controller_obj.navigationController popToViewController:obj_sigup animated:NO];
            }
            
            
            NSLog(@"navigation2nd--->%@",_controller_obj.navigationController.viewControllers);
        }
    }
    
    
    else if (indexPath.row==1)
    {
        if (![[[_controller_obj.navigationController viewControllers] lastObject] isKindOfClass:[Messages_ViewController class]])
        {
            Messages_ViewController *message = [_controller_obj.storyboard instantiateViewControllerWithIdentifier:@"message"];
            // [_controller_obj.navigationController pushViewController:message animated:YES];
            
            [self pushToViewcontroller:message];
            
        }
    }
    else if (indexPath.row==2)
    {
        if (![[[_controller_obj.navigationController viewControllers] lastObject] isKindOfClass:[Booking_ViewController class]])
        {
            Booking_ViewController *obj = [_controller_obj.storyboard instantiateViewControllerWithIdentifier:@"booking"];
            //[_controller_obj.navigationController pushViewController:obj animated:YES];
            
            [self pushToViewcontroller:obj];
            
        }
    }
    else if (indexPath.row==3)
    {
        if (![[[_controller_obj.navigationController viewControllers] lastObject] isKindOfClass:[YourPetViewController class]])
        {
            YourPetViewController *obj = [_controller_obj.storyboard instantiateViewControllerWithIdentifier:@"mypet"];
            //[_controller_obj.navigationController pushViewController:obj animated:YES];
            
            [self pushToViewcontroller:obj];
            
        }
    }
    else if (indexPath.row==4)
    {
//        if (![[[_controller_obj.navigationController viewControllers] lastObject] isKindOfClass:[PaymentBookingController class]])
//        {
//            PaymentBookingController *obj = [_controller_obj.storyboard instantiateViewControllerWithIdentifier:@"paymentbooking"];
//            [self pushToViewcontroller:obj];
//            
//        }
    }

    
    
    else if (indexPath.row==5)
    {
                if (![[[_controller_obj.navigationController viewControllers] lastObject] isKindOfClass:[ProfileController class]])
                {
                    ProfileController *obj = [_controller_obj.storyboard instantiateViewControllerWithIdentifier:@"userprofile"];
                    //[_controller_obj.navigationController pushViewController:obj animated:YES];
        
                    [self pushToViewcontroller:obj];
        
                }
    }
    
    
    else if (indexPath.row==6)
    {
         if (![[[NSUserDefaults standardUserDefaults]objectForKey:@"favourite"] isEqualToString:@"6"])
        {
            FavoriteSittersController *obj = [_controller_obj.storyboard instantiateViewControllerWithIdentifier:@"favoritesitters"];
            [[NSUserDefaults standardUserDefaults] setObject:@"6" forKey:@"favourite"];
            [self pushToViewcontroller:obj];
            
        }
    }
    else if (indexPath.row==7)
    {
        if (![[[NSUserDefaults standardUserDefaults]objectForKey:@"favourite"] isEqualToString:@"7"])
        {
            FavoriteSittersController *obj = [_controller_obj.storyboard instantiateViewControllerWithIdentifier:@"favoritesitters"];
            [[NSUserDefaults standardUserDefaults] setObject:@"7" forKey:@"favourite"];
            [self pushToViewcontroller:obj];
    
        }
    }

    
    else if (indexPath.row==8)
    {
        if (![[[_controller_obj.navigationController viewControllers] lastObject] isKindOfClass:[HelpController class]])
        {
            HelpController *obj = [_controller_obj.storyboard instantiateViewControllerWithIdentifier:@"help"];
            //[_controller_obj.navigationController pushViewController:obj animated:YES];
            [self pushToViewcontroller:obj];
            
        }
    }
    
    
    
    else if (indexPath.row==table_array.count-1)
    {
        
        
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Log Out"
                                              message:@"Are you sure you want to log out?"
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"Cancel"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           
                                       }];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:@"LogOut"
                                   style:UIAlertActionStyleDestructive
                                   handler:^(UIAlertAction *action)
                                   {
                                       
                                       [alertController dismissViewControllerAnimated:NO completion:nil];
                                       
                                       NSLog(@"navigation1st--->%@",_controller_obj.navigationController.viewControllers);
                                       
                                       
                                       [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"userid"];
                                       
                                       InitialController *obj_sigup;
                                       
                                       for (UIViewController *obj in _controller_obj.navigationController.viewControllers.reverseObjectEnumerator)
                                       {
                                           if ([obj isKindOfClass:[InitialController class]])
                                           {
                                               
                                               obj_sigup = (InitialController *) obj;
                                               
                                               break;
                                           }
                                       }
                                       
                                       if (obj_sigup==nil)
                                       {
                                           InitialController *message = [_controller_obj.storyboard instantiateViewControllerWithIdentifier:@"initail"];
                                           //[_controller_obj.navigationController pushViewController:message animated:YES];
                                           
                                           [self pushToViewcontroller:message];
                                       }
                                       else
                                       {
                                           CATransition* transition = [CATransition animation];
                                           transition.duration = 0.2;
                                           transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
                                           transition.type = kCATransitionFromRight; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
                                           //transition.subtype = kCATransitionFromTop; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
                                           [_controller_obj.navigationController.view.layer addAnimation:transition forKey:nil];
                                           [[_controller_obj navigationController] popToViewController:obj_sigup animated:NO];
                                           
                                           // [_controller_obj.navigationController popToViewController:obj_sigup animated:NO];
                                       }
                                       
                                       
                                       NSLog(@"navigation2nd--->%@",_controller_obj.navigationController.viewControllers);
                                   }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        
        
        [_controller_obj presentViewController:alertController animated:YES completion:nil];
        
    }
    
    
    
    
    
    
}




#pragma Menu open in ViewController


-(void)lefMenuopen:(UIButton *)sender
{
    demo.hidden =NO;
    back_view.hidden=NO;
    
    [_controller_obj.view bringSubviewToFront:back_view];
    [_controller_obj.view bringSubviewToFront:demo];
    
    
    
    //back_view.alpha = 0;
    
    [UIView animateWithDuration:.25f animations:^{
        
        demo.frame = CGRectMake(0, 0, _controller_obj.view.frame.size.width/1.3, _controller_obj.view.frame.size.height);
        
        back_view.alpha = .5f;
        
    }completion:^(BOOL finished) {
        
        
        NSLog(@"back_view--->%f",back_view.frame.size.width);
        
        
        if (demo.frame.origin.x>=0)
        {
            endPan = YES;
        }
        else
        {
            endPan = NO;
        }
        
        
    }];
    
}


-(void)closeMenu
{
    [UIView animateWithDuration:.25f animations:^{
        demo.frame = CGRectMake(-_controller_obj.view.frame.size.width/1.3, 0, _controller_obj.view.frame.size.width/1.3, _controller_obj.view.frame.size.height );
        
        back_view.alpha = 0;
        
        
    }completion:^(BOOL finished) {
        
        
        demo.hidden =YES;
        back_view.hidden=YES;
        
        if (demo.frame.origin.x>=0)
        {
            endPan = YES;
        }
        else
        {
            endPan = NO;
        }
        
    }];
}


-(void)pushToViewcontroller:(UIViewController *)obj
{
    //    CATransition *transition = [CATransition animation];
    //    transition.duration = 0.3;
    //    transition.type = kCATransitionFade;
    //    transition.subtype = kCATransitionFromTop;
    //
    //    [_controller_obj.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    //    [_controller_obj.navigationController pushViewController:obj animated:NO];
    
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.2;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    transition.type = kCATransitionFromRight; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    //transition.subtype = kCATransitionFromTop; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [_controller_obj.navigationController.view.layer addAnimation:transition forKey:nil];
    [_controller_obj.navigationController pushViewController:obj animated:NO];
}

-(void)pushToViewcontrollerNEW:(UIViewController *)obj
{
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [_controller_obj.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [_controller_obj.navigationController pushViewController:obj animated:NO];
    //[self pushViewController:dstVC animated:NO];
    
}




@end
