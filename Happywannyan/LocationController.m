//
//  LocationController.m
//  Happywannyan
//
//  Created by Rahul Singha Roy on 19/05/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import "LocationController.h"
#import "LocationCell.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,GMSMapViewDelegate,CLLocationManagerDelegate>
{
   // GMSPlacePicker *_placePicker;
}

@property (nonatomic, retain) CLLocationManager *locationManager;
@end


@implementation LocationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    url_obj=[Json_Class new];
   
    _geometry_ary=[[NSMutableArray alloc]init];
    
    // locationTable.frame = CGRectMake(0, search_view.frame.origin.y+search_view.frame.size.height, self.view.frame.s, <#CGFloat height#>)
    /*
     int inset = gmapView.frame.size.height;
     
     [locationTable setContentInset:UIEdgeInsetsMake(inset-60, 0, 0,0)];
     
     [self.view bringSubviewToFront:gmapView];
     [self.view bringSubviewToFront:search_view];
     
     
     gmapView.delegate = self;
     gmapView.myLocationEnabled = YES;
     gmapView.settings.myLocationButton = YES;
     
     // GOOGLE MAPS SDK: COMPASS
     gmapView.settings.compassButton = YES;
     
     
     CLLocationCoordinate2D  northEast = [gmapView.projection coordinateForPoint:CGPointMake(gmapView.frame.size.width, 0)];
     CLLocationCoordinate2D  southWest = [gmapView.projection coordinateForPoint:CGPointMake(0, gmapView.frame.size.height)];
     
     GMSCoordinateBounds *viewport = [[GMSCoordinateBounds alloc] initWithCoordinate:northEast
     coordinate:southWest];
     
     
     GMSPlacePickerConfig *config = [[GMSPlacePickerConfig alloc] initWithViewport:nil];
     
     
     
     
     _placePicker = [[GMSPlacePicker alloc] initWithConfig:config];
     
     
     
     [_placePicker pickPlaceWithCallback:^(GMSPlace *place, NSError *error)
     {
     
     
     NSLog(@"Error--->%@",error.localizedDescription);
     
     
     if (error != nil) {
     NSLog(@"Pick Place error %@", [error localizedDescription]);
     return;
     }
     
     if (place != nil) {
     NSLog(@"Place name %@", place.name);
     NSLog(@"Place address %@", place.formattedAddress);
     NSLog(@"Place attributions %@", place.attributions.string);
     } else {
     NSLog(@"No place selected");
     }
     }];
     
     
     
     
     
     [self checklocation];
     
     */
    
}
- (void)mapView:(GMSMapView *)mapView willMove:(BOOL)gesture
{
    NSLog(@"gesture-->%d",(int)gesture);
}

- (void)mapView:(GMSMapView *)mapView
didChangeCameraPosition:(GMSCameraPosition *)position
{
    NSLog(@"gesture-->");
}

-(void)checklocation
{
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    
    
    [self.locationManager startUpdatingLocation];
    
    
    
    if([CLLocationManager locationServicesEnabled])
    {
        if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            
        }
        
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:newLocation.coordinate.latitude
                                                            longitude:newLocation.coordinate.longitude
                                                                 zoom:17.0];
    [gmapView animateToCameraPosition:camera];
    
    
    
    //...
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Cannot find the location.");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



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
    
    
    
    
    
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, myCell.frame.size.height/2 - 20/2, 13, 20)];
    
    imageview.image = [UIImage imageNamed:@"placeholder"];
    
    [myCell addSubview:imageview];
    
    
    
    
    cell_lbl = [[UILabel alloc]initWithFrame:CGRectMake(imageview.frame.origin.x+imageview.frame.size.width +5 , 0, myCell.frame.size.width-(imageview.frame.origin.x+imageview.frame.size.width+15), myCell.frame.size.height)];
    
    cell_lbl.backgroundColor = [UIColor clearColor];
    cell_lbl.textColor = [UIColor blackColor];
    cell_lbl.font = [UIFont fontWithName:@"PingFang SC" size:14];
    cell_lbl.text = [[location_ary objectAtIndex:indexPath.row] valueForKey:@"formatted_address"];
    
    [myCell addSubview:cell_lbl];
    
    
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor =[UIColor clearColor]; //[UIColor colorWithRed:(189/255.0) green:(62/255.0) blue:(73/255.0) alpha:1.0];
    [myCell setSelectedBackgroundView:bgColorView];
    
    
    
    myCell.backgroundColor =[UIColor whiteColor];
    
    
    
    
    
    
}





-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return location_ary.count;
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
    //NSString *str=[location_ary objectAtIndex:indexPath.row];
    [_location_btn setTitle:[[location_ary objectAtIndex:indexPath.row] valueForKey:@"formatted_address"] forState:UIControlStateNormal];
    _clr.hidden=NO;
    _first_view.hidden=YES;
    _search_tbl.hidden=NO;
    
    
    
    
    _geometry_ary=[[location_ary objectAtIndex:indexPath.row] valueForKey:@"geometry"];
    
    NSLog(@"%@",[location_ary objectAtIndex:indexPath.row]);
    [_search_tbl reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    
    
    NSString *newString = [location_txt.text stringByReplacingCharactersInRange:range withString:string];
    
    if (newString.length>0)
    {
         [self urlData:newString];
    }
    
    
    
   
   // [locationTable reloadData];
    return YES;
}

-(void)urlData:(NSString *)str
{
    NSString *url_str=[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?address=%@&key=AIzaSyDAS-0Wh-K3QII2h7DgO8bd-f1dSy4lW3M",str];
    
    NSString *urlUTF8 = [url_str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //    NSString *postdata=[NSString stringWithFormat:@"address=%@",location_txt.text];
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
    
    [request setURL:[NSURL URLWithString:urlUTF8]];
    
//        [request setHTTPMethod:@"GET"];
//    
//        [request setHTTPBody:[postdata dataUsingEncoding:NSUTF8StringEncoding]];
    
    [url_obj GlobalDict:request Globalstr:@"array" lodaer:YES Withblock:^(id result, NSError *error) {
  
        
        if ([[result valueForKey:@"status"] isEqualToString:@"OK"]) {
            
           location_ary=[result valueForKey:@"results"];
      
            [locationTable reloadData];
        }
        else
        {
            
        }
    }];
    
    
    
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
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
