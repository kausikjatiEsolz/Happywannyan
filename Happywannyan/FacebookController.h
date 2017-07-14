//
//  FacebookController.h
//  Swish Marketing
//
//  Created by Rahul Singha Roy on 03/05/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
 

@interface FacebookController : UIViewController
{
     UIViewController  *_controller;
}


-(void)facebook_login :(UIViewController *)controller completionHandler:(void(^)(NSDictionary *userProfileInformation))completionHanlder failureHandler:(void(^)(NSDictionary *errorDetail))failureHandler;

@end
