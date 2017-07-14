//
//  CardController.m
//  Happywannyan
//
//  Created by Kausik Jati on 13/06/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import "CardController.h"
#import "YSLDraggableCardContainer.h"
#import "CardView.h"
#import "SearchMapController.h"
#import "PetListing_ViewController.h"
#import "Search_ViewController.h"
#import "UIImageView+WebCache.h"
#import "Profile@1_ViewController.h"

#define RGB(r, g, b)	 [UIColor colorWithRed: (r) / 255.0 green: (g) / 255.0 blue: (b) / 255.0 alpha : 1]

@interface CardController ()<YSLDraggableCardContainerDelegate, YSLDraggableCardContainerDataSource>
{
    //CardView *view;
}

@property (nonatomic, strong) YSLDraggableCardContainer *container;
@property (nonatomic, strong) NSMutableArray *datas;
@end

@implementation CardController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    map_btn.hidden=NO;
    petlist_btn.hidden=NO;
    
    _datas = [[NSUserDefaults standardUserDefaults] valueForKey:@"result"];
    
    self.view.backgroundColor = RGB(235, 235, 235);
    header_lbl.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"search_location"];
    
    _container = [[YSLDraggableCardContainer alloc]init];
    _container.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _container.backgroundColor = [UIColor clearColor];
    _container.dataSource = self;
    _container.delegate = self;
    _container.canDraggableDirection = YSLDraggableDirectionLeft | YSLDraggableDirectionRight ;
    [self.view addSubview:_container];
    
    
    
    //    for (int i = 0; i < 4; i++) {
    //
    //        UIView *view = [[UIView alloc]init];
    //        CGFloat size = self.view.frame.size.width / 4;
    //        view.frame = CGRectMake(size * i, self.view.frame.size.height - 150, size, size);
    //        view.backgroundColor = [UIColor clearColor];
    //        [self.view addSubview:view];
    //
    //        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //        button.frame = CGRectMake(10, 10, size - 20, size - 20);
    //        [button setBackgroundColor:RGB(66, 172, 225)];
    //        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //        button.titleLabel.font = [UIFont fontWithName:@"Futura-Medium" size:18];
    //        button.clipsToBounds = YES;
    //        button.layer.cornerRadius = button.frame.size.width / 2;
    //        button.tag = i;
    //        [button addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    //        [view addSubview:button];
    //
    //        if (i == 0) { [button setTitle:@"Up" forState:UIControlStateNormal]; }
    //        if (i == 1) { [button setTitle:@"Down" forState:UIControlStateNormal]; }
    //        if (i == 2) { [button setTitle:@"Left" forState:UIControlStateNormal]; }
    //        if (i == 3) { [button setTitle:@"Right" forState:UIControlStateNormal]; }
    //    }
    
    
    //NSLog(@"width---->%f",_container.frame.size.width)
    
    UIButton *right = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 30 -13, self.view.frame.size.height/2-100, 30, 60)];
    [right setImage:[UIImage imageNamed:@"Group 44"] forState:UIControlStateNormal];
    [self.view addSubview:right];
    right.tag=1;
    
    [right addTarget:self action:@selector(swipeLeft_right:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *left = [[UIButton alloc]initWithFrame:CGRectMake(13, self.view.frame.size.height/2-100, 30, 60)];
    [left setImage:[UIImage imageNamed:@"Group 3"] forState:UIControlStateNormal];
    [self.view addSubview:left];
    left.tag=2;
      [left addTarget:self action:@selector(swipeLeft_right:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *like = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2+30, self.view.frame.size.height/2, 150, 100)];
    [like setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.view addSubview:like];
    
    //[self loadData];
    
    [_container reloadCardContainer];
    
    [self.view bringSubviewToFront:map_btn];
    [self.view bringSubviewToFront:petlist_btn];
    [self.view bringSubviewToFront:expand_btn];
    
    
    [self.view bringSubviewToFront:header_view];
}


- (void)loadData
{
    _datas = [NSMutableArray array];
    
    for (int i = 0; i < 60; i++) {
        NSDictionary *dict = @{@"image" : [NSString stringWithFormat:@"photo_sample_0%d",i + 1],
                               @"name" : @"Kausik Swip View"};
        [_datas addObject:dict];
    }
}



-(void)swipeLeft_right:(UIButton *)sender
{
    if (sender.tag==1)
    {
         [_container movePositionWithDirection:YSLDraggableDirectionRight isAutomatic:YES];
        
        
        
    }
    else{
        
        
         [_container movePositionWithDirection:YSLDraggableDirectionLeft isAutomatic:YES];
        
        
        
    }
}

#pragma mark -- Selector
- (void)buttonTap:(UIButton *)button
{
    if (button.tag == 0) {
        [_container movePositionWithDirection:YSLDraggableDirectionUp isAutomatic:YES];
    }
    if (button.tag == 1) {
        __weak CardController *weakself = self;
        [_container movePositionWithDirection:YSLDraggableDirectionDown isAutomatic:YES undoHandler:^{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@""
                                                                                     message:@"Do you want to reset?"
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [weakself.container movePositionWithDirection:YSLDraggableDirectionDown isAutomatic:YES];
            }]];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                [weakself.container movePositionWithDirection:YSLDraggableDirectionDefault isAutomatic:YES];
            }]];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }];
        
    }
    if (button.tag == 2) {
        [_container movePositionWithDirection:YSLDraggableDirectionLeft isAutomatic:YES];
    }
    if (button.tag == 3) {
        [_container movePositionWithDirection:YSLDraggableDirectionRight isAutomatic:YES];
    }
}

