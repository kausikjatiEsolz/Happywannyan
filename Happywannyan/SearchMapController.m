//
//  SearchMapController.m
//  Happywannyan
//
//  Created by Rahul Singha Roy on 23/05/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import "SearchMapController.h"
#import "PetListing_ViewController.h"
#import "CardController.h"
#import "Search_ViewController.h"
#import "Profile@1_ViewController.h"

@interface SearchMapController ()<GMSMapViewDelegate>
{
    //PetListing_ViewController *obj;
    
    UIButton *backPOP;
}

@end

@implementation SearchMapController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    backPOP = [UIButton new];
    
    
    
    cardview_btn.hidden=NO;
    back_btn.hidden=NO;
    
    
    if (_check_lat_lon.length>0)
    {
        filter.hidden = YES;
        cardview_btn.hidden=YES;
        back_btn.hidden=YES;
         header_lbl.text = @"Profile";
        
         GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] init];
        NSArray *data_latlong = [_check_lat_lon componentsSeparatedByString:@","];
        
        CLLocationCoordinate2D circleCenter = CLLocationCoordinate2DMake([[data_latlong objectAtIndex:0]doubleValue], [[data_latlong objectAtIndex:1]doubleValue]);
        GMSMarker *london = [GMSMarker markerWithPosition:circleCenter];
        
        london.appearAnimation = kGMSMarkerAnimationPop;
        //london.icon = [UIImage imageNamed:@"paw-print-"];
        london.map =maps ;
        
         bounds = [bounds includingCoordinate:london.position];
        
         maps.delegate = nil;
        
         [maps animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:30.0f]];
    }
    
    else
    {
    
    _data_Array = [[NSUserDefaults standardUserDefaults] valueForKey:@"result"];
    header_lbl.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"search_location"];
    
    NSLog(@"array--->%@",_data_Array);
    
    maps.delegate = self;
    
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] init];
    
    for (int i=0; i<_data_Array.count; i++)
    {
        CLLocationCoordinate2D circleCenter = CLLocationCoordinate2DMake([[[[_data_Array objectAtIndex:i] valueForKey:@"latlon"] objectAtIndex:0]doubleValue], [[[[_data_Array objectAtIndex:i] valueForKey:@"latlon"] objectAtIndex:1]doubleValue]);
        GMSMarker *london = [GMSMarker markerWithPosition:circleCenter];
        
        NSString *custom_name = [NSString stringWithFormat:@"%@$^%@$^%@$^%@$^%@$^%@",[[_data_Array objectAtIndex:i] valueForKey:@"service_name"],[[_data_Array objectAtIndex:i] valueForKey:@"whole_address"],[[_data_Array objectAtIndex:i] valueForKey:@"sitter_name"],[[_data_Array objectAtIndex:i] valueForKey:@"ave_rating"],[[_data_Array objectAtIndex:i] valueForKey:@"price_one"],[[_data_Array objectAtIndex:i] valueForKey:@"sitter_user_id"]];
        
        london.title = custom_name;
        london.icon = [UIImage imageNamed:@"paw-print-"];
        london.map =maps ;
        //valueForKey:@""]
        
        bounds = [bounds includingCoordinate:london.position];
    }
    
    
    [maps animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:30.0f]];
    
    
        
    }
    
    maps.settings.rotateGestures = NO;
    //    maps.settings.zoomGestures = NO;
    
    
    //        GMSVisibleRegion visibleRegion = maps.projection.visibleRegion;
    //        bounds = [[GMSCoordinateBounds alloc] initWithRegion:visibleRegion];
    //
    //
    //        CLLocationCoordinate2D northEast = bounds.northEast;
    //        CLLocationCoordinate2D southWest = bounds.southWest;
    //
    //        [self animateBoundsNorth:northEast.latitude West:northEast.longitude South:southWest.latitude East:southWest.longitude Padding:0];
    
    
    
}

