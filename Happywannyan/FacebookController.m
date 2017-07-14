//
//  FacebookController.m
//  Swish Marketing
//
//  Created by Rahul Singha Roy on 03/05/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import "FacebookController.h"

@interface FacebookController ()

@property (nonatomic, strong) void(^completionHandler)(id);
@property (nonatomic, strong) void(^failureHandler)(NSDictionary *);


@end

@implementation FacebookController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)facebook_login :(UIViewController *)controller completionHandler:(void(^)(NSDictionary *userProfileInformation))completionHanlder failureHandler:(void(^)(NSDictionary *errorDetail))failureHandler
{
    
    _controller = controller;
    [controller addChildViewController:self];
    self.view.frame = controller.view.frame;
    [controller.view addSubview:self.view];
    [self didMoveToParentViewController:controller];
    _completionHandler = completionHanlder;
    _failureHandler    = failureHandler;
    
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logInWithReadPermissions:@[@"public_profile", @"email"  ,/*@"read_custom_friendlists" ,*/  @"user_friends"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        
        if (error)
        {
            NSLog(@"Process error");
            
             [self handleAuth:nil withProfileInfo:nil];
            
            
        }
        
        else {
            if ([FBSDKAccessToken currentAccessToken])
            {
                NSLog(@"Token is available : %@",[[FBSDKAccessToken currentAccessToken]tokenString]);
                //NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
                //[parameters setValue:@"id,name,email,first_name,last_name,picture.type(large)" forKey:@"fields"];
                [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"first_name, last_name, picture.type(large), email, name, id, gender , birthday , friendlists , age_range, friends"}]
                 startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                     if (!error) {
                         
                        
                         
                         
                         [self handleAuth:[[FBSDKAccessToken currentAccessToken]tokenString] withProfileInfo:(NSDictionary *)result];
                         
                        
                         
                     }
                     else
                     {
                         NSLog(@"error-->%@",error.localizedDescription);
                           [self handleAuth:nil withProfileInfo:nil];
                     }
                 }];
            }
            
        }
        
    }];
    

}

- (void) handleAuth: (NSString*)authToken withProfileInfo:(NSDictionary *)dictionary
{
    
    NSLog(@"successfully logged in with Tocken == %@",authToken);
          
        
        if (dictionary) {
            
            _completionHandler(dictionary);
            
            
        } else
            
        {
            
            _failureHandler(dictionary);
            
            
            
        }
        
     
    
    
    
    [self dismis];
    
}

-(void)dismis
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *vc = [_controller.childViewControllers lastObject];
        [vc willMoveToParentViewController:nil];
        [vc.view removeFromSuperview];
        [vc removeFromParentViewController];
    });
}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self dismis];

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