#pragma mark -- YSLDraggableCardContainer DataSource
- (UIView *)cardContainerViewNextViewWithIndex:(NSInteger)index
{
    NSDictionary *dict = _datas[index];
    CardView *view = [[CardView alloc]initWithFrame:CGRectMake(15, 70, self.view.frame.size.width - 30, self.view.frame.size.height -140)];
    view.backgroundColor = [UIColor whiteColor];
   
    [view.imageView sd_setImageWithURL:[NSURL URLWithString:[dict valueForKey:@"photo_url"]] placeholderImage:[UIImage imageNamed:@"new-user-image-default"] options:SDWebImageTransformAnimatedImage];
    view.label.text = [dict valueForKey:@"service_name"];
    //CELL.subname_lbl.text=[[_api_ary objectAtIndex:indexPath.row]valueForKey:@"sitter_name"];;
    
    [view setView:dict];
    
    
    
    
    
    
    return view;
}

- (NSInteger)cardContainerViewNumberOfViewInIndex:(NSInteger)index
{
    return _datas.count;
}

#pragma mark -- YSLDraggableCardContainer Delegate
- (void)cardContainerView:(YSLDraggableCardContainer *)cardContainerView didEndDraggingAtIndex:(NSInteger)index draggableView:(UIView *)draggableView draggableDirection:(YSLDraggableDirection)draggableDirection
{
    
    NSLog(@"index--->%ld",(long)index);
    
    if (draggableDirection == YSLDraggableDirectionLeft) {
        [cardContainerView movePositionWithDirection:draggableDirection
                                         isAutomatic:NO];
    }
    
    if (draggableDirection == YSLDraggableDirectionRight) {
        [cardContainerView movePositionWithDirection:draggableDirection isAutomatic:NO];
    }
    
    if (draggableDirection == YSLDraggableDirectionUp) {
        [cardContainerView movePositionWithDirection:draggableDirection  isAutomatic:NO];
    }
}

- (void)cardContainderView:(YSLDraggableCardContainer *)cardContainderView updatePositionWithDraggableView:(UIView *)draggableView draggableDirection:(YSLDraggableDirection)draggableDirection widthRatio:(CGFloat)widthRatio heightRatio:(CGFloat)heightRatio
{
    CardView *view = (CardView *)draggableView;
    
    if (draggableDirection == YSLDraggableDirectionDefault) {
        //view.selectedView.alpha = 0;
    }
    
    if (draggableDirection == YSLDraggableDirectionLeft) {
       // view.selectedView.backgroundColor = RGB(215, 104, 91);
//        view.selectedView.alpha = widthRatio/.2 > 1 ? 1 : widthRatio/.2;
//        view.heart_image.image = [UIImage imageNamed:@"error-1"];
        
    }
    
    if (draggableDirection == YSLDraggableDirectionRight) {
        //view.selectedView.backgroundColor = RGB(114, 209, 142);
        
        NSLog(@"ratio--->%f",widthRatio/.2);
        
//        view.selectedView.alpha = widthRatio/.2 > 1 ? 1 : widthRatio/.2;
//        
//         view.heart_image.image = [UIImage imageNamed:@"like"];
    }
    
    if (draggableDirection == YSLDraggableDirectionUp) {
//        view.selectedView.backgroundColor = RGB(66, 172, 225);
//        view.selectedView.alpha = heightRatio > 0.8 ? 0.8 : heightRatio;
    }
}

- (void)cardContainerViewDidCompleteAll:(YSLDraggableCardContainer *)container;
{
    
    
    ///NSLog(@"container.tag-->%@",container.);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [container reloadCardContainer];
    });
}

- (void)cardContainerView:(YSLDraggableCardContainer *)cardContainerView didSelectAtIndex:(NSInteger)index draggableView:(UIView *)draggableView
{
    NSLog(@"++ index : %ld",(long)index);
    
    Profile_1_ViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"profile"];
    obj.sitterid = [[_datas objectAtIndex:index]valueForKey:@"sitter_user_id"];
    [self.navigationController pushViewController:obj animated:YES];

    
}


