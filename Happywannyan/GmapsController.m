//
//  GmapsController.m
//  Happywannyan
//
//  Created by Rahul Singha Roy on 19/05/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import "GmapsController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface GmapsController ()

@end

@implementation GmapsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  /*
    _gmaps.delegate = self;
    
    CLLocationCoordinate2D  northEast = [_gmaps.projection coordinateForPoint:CGPointMake(_gmaps.frame.size.width, 0)];
    CLLocationCoordinate2D  southWest = [_gmaps.projection coordinateForPoint:CGPointMake(0, _gmaps.frame.size.height)];
    
    GMSCoordinateBounds *viewport = [[GMSCoordinateBounds alloc] initWithCoordinate:northEast
                                                                         coordinate:southWest];
    
    
    GMSPlacePickerConfig *config = [[GMSPlacePickerConfig alloc] initWithViewport:viewport];
    
    
   GMSPlacePicker * _placePicker = [[GMSPlacePicker alloc] initWithConfig:config];
    
    
    
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
*/
    
        self.priceRangeSlider.maximumValue = 20000;
        self.priceRangeSlider.minimumValue = 1;
        self.priceRangeSlider.upperValue = 20000;
        self.priceRangeSlider.lowerValue = 1;
        //slider.curvatiousness = 1;
        self.priceRangeSlider.continuous=YES;
    //self.priceRangeSlider.backgroundColor = [UIColor redColor];
        [self.priceRangeSlider addTarget:self
                                  action:@selector(slideValueChanged:)
                        forControlEvents:UIControlEventValueChanged];
    
    
}

- (void)slideValueChanged:(id)control
{
    
        NSLog(@"Low--->%@",[NSString stringWithFormat:@"%d",(int)self.priceRangeSlider.lowerValue]);
        NSLog(@"Uper--->%@",[NSString stringWithFormat:@"%d",(int)self.priceRangeSlider.upperValue]);
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

@end
