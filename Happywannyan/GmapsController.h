//
//  GmapsController.h
//  Happywannyan
//
//  Created by Rahul Singha Roy on 19/05/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "NMRangeSlider.h"
@interface GmapsController : UIViewController<GMSMapViewDelegate>
@property (weak, nonatomic) IBOutlet GMSMapView *gmaps;
@property (strong, nonatomic) IBOutlet NMRangeSlider *priceRangeSlider;

@end