- (IBAction)petlist_tap:(id)sender {
    

    
    
    NSLog(@"presrnt--->%@",self.navigationController.presentationController);
    
//    
//    if (self.backPOPback.tag==3)
//    {
//       
//        
//        
//        [self.navigationController popViewControllerAnimated:NO];
//        
//     }
//    
//    else if(self.backPOPback.tag==2)
//    {
//    
  
   
    
    PetListing_ViewController *obj_sigup;
    
    for (UIViewController *obj in self.navigationController.viewControllers.reverseObjectEnumerator)
    {
        if ([obj isKindOfClass:[PetListing_ViewController class]])
        {
            
            obj_sigup = (PetListing_ViewController *) obj;
            
            break;
        }
    }

    
    [self.navigationController popToViewController:obj_sigup animated:NO];
//    }
//    
//    else
//    {
//        
//    }
    
    
    
}

- (IBAction)map_tap:(id)sender {
    
    
    
    SearchMapController *obj_sigup;
    
    for (UIViewController *obj in self.navigationController.viewControllers.reverseObjectEnumerator)
    {
        if ([obj isKindOfClass:[SearchMapController class]])
        {
            
            obj_sigup = (SearchMapController *) obj;
            
            break;
        }
    }
    
    if (obj_sigup!=nil)
    {
         [self.navigationController popToViewController:obj_sigup animated:NO];
    }
    else
    {
        SearchMapController *obj_new=[self.storyboard instantiateViewControllerWithIdentifier:@"map"];
        [self.navigationController pushViewController:obj_new animated:NO];
    }
    
    
   
}
    
    


- (IBAction)expand_tap:(id)sender {
    if (map_btn.hidden==YES) {
        [UIView animateWithDuration:0.3f animations:^{
            map_btn.frame=CGRectMake(map_btn.frame.origin.x,expand_btn.frame.origin.y-expand_btn.frame.size.height,map_btn.frame.size.width,map_btn.frame.size.height);
            map_btn.hidden=NO;
            petlist_btn.frame=CGRectMake(petlist_btn.frame.origin.x, expand_btn.frame.origin.y-expand_btn.frame.size.height-expand_btn.frame.size.height, petlist_btn.frame.size.width, petlist_btn.frame.size.height);
            petlist_btn.hidden=NO;
            [expand_btn setImage:[UIImage imageNamed:@"Group 4-1"] forState:UIControlStateNormal];
        }];
    }
    else
    {
        [UIView animateWithDuration:0.3f animations:^{
            
            
            map_btn.frame=CGRectMake(map_btn.frame.origin.x,expand_btn.frame.origin.y,map_btn.frame.size.width,map_btn.frame.size.height);
            petlist_btn.frame=CGRectMake(petlist_btn.frame.origin.x, expand_btn.frame.origin.y, petlist_btn.frame.size.width, petlist_btn.frame.size.height);
            [expand_btn setImage:[UIImage imageNamed:@"Group 4-3"] forState:UIControlStateNormal];
        }completion:^(BOOL finished) {
            petlist_btn.hidden=YES;
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
//        map_btn.frame=CGRectMake(map_btn.frame.origin.x,expand_btn.frame.origin.y,map_btn.frame.size.width,map_btn.frame.size.height);
//        petlist_btn.frame=CGRectMake(petlist_btn.frame.origin.x, expand_btn.frame.origin.y, petlist_btn.frame.size.width, petlist_btn.frame.size.height);
//        [expand_btn setImage:[UIImage imageNamed:@"Group 4-3"] forState:UIControlStateNormal];
//    }completion:^(BOOL finished) {
//        petlist_btn.hidden=NO;
//        map_btn.hidden=NO;
//    }];
//}

-(IBAction)back:(id)sender{
  
    Search_ViewController *obj_sigup;
    
    for (UIViewController *obj in self.navigationController.viewControllers.reverseObjectEnumerator)
    {
        if ([obj isKindOfClass:[Search_ViewController class]])
        {
            
            obj_sigup = (Search_ViewController *) obj;
            
            break;
        }
    }
    
     obj_sigup.filter =@"";
    [self.navigationController popToViewController:obj_sigup animated:YES];
}


- (IBAction)filter:(UIButton *)sender {
    
    
    Search_ViewController *obj_sigup;
    
    for (UIViewController *obj in self.navigationController.viewControllers.reverseObjectEnumerator)
    {
        if ([obj isKindOfClass:[Search_ViewController class]])
        {
            
            obj_sigup = (Search_ViewController *) obj;
            
            break;
        }
    }
    
    
    obj_sigup.filter =@"filter";
    
    [self.navigationController popToViewController:obj_sigup animated:NO];
    
}
@end
