//
//  Search_ViewController.m
//  Happywannyan_App
//
//  Created by Kausik_Jati on 18/05/17.
//  Copyright © 2017 Kausik_Jati. All rights reserved.
//

#import "Search_ViewController.h"
#import "Search_Cell.h"
#import "LocationController.h"
#import "leftmenu.h"
#import "CalenderController.h"
#import "UIImageView+WebCache.h"
#import "PetListing_ViewController.h"
#import <GooglePlaces/GooglePlaces.h>
#import <CoreLocation/CoreLocation.h>
#import "YXSpritesLoadingView.h"



@interface Search_ViewController ()<GMSAutocompleteViewControllerDelegate,CLLocationManagerDelegate>
{
    leftmenu *leftMenu_obj;
    CalenderController *obj;
    LocationController *obj_new;
    
    CGRect clear_btnframe;
    CGRect gpsbtnframe;
    
    CLLocationManager *locationManager;
    
    CGFloat latitude,longitude;
    
    
    
    NSDictionary *location_data;
    
    
    NSMutableDictionary *latlong_data;
    
    //BOOL gpsTap;
    
    BOOL selectRow;
    
    
}

@end

@implementation Search_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    //gpsTap =NO;
    
    selectRow = false;
    
    ary1=[[NSMutableArray alloc]init];
    ary2=[[NSMutableArray alloc]init];
    ary3=[[NSMutableArray alloc]init];
    petage_ary=[[NSMutableArray alloc]init];
    petsize_ary=[[NSMutableArray alloc]init];
    otheroption_ary=[[NSMutableArray alloc]init];
    
    latlong_data = [NSMutableDictionary new];
    
    
    
    // walkingtbl_ary=[[NSMutableArray alloc]initWithObjects:@"ABC",@"ABC",@"ABC",@"ABC", nil];
//    UIColor *color = [UIColor colorWithRed:(189/255.0) green:(62/255.0) blue:(73/255.0) alpha:1];
//    search_btn.layer.shadowColor = [color CGColor];
//    search_btn.layer.shadowRadius = 5.0f;
//    search_btn.layer.shadowOpacity = 1.5;
//    search_btn.layer.shadowOffset = CGSizeZero;
//    search_btn.layer.masksToBounds = NO;
//    
//    search_btn.layer.cornerRadius = 20;
    
    searchbtn_lbl.frame=CGRectMake(search_btn.frame.origin.x+search_btn.frame.size.width/8, search_btn.frame.origin.y+10, searchbtn_lbl.frame.size.width, searchbtn_lbl.frame.size.height);
    
    search_btn.hidden=YES;
    url_obj=[Json_Class new];
    
    
    [_location_btn setTitle: @"Search postal code or address" forState:UIControlStateNormal];
    
    _clr.hidden=YES;
    _clr_calender.hidden=YES;
    _first_view.hidden=NO;
    walking_view.hidden=YES;
    _search_tbl.hidden=YES;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@parent_service",App_Domain_Url]];
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
    
    [request setURL:url];
    
    [url_obj GlobalDict:request Globalstr:@"array" lodaer:YES Withblock:^(id result, NSError *error) {
        
        main_ary=[result valueForKey:@"serviceCatList"];
        allpetdetails_ary=[result valueForKey:@"allPetDetails"];
        [_search_tbl reloadData];
        //[walking_tbl reloadData];
        
    }];
    _search_tbl.frame=CGRectMake(0, search_mainview.frame.origin.y+search_mainview.frame.size.height, self.view.frame.size.width, _search_tbl.frame.size.height);
    walking_tbl.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    walking_tbl.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
    [walking_tbl reloadData];
    
    gpsbtnframe = gpsBtn.frame;
    
    clear_btnframe = _clr.frame;
    
    
    
    gpsBtn.frame = clear_btnframe;
    
    petsize_str=@"";
    petage_str=@"";
    pettype_str=@"";
    servicat_str=@"";
    
    
    
    /*  Location    */
    
    
    
    
    
    
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    
    locationManager.delegate = self;
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    
    
    
    //[locationManager startUpdatingLocation];
    
    
    
    if([CLLocationManager locationServicesEnabled]){
        
        //////NSLog(@"Location Services Enabled");
        
        if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied)
        {
            UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:@"App Location Permission Denied"
                                                             message:@"To re-enable, please go to Settings and turn on Location Service for Happywannyan app."
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
            [alert show];
        }
    }
    
    if([CLLocationManager locationServicesEnabled]){
        
        //////NSLog(@"Location Services Enabled");
        
        
        [locationManager startUpdatingLocation];
        
        gpsBtn.hidden=NO;
        
        if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied)
        {
            gpsBtn.hidden = YES;
        }
    }
    
    
    
    
    _first_view.hidden =YES;
    _search_tbl.hidden =NO;
    
    search_btn.hidden= YES;
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    
    latitude = newLocation.coordinate.latitude;
    longitude = newLocation.coordinate.longitude;
    
    
    [self urlData:[NSString stringWithFormat:@"%f,%f",latitude,longitude]];
    
    
    [locationManager stopUpdatingLocation];
    
}