-(void) animateBoundsNorth:(CGFloat)north West:(CGFloat)west South:(CGFloat)south East:(CGFloat)east Padding:(int)padding {
    
    CGFloat northRad = north * M_PI / 180.0;
    CGFloat northProj = logf(tanf(M_PI_4 + northRad/2.0));
    CGFloat southRad = south * M_PI / 180.0;
    CGFloat southProj = logf(tanf(M_PI_4 + southRad/2.0));
    CGFloat topRad = 85.0 * M_PI / 180.0;
    CGFloat topProj = logf(tanf(M_PI_4 + topRad/2.0));
    CGFloat zoomLat = log2f((maps.bounds.size.height - padding * 2) * 2 * topProj /(northProj - southProj)) - 8;
    CGFloat zoomLon = log2f((maps.bounds.size.width - padding * 2) * 360/(east - west)) - 8;
    
    GMSCameraUpdate *update = [GMSCameraUpdate setTarget:CLLocationCoordinate2DMake((north+south)/2.0, (west+east)/2.0) zoom:MIN(zoomLat, zoomLon)];
    
    
    [maps animateWithCameraUpdate:update];
    
    
}

- (void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position
{
    
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
    
}

- (IBAction)backTosearch:(UIButton *)sender {
    
    
    
    if (_check_lat_lon.length>0)
    {
    
        [self.navigationController popViewControllerAnimated:NO];
    }
    
    else
        
    {
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
}

- (IBAction)expand:(id)sender {
    
    if (cardview_btn.hidden==YES) {
        [UIView animateWithDuration:0.3f animations:^{
            cardview_btn.frame=CGRectMake(cardview_btn.frame.origin.x,expand_btn.frame.origin.y-expand_btn.frame.size.height-expand_btn.frame.size.height,cardview_btn.frame.size.width,cardview_btn.frame.size.height);
            cardview_btn.hidden=NO;
            back_btn.frame=CGRectMake(back_btn.frame.origin.x, expand_btn.frame.origin.y-expand_btn.frame.size.height, back_btn.frame.size.width, back_btn.frame.size.height);
            back_btn.hidden=NO;
            [expand_btn setImage:[UIImage imageNamed:@"Group 4-1"] forState:UIControlStateNormal];
        }];
    }
    else
    {
        [UIView animateWithDuration:0.3f animations:^{
            
            
            back_btn.frame=CGRectMake(back_btn.frame.origin.x,expand_btn.frame.origin.y,back_btn.frame.size.width,back_btn.frame.size.height);
            cardview_btn.frame=CGRectMake(cardview_btn.frame.origin.x, expand_btn.frame.origin.y, cardview_btn.frame.size.width, cardview_btn.frame.size.height);
            [expand_btn setImage:[UIImage imageNamed:@"Group 4-3"] forState:UIControlStateNormal];
        }completion:^(BOOL finished) {
            cardview_btn.hidden=YES;
            back_btn.hidden=YES;
        }];
    }
    
}
- (IBAction)cardview:(id)sender{
    
    
    
    CardController *obj_sigup;
    
    for (UIViewController *obj in self.navigationController.viewControllers.reverseObjectEnumerator)
    {
        if ([obj isKindOfClass:[CardController class]])
        {
            
            obj_sigup = (CardController *) obj;
            
            break;
        }
    }
    
    if (obj_sigup!=nil)
    {
        [self.navigationController popToViewController:obj_sigup animated:NO];
    }
    else
    {
        backPOP.tag=3;
        
        CardController *obj_new=[self.storyboard instantiateViewControllerWithIdentifier:@"card"];
        obj_new.backPOPback = backPOP;
        [self.navigationController pushViewController:obj_new animated:NO];
    }

    
    
    
    
}


#pragma Gmaps method


- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker
{
    
    UIView *baseview =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 253, 110)];
    baseview.backgroundColor = [UIColor clearColor];
    UIView *header_data = [[UIView alloc]initWithFrame:CGRectMake(0, 0, baseview.frame.size.width, 90)];
    header_data.backgroundColor = [UIColor whiteColor];
    [baseview addSubview:header_data];
    UILabel *markertext = [[UILabel alloc]initWithFrame:CGRectMake(17, 14, 145, 21)];
    
    markertext.font = [UIFont fontWithName:@"PingFang SC" size:14.0f];
    markertext.textAlignment = NSTextAlignmentLeft;
    markertext.textColor = [UIColor darkGrayColor];
    
    
    
    UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(170, 14, 65, 21)];
    
    time.font = [UIFont fontWithName:@"PingFang SC Semibold" size:12.0f];
    time.textAlignment = NSTextAlignmentRight;
    time.textColor = [UIColor redColor];
    
   
    
    
    
    UILabel *sittername = [[UILabel alloc]initWithFrame:CGRectMake(17, 39, 145, 21)];
    
   // sittername.backgroundColor = [UIColor redColor];
    sittername.font = [UIFont fontWithName:@"PingFang SC" size:12.0f];
    sittername.textAlignment = NSTextAlignmentLeft;
    sittername.textColor = [UIColor darkGrayColor];
    
    UILabel *location = [[UILabel alloc]initWithFrame:CGRectMake(17, sittername.frame.origin.y+sittername.frame.size.height+5, 127, 21)];
    
    location.font = [UIFont fontWithName:@"PingFang SC" size:12.0f];
    location.textAlignment = NSTextAlignmentLeft;
    location.textColor = [UIColor darkGrayColor];
    
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(baseview.frame.size.width/2-15/2, header_data.frame.size.height-7, 15, 28)];
    
    img.image =[UIImage imageNamed:@"down-arrow"];
    
    
    [header_data addSubview:markertext];
    [header_data addSubview:time];
    [header_data addSubview:location];
    
    [header_data addSubview:sittername];
    
   
    
    
    [baseview addSubview:img];
    
     [baseview bringSubviewToFront:img];
    
    
    header_data.layer.shadowColor = [[UIColor darkGrayColor] CGColor];
    header_data.layer.shadowRadius = 5.0f;
    header_data.layer.shadowOpacity = 0.5;
    header_data.layer.shadowOffset = CGSizeZero;
    header_data.layer.masksToBounds = NO;
    
    
    
   
    
  
    
    
    
    NSArray *data = [marker.title componentsSeparatedByString:@"$^"];
    
    
    sittername.text = [data objectAtIndex:2];
    
    NSLog(@"data--->%@",data);
    
    
    if (data.count>0)
    {
    markertext.text =[data objectAtIndex:0];
    
    }
    
    
        location.text =[data objectAtIndex:1];
    
    time.text = [NSString stringWithFormat:@"¥ %@",[data objectAtIndex:data.count -2]];
    
    
    int x =time.frame.origin.x+time.frame.size.width-10;
    
    for (int i=5; i>0; i--)
    {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(x, sittername.frame.origin.y+sittername.frame.size.height/2-5, 10, 10)];
        
        if (i<=[[data objectAtIndex:3] intValue])
        {
            img.image = [UIImage imageNamed:@"favorite"];
        }
        else
        {
            img.image = [UIImage imageNamed:@"star"];
        }
        
        
        
        [header_data addSubview:img];
        
        
        x = x-10-2;
    }
    
 

    return baseview;
    
}

- (void) mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(nonnull GMSMarker *)marker
{

    
     NSArray *data = [marker.title componentsSeparatedByString:@"$^"];
    
    Profile_1_ViewController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"profile"];
    obj.sitterid = [NSString stringWithFormat:@"%@",[data objectAtIndex:data.count-1]];
    [self.navigationController pushViewController:obj animated:YES];
    
    
    
}



//-(void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    
//    [UIView animateWithDuration:0.3f animations:^{
//        
//        
//        back_btn.frame=CGRectMake(back_btn.frame.origin.x,expand_btn.frame.origin.y,back_btn.frame.size.width,back_btn.frame.size.height);
//        cardview_btn.frame=CGRectMake(cardview_btn.frame.origin.x, expand_btn.frame.origin.y, cardview_btn.frame.size.width, cardview_btn.frame.size.height);
//        [expand_btn setImage:[UIImage imageNamed:@"Group 4-3"] forState:UIControlStateNormal];
//    }completion:^(BOOL finished) {
//        cardview_btn.hidden=NO;
//        back_btn.hidden=NO;
//    }];
//
//}

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