-(void)urlData:(NSString *)str
{
    
    Json_Class *new_obj = [Json_Class new];
    
    NSString *url_str=[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?address=%@&key=AIzaSyDAS-0Wh-K3QII2h7DgO8bd-f1dSy4lW3M",str];
    
    NSString *urlUTF8 = [url_str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //    NSString *postdata=[NSString stringWithFormat:@"address=%@",location_txt.text];
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
    
    [request setURL:[NSURL URLWithString:urlUTF8]];
    
    //        [request setHTTPMethod:@"GET"];
    //
    //        [request setHTTPBody:[postdata dataUsingEncoding:NSUTF8StringEncoding]];
    
    [new_obj GlobalDict:request Globalstr:@"array" lodaer:NO Withblock:^(id result, NSError *error) {
        
        if ([[result valueForKey:@"status"] isEqualToString:@"OK"]) {
            
            
            NSArray *array_location = (NSArray *)[result valueForKey:@"results"];
            
            location_data = [array_location objectAtIndex:0];
            
            
            
            [latlong_data removeAllObjects];
            
            
            
            [latlong_data setObject:[location_data valueForKey:@"formatted_address"] forKey:@"formatted_address"];
            [latlong_data setObject:[[[location_data valueForKey:@"geometry"] valueForKey:@"location"] valueForKey:@"lat"] forKey:@"lat"];
             [latlong_data setObject:[[[location_data valueForKey:@"geometry"] valueForKey:@"location"] valueForKey:@"lng"] forKey:@"long"];
             [latlong_data setObject:[[[[location_data valueForKey:@"geometry"] valueForKey:@"viewport"] valueForKey:@"northeast"] valueForKey:@"lat"] forKey:@"ne_lat"];
             [latlong_data setObject:[[[[location_data valueForKey:@"geometry"] valueForKey:@"viewport"] valueForKey:@"northeast"] valueForKey:@"lng"] forKey:@"ne_lng"];
             [latlong_data setObject:[[[[location_data valueForKey:@"geometry"] valueForKey:@"viewport"] valueForKey:@"southwest"] valueForKey:@"lat"] forKey:@"sw_lat"];
             [latlong_data setObject:[[[[location_data valueForKey:@"geometry"] valueForKey:@"viewport"] valueForKey:@"southwest"] valueForKey:@"lng"] forKey:@"sw_lng"];
            
            
            NSLog(@"latlong_data--->%@",latlong_data);
            
            
            if (latlong_data.count>0 )
            {
                [_location_btn setTitle:[latlong_data valueForKey:@"formatted_address"] forState:UIControlStateNormal];
                
                _clr.hidden = NO;
                _first_view.hidden =YES;
                _search_tbl.hidden =NO;
                
                gpsBtn.frame = gpsbtnframe;
                _clr.frame = clear_btnframe;
                
                
            }
            
            
            
        }
    }];
    
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_search_tbl) {
        return 48;
    }
    else if (tableView==walking_tbl)
    {
        if (indexPath.section==1) {
            return 30;
        }
        else if (indexPath.section==2) {
            return 30;
        }
        else if (indexPath.section==4) {
            return 30;
        }
        else
            return 0;
    }
    else
    {
        return 0;
    }
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==_search_tbl) {
        return 1;
    }
    else if (tableView==walking_tbl)
    {
        return 5;
    }
    else
    {
        return 0;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView==_search_tbl) {
        return _headerview.frame.size.height;
    }
    
    else if (tableView==walking_tbl)
    {
        if (section==0) {
            return _walking_headerview1.frame.size.height;
        }
        else if (section==1) {
            return _walking_headerview2.frame.size.height;
        }
        else if (section==2) {
            return _walking_headerview3.frame.size.height;
        }
        else if (section==3) {
            return _walking_headerview4.frame.size.height;
        }
        else if (section==4) {
            return _walking_headerview5.frame.size.height;
        }
        else
        {
            return 0;
        }
        
    }
    
    else
    {
        return 0;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (tableView==_search_tbl)
    {
        return _headerview;
    }
    else if (tableView==walking_tbl)
    {
        if (section==0) {
            return _walking_headerview1;
        }
        else if (section==1) {
            return _walking_headerview2;
        }
        else if (section==2) {
            return _walking_headerview3;
        }
        else if (section==3) {
            return _walking_headerview4;
        }
        else if (section==4) {
            return _walking_headerview5;
        }
        else
        {
            return 0;
        }
    }
    else
    {
        return nil;
    }
    
}


- (void)slideValueChanged:(id)control
{
    
    //    NSLog(@"Low--->%@",[NSString stringWithFormat:@"%d",(int)slider.lowerValue]);
    //    NSLog(@"High--->%@",[NSString stringWithFormat:@"%d",(int)slider.upperValue]);
    rangeslider_lbl_down.text=[NSString stringWithFormat:@"¥ %d",(int)slider.lowerValue];
    rangeslider_lbl_up.text=[NSString stringWithFormat:@"¥ %d",(int)slider.upperValue];
    
    //NSLog(@"Uper--->%@",);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (tableView==_search_tbl)
    {
        return main_ary.count;
    }
    else if (tableView==walking_tbl)
    {
        if (section==0) {
            return 0;
        }
        else if (section==1) {
            return petsize_ary.count;
        }
        else if (section==2) {
            return petage_ary.count;
        }
        else if (section==3) {
            return 0;
        }
        else if (section==4) {
            return otheroption_ary.count;
        }
        else
        {
            return 0;
        }
    }
    else
    {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (tableView==_search_tbl)
    {
        CELL=[_search_tbl dequeueReusableCellWithIdentifier:@"Search"forIndexPath:indexPath];
        CELL.catagory_lbl.text=[[main_ary objectAtIndex:indexPath.row]valueForKey:@"name"];
        [CELL.catagory_lbl setTextColor:[UIColor blackColor]];
        
        [CELL.catagory_img sd_setImageWithURL:[NSURL URLWithString:[[main_ary objectAtIndex:indexPath.row]valueForKey:@"default_image"]] placeholderImage:nil];
        CELL.selectionStyle=UITableViewCellSelectionStyleNone;
        
        
        //CELL.backgroundColor = [UIColor lightGrayColor];
        return CELL;
    }
    
    
    else if (tableView==walking_tbl)
    {
        CELL1=[walking_tbl dequeueReusableCellWithIdentifier:@"Walking"forIndexPath:indexPath];
        
        if (indexPath.section==1)
        {
            CELL1.walkingcell_lbl.text=[[[petsize_ary objectAtIndex:indexPath.row]valueForKey:@"option_name"]mutableCopy];
            CELL1.selectionStyle=UITableViewCellSelectionStyleNone;
            
            
            if ([ary1 containsObject:[[petsize_ary objectAtIndex:indexPath.row]valueForKey:@"option_value"]]) {
                
                CELL1.walking_tbl_select.image=[UIImage imageNamed:@"check-box-color"];
            }
            else {
                CELL1.walking_tbl_select.image=[UIImage imageNamed:@"check-box-empty"];
            }
            
            
            return CELL1;
        }
        
        
        else if (indexPath.section==2)
        {
            CELL1.walkingcell_lbl.text=[[petage_ary objectAtIndex:indexPath.row] valueForKey:@"option_name"];
            CELL1.selectionStyle=UITableViewCellSelectionStyleNone;
            
            if ([ary2 containsObject:[[petage_ary objectAtIndex:indexPath.row]valueForKey:@"option_value"]]) {
                
                CELL1.walking_tbl_select.image=[UIImage imageNamed:@"check-box-color"];
            }
            else {
                CELL1.walking_tbl_select.image=[UIImage imageNamed:@"check-box-empty"];
            }
            return CELL1;
        }
        
        
        else if (indexPath.section==4)
        {
            CELL1.walkingcell_lbl.text=[[otheroption_ary objectAtIndex:indexPath.row] valueForKey:@"option_name"];
            CELL1.selectionStyle=UITableViewCellSelectionStyleNone;
            
            if ([ary3 containsObject:[[otheroption_ary objectAtIndex:indexPath.row]valueForKey:@"option_value"]]) {
                
                CELL1.walking_tbl_select.image=[UIImage imageNamed:@"check-box-color"];
            }
            else {
                CELL1.walking_tbl_select.image=[UIImage imageNamed:@"check-box-empty"];
            }
            return CELL1;
            
        }
        
        
        else
        {
            return nil;
        }
        
    }
    else
    {
        return nil;
    }
}

- (IBAction)clear:(id)sender {
 //   _search_tbl.hidden=YES;
    [_location_btn setTitle: @"Search postal code or address" forState:UIControlStateNormal];
    _clr.hidden=YES;
//    _first_view.hidden=YES;
//    walking_view.hidden=YES;
//    search_btn.hidden=YES;
    
    
    gpsBtn.frame = clear_btnframe;
    
}
- (IBAction)location:(id)sender {
    //    if (obj_new==nil)
    
    //        UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //        obj_new=[sb instantiateViewControllerWithIdentifier:@"location"];
    //        [self presentViewController:obj_new animated:YES completion:nil];
    //
    //    obj_new.location_btn = self.location_btn;
    //    obj_new.clr=_clr;
    //    obj_new.search_tbl=_search_tbl;
    //    obj_new.first_view=_first_view;
    
    
    
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    GMSAutocompleteFilter *filter = [[GMSAutocompleteFilter alloc] init];
    filter.country = @"JP";
    
    acController.autocompleteFilter = filter;
    
    [self presentViewController:acController animated:YES completion:nil];
    
}

///kausik


// Handle the user's selection.
- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    
    // Do something with the selected place.
//    NSLog(@"Place name %@", place.name);
//    NSLog(@"Place address %@", place.formattedAddress);
//    NSLog(@"Place lat = %f \n Place lon = %f", place.coordinate.latitude,place.coordinate.longitude);
//    NSLog(@"Place viewport southWest.latitude= %f \n southWest.longitude=%f \n northEast.latitude=%f \n northEast.longitude=%f", place.viewport.southWest.latitude,place.viewport.southWest.longitude,place.viewport.northEast.latitude,place.viewport.northEast.longitude);
    
    
    
    
    [latlong_data removeAllObjects];
    
    
    
    [latlong_data setObject:place.formattedAddress forKey:@"formatted_address"];
    [latlong_data setObject:[NSString stringWithFormat:@"%f",place.coordinate.latitude] forKey:@"lat"];
    [latlong_data setObject:[NSString stringWithFormat:@"%f",place.coordinate.longitude] forKey:@"long"];
    [latlong_data setObject:[NSString stringWithFormat:@"%f",place.viewport.northEast.latitude] forKey:@"ne_lat"];
    [latlong_data setObject:[NSString stringWithFormat:@"%f",place.viewport.northEast.longitude] forKey:@"ne_lng"];
    [latlong_data setObject:[NSString stringWithFormat:@"%f",place.viewport.southWest.latitude] forKey:@"sw_lat"];
    [latlong_data setObject:[NSString stringWithFormat:@"%f",place.viewport.southWest.longitude] forKey:@"sw_lng"];
    
    
    
    NSLog(@"la--->%@",latlong_data);
    
    [self.location_btn setTitle:place.name forState:UIControlStateNormal];
    _clr.hidden = NO;
    _first_view.hidden =YES;
    _search_tbl.hidden =NO;
    
    
    
    gpsBtn.frame = gpsbtnframe;
    
    
    
    // }
    

    
//    else
//    {
//        [YXSpritesLoadingView errorInfo:@"Please Select Location"];
//    }
    
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        
        
        if (![_filter isEqualToString:@"filter"])
        {
            
            if (!([_location_btn.titleLabel.text  isEqualToString:@"Search postal code or address"] )&& selectRow == YES)
            {
                [[NSUserDefaults standardUserDefaults]setObject:_location_btn.titleLabel.text forKey:@"search_location"];
                
                [self urlData:@"" end:@"" page:@"0"];
            }
            else
            {
               // [YXSpritesLoadingView errorInfo:@"Please Select options"];
            }
            
        }
        
    }];
    
}

- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}

// User canceled the operation.
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

///

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (tableView==_search_tbl) {
       
        petsize_str=@"";
        petage_str=@"";
        pettype_str=@"";
        //servicat_str=@"";
        
        
        selectRow =YES;
        
        NSString *str=[[main_ary objectAtIndex:indexPath.row]valueForKey:@"name"];
        servicat_str=[[main_ary objectAtIndex:indexPath.row]valueForKey:@"id"];
        NSLog(@"%@",servicat_str);
        walking_headerview_lbl.text=str;
        
        choosepettype_lbl.text=[[allpetdetails_ary objectAtIndex:0] valueForKey:@"name"];
        [self choosepettype:[[allpetdetails_ary objectAtIndex:0] valueForKey:@"id"]];
        
        
        [walking_headerview_img sd_setImageWithURL:[NSURL URLWithString:[[main_ary objectAtIndex:indexPath.row]valueForKey:@"selected_image"]]];
        
        
        
        
        
        
        
        
//        _search_tbl.hidden=YES;
//        _first_view.hidden=YES;
//        walking_view.hidden=NO;
        //        _walking_headerview2.hidden=YES;
        //        _walking_headerview3.hidden=YES;
        //        _walking_headerview4.hidden=YES;
        //        _walking_headerview5.hidden=YES;
        
        //        petsize_btn.enabled=NO;
        //        petage_btn.enabled=NO;
        
        // choosepettype_lbl.text=@"";
        
        search_btn.hidden=YES;
        
        
        CELL=[tableView cellForRowAtIndexPath:indexPath];
        CELL.selection_img.image=[UIImage imageNamed:@"checked"];
        [CELL.catagory_lbl setTextColor:[UIColor colorWithRed:(189/255.0) green:(62/255.0) blue:(73/255.0) alpha:1]];
        [CELL.catagory_img sd_setImageWithURL:[NSURL URLWithString:[[main_ary objectAtIndex:indexPath.row]valueForKey:@"selected_image"]]];
        [petsize_ary removeAllObjects];
        [petage_ary removeAllObjects];
        [otheroption_ary removeAllObjects];
        [ary1 removeAllObjects];
        [ary2 removeAllObjects];
        [ary3 removeAllObjects];
        [walking_tbl reloadData];
        
        
        
        
        if (![_location_btn.titleLabel.text  isEqualToString:@"Search postal code or address"] && selectRow == YES)
        {
//            [[NSUserDefaults standardUserDefaults]setObject:_location_btn.titleLabel.text forKey:@"search_location"];
            
            [self urlData:@"" end:@"" page:@"0"];
        }
        else
        {
           // [YXSpritesLoadingView errorInfo:@"Please Select Location"];
        }
        
        
    }
    if (tableView==walking_tbl) {
        
        
        if (indexPath.section==1)
        {
            
            if ([ary1 containsObject:[[petsize_ary objectAtIndex:indexPath.row] valueForKey:@"option_value"]]) {
                [ary1 removeObject:[[petsize_ary objectAtIndex:indexPath.row] valueForKey:@"option_value"]];
            }
            else
            {
                [ary1 addObject:[[petsize_ary objectAtIndex:indexPath.row] valueForKey:@"option_value"]];
                
                
            }
            
            petsize_str=[ary1 componentsJoinedByString:@","];
            
            [walking_tbl beginUpdates];
            [walking_tbl reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [walking_tbl endUpdates];
            
        }
        else if (indexPath.section==2)
        {
            if ([ary2 containsObject:[[petage_ary objectAtIndex:indexPath.row] valueForKey:@"option_value"]]) {
                [ary2 removeObject:[[petage_ary objectAtIndex:indexPath.row] valueForKey:@"option_value"]];
            }
            else
            {
                [ary2 addObject:[[petage_ary objectAtIndex:indexPath.row] valueForKey:@"option_value"]];
                
            }
            
            petage_str=[ary2 componentsJoinedByString:@","];
            
            [walking_tbl beginUpdates];
            [walking_tbl reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [walking_tbl endUpdates];
        }
        else if (indexPath.section==4)
        {
            
            if ([ary3 containsObject:[[otheroption_ary objectAtIndex:indexPath.row] valueForKey:@"option_value"]]) {
                [ary3 removeObject:[[otheroption_ary objectAtIndex:indexPath.row] valueForKey:@"option_value"]];
            }
            else
            {
                [ary3 addObject:[[otheroption_ary objectAtIndex:indexPath.row] valueForKey:@"option_value"]];
                // petsize_str=[ary1 componentsJoinedByString:@","];
                
            }
            [walking_tbl beginUpdates];
            [walking_tbl reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [walking_tbl endUpdates];
        }
        //       [walking_tbl reloadData];
        //
        //        walking_tbl.contentSize = CGSizeMake(0, walking_tbl.contentSize.height+100);
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_search_tbl)
    {
        CELL=[tableView cellForRowAtIndexPath:indexPath];
        CELL.selection_img.image=nil;
        [CELL.catagory_lbl setTextColor:[UIColor blackColor]];
        [CELL.catagory_img sd_setImageWithURL:[NSURL URLWithString:[[main_ary objectAtIndex:indexPath.row]valueForKey:@"default_image"]]];
        
    }
    if (tableView==walking_tbl) {
        
        if (indexPath.section==1)
        {
            
        }
        else if (indexPath.section==2)
        {
            
        }
        else if (indexPath.section==4)
        {
            
        }
    }
    
    
}






- (IBAction)walking_headerview_btn:(id)sender {
    
//    _search_tbl.hidden=NO;
//    walking_view.hidden=YES;
//    search_btn.hidden=YES;
    
    UIAlertController *departureActnSht = [UIAlertController alertControllerWithTitle:@"Choose Pet Type"message:nil  preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    
    for (int j =0 ; j<main_ary.count; j++)
    {
        NSString *titleString = [ main_ary[j] valueForKey:@"name"];
        UIAlertAction *action = [UIAlertAction actionWithTitle:titleString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){

            walking_headerview_lbl.text=[main_ary[j] valueForKey:@"name"];
            
            
            
            [walking_headerview_img sd_setImageWithURL:[NSURL URLWithString:[main_ary[j] valueForKey:@"selected_image"]]];
            [self choosepettype:[ [allpetdetails_ary objectAtIndex:0] valueForKey:@"id"]];
            
            choosepettype_lbl.text=[[allpetdetails_ary objectAtIndex:0] valueForKey:@"name"];
            
            [self choosepettype:[[allpetdetails_ary objectAtIndex:0] valueForKey:@"name"]];
        }];
        
        [departureActnSht addAction:action];
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [departureActnSht addAction:cancelAction];
    [self presentViewController:departureActnSht animated:YES completion:nil];
    
    
    
}
- (IBAction)choose_pettype_btn:(id)sender {
    
    UIAlertController *departureActnSht = [UIAlertController alertControllerWithTitle:@"Choose Pet Type"message:nil  preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    
    for (int j =0 ; j< allpetdetails_ary.count; j++)
    {
        NSString *titleString = [ allpetdetails_ary[j] valueForKey:@"name"];
        UIAlertAction *action = [UIAlertAction actionWithTitle:titleString style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            NSLog(@"%@", allpetdetails_ary[j]);
            choosepettype_lbl.text=[allpetdetails_ary[j] valueForKey:@"name"];
            
            [self choosepettype:[ [allpetdetails_ary objectAtIndex:j] valueForKey:@"id"]];
            
            
        }];
        
        [departureActnSht addAction:action];
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        
        // [self dismissViewControllerAnimated:departureActnSht completion:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [departureActnSht addAction:cancelAction];
    [self presentViewController:departureActnSht animated:YES completion:nil];
    
}
-(void)choosepettype:(NSString *)petid
{
    
    
    [ary1 removeAllObjects];
    [ary2 removeAllObjects];
    [ary3 removeAllObjects];
    [walking_tbl reloadData];
    _walking_headerview2.hidden=NO;
    _walking_headerview3.hidden=NO;
    _walking_headerview4.hidden=NO;
    _walking_headerview5.hidden=NO;
    
    
    
    NSString *url_str=[NSString stringWithFormat:@"%@pet_type_info?pet_type_id=%@",App_Domain_Url,petid];
    //NSString *postdata=[NSString stringWithFormat:@"pet_type_id=%@",petid];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
    
    [request setURL:[NSURL URLWithString:url_str]];
    //
    //    [request setHTTPMethod:@"GET"];
    //
    //
    //     [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //
    //
    //    [request setHTTPBody:[postdata dataUsingEncoding:NSUTF8StringEncoding]];
    
    [url_obj GlobalDict:request Globalstr:@"array" lodaer:YES Withblock:^(id result, NSError *error) {
        
        
        NSLog(@"%@",result);
        NSString *response=[NSString stringWithFormat:@"%@",[result valueForKey:@"response"]];
        
        if ([response isEqualToString:@"1"])
        {
            
            petage_ary=[[result valueForKey:@"petAgeDet"]mutableCopy];
            petsize_ary=[[result valueForKey:@"petSizeDet"]mutableCopy];
            otheroption_ary=[[result valueForKey:@"exp_medical_opt"]mutableCopy];
            minprice_str=[result valueForKey:@"min_price_default"];
            maxprice_str=[result valueForKey:@"max_price_default"];
            
            slider.maximumValue=[maxprice_str integerValue];
            slider.minimumValue=[minprice_str integerValue];
            
            slider.upperValue=[maxprice_str integerValue];
            slider.lowerValue=[minprice_str integerValue];
            
            rangeslider_lbl_down.text=[NSString stringWithFormat:@"¥ %ld",(long)[minprice_str integerValue]];
            rangeslider_lbl_up.text=[NSString stringWithFormat:@"¥ %ld",(long)[maxprice_str integerValue]];
            slider.continuous=YES;
            
            [slider addTarget:self action:@selector(slideValueChanged:)
             forControlEvents:UIControlEventValueChanged];
            //NSLog(@"%@",str);
            [walking_tbl reloadData];
            
            //        walking_tbl.contentSize = CGSizeMake(0, walking_tbl.contentSize.height+100);
        }
        else
        {
            
        }
        
    }];
    
}


-(void)urlData:(NSString *)start_date end:(NSString *)end_date page:(NSString *)startfrom
{
    NSString *urlstr=[NSString stringWithFormat:@"%@search_setter",App_Domain_Url];
        NSString *postdata=[NSString stringWithFormat:@"user_id=%@&langid=%@&per_page=10&search_location=%@&start_date=%@&ne_lng=%@&ne_lat=%@&sw_lng=%@&sw_lat=%@&srch_lon=%@&srch_lat=%@&pet_homes=&high_price=&low_price=&pet_size=%@&pet_age=%@&pet_type=%@&serviceCat=%@&end_date=%@&Start_form=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"userid"],[[NSUserDefaults standardUserDefaults]valueForKey:@"lan_code"],_location_btn.titleLabel.text,start_date,
                            [latlong_data valueForKey:@"ne_lng"],
                            [latlong_data valueForKey:@"ne_lat"],
                            [latlong_data valueForKey:@"sw_lng"],
                            [latlong_data valueForKey:@"sw_lat"],
                            [latlong_data valueForKey:@"long"],
                            [latlong_data valueForKey:@"lat"],
                            petsize_str,petage_str,pettype_str,servicat_str,end_date,startfrom];
    
    
    
   
    
  //  NSString *postdata=[NSString stringWithFormat:@"user_id=30&langid=en&per_page=10&search_location=japan&start_date=%@&ne_lng=&ne_lat=&sw_lng=&sw_lat=&srch_lon=&srch_lat=&pet_homes=&high_price=&low_price=&pet_size=&pet_age=&pet_type=&serviceCat=&end_date=%@&Start_form=%@",start_date,end_date,startfrom];
    
    postdata=[postdata stringByRemovingPercentEncoding];
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
    
    [request setURL:[NSURL URLWithString:urlstr]];
    
    [request setHTTPMethod:@"POST"];
    
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody:[postdata dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    [url_obj GlobalDict:request Globalstr:@"array" lodaer:YES Withblock:^(id result, NSError *error) {
        
        
        NSLog(@"%@",result);
        
        NSString *response=[NSString stringWithFormat:@"%@",[result valueForKey:@"response"]];
        
        if ([response isEqualToString:@"1"]) {
            
            
            
            UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            PetListing_ViewController *obj_petlisting =[sb instantiateViewControllerWithIdentifier:@"petlisting"];
            
          
            
            [[NSUserDefaults standardUserDefaults]setObject:[result valueForKey:@"results"] forKey:@"result"];
            [[NSUserDefaults standardUserDefaults]setObject:_location_btn.titleLabel.text forKey:@"search_location"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            [self.navigationController pushViewController:obj_petlisting animated:YES];
        }
        
        else
        {
            [YXSpritesLoadingView errorInfo:@"No Results Found"];
        }
        
        
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [leftMenu_obj removeFromSuperview];
    
    leftMenu_obj=nil;
    
    leftMenu_obj = [[leftmenu alloc]init];
    
    [leftMenu_obj Leftmenu:self sideMenu:leftMenu_obj];
    
    
    
    
    
    if ([_filter isEqualToString:@"filter"])
    {
        _first_view.hidden=YES;
              walking_view.hidden=NO;
        search_btn.hidden=NO;
        _search_tbl.hidden =YES;
        
        filterBtn.hidden = NO;
    }
    
    else
    {
        _first_view.hidden =YES;
        _search_tbl.hidden =NO;
        search_btn.hidden=YES;
        walking_view.hidden=YES;
        
        filterBtn.hidden = YES;

    }
    
    
    if (main_ary.count==0)
    {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@parent_service",App_Domain_Url]];
        
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
        
        [request setURL:url];
        
        [url_obj GlobalDict:request Globalstr:@"array" lodaer:YES Withblock:^(id result, NSError *error) {
            
            main_ary=[result valueForKey:@"serviceCatList"];
            allpetdetails_ary=[result valueForKey:@"allPetDetails"];
            [_search_tbl reloadData];
            //[walking_tbl reloadData];
            
        }];
    }
    
    
   
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)mennAction:(UIButton *)sender {
    
    
    
    
    [leftMenu_obj lefMenuopen:sender];
    
    
    
    
}

- (IBAction)calender_open:(UIButton *)sender {
    
    
    
    if (obj==nil)
    {
        obj = [CalenderController new];
        obj= [self.storyboard instantiateViewControllerWithIdentifier:@"calender"];
        obj.view.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        
        obj.date_button = self.date_btn;
        
    }
    
    obj.clr_calender=_clr_calender;
    obj.view.hidden = NO;
    [self.view addSubview:obj.view];
    [UIView animateWithDuration:.4 animations:^{
        
        
        obj.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        
        
        
        
    }completion:^(BOOL finished) {
        
        //        [UIView animateWithDuration:.4 animations:^{
        //
        //            obj.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        //        }];
      if([[[NSUserDefaults standardUserDefaults]valueForKey:@"tutorial"] intValue]==0)
      {
        [obj showtutorial];
          
      }
        
        
    }];
    
    
    
    
    
    //    CalenderController *obj = [self.storyboard instantiateViewControllerWithIdentifier:@"calender"];
    ////
    //    obj.date_button = self.date_btn;
    ////
    ////     [self presentViewController:obj animated:YES completion:nil];
    //
    //
    //    CATransition* transition = [CATransition animation];
    //    transition.duration = 0.3;
    //    transition.type = kCATransitionPush;
    //    transition.subtype = kCATransitionFromTop;
    //
    //    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    //    [self.navigationController pushViewController:obj animated:NO];
    
}

- (IBAction)search_tap:(id)sender {
    
    // NSLog(@"%@",[[[[obj_new.geometry_ary valueForKey:@"viewport"] valueForKey:@"northeast"] objectAtIndex:0]valueForKey:@"lat" ]);
    // if ([_date_btn.titleLabel.text isEqualToString:@"Choose date"]) {
    
    
    if (![_location_btn.titleLabel.text  isEqualToString:@"Search postal code or address"] && selectRow == TRUE)
    {
        [[NSUserDefaults standardUserDefaults]setObject:_location_btn.titleLabel.text forKey:@"search_location"];
        
        [self urlData:@"" end:@"" page:@"0"];
    }
    else if (selectRow == false)
    {
         [YXSpritesLoadingView errorInfo:@"Please Select options"];
    }
    
    else
    {
        [YXSpritesLoadingView errorInfo:@"Please Select Location"];
    }
   
    
    //}
    
    
    
    
    
    
    
}



- (IBAction)clear_calender_tap:(id)sender {
    
    [_date_btn setTitle: @"Choose date" forState:UIControlStateNormal];
    _clr_calender.hidden=YES;
    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"selectdate"];
    
    
    
}
- (IBAction)GPS:(UIButton *)sender {
    
    
   // gpsTap =YES;
    
    [locationManager startUpdatingLocation];
    
   
    
    
    
    
}
- (IBAction)filter:(UIButton *)sender {
    
    
    
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PetListing_ViewController *obj_petlisting =[sb instantiateViewControllerWithIdentifier:@"petlisting"];
    [self.navigationController pushViewController:obj_petlisting animated:NO];
    
}
@end
