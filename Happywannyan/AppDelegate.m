//
//  AppDelegate.m
//  Happywannyan
//
//  Created by Rahul Singha Roy on 18/05/17.
//  Copyright © 2017 Kausik Jati. All rights reserved.
//

#import "AppDelegate.h"
#import <GooglePlaces/GooglePlaces.h>
@import GoogleMaps;



@interface AppDelegate ()
{
    NSDictionary *current_language;
    
    
    
    
    
    
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [GMSServices provideAPIKey:@"AIzaSyDFnO8OXU705MwN-vklI95bXcaVBDxRuYU"];
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    [GMSPlacesClient provideAPIKey:@"AIzaSyBqVR7WgLBmbL-4haqh0jRiyEtY5povRG8"];
    
    NSDictionary *japan =   //initial
    
    @{@"login_lbl":@"あなたの近くの完璧なペットの席",
      @"skip":@"スキップ",
      @"login_img":@"Login-1"
      ,@"signup_img":@"Sign Up-1"
      
      //login
      
      ,@"email":@"Eメール"
      ,@"password":@"パスワード"
      ,@"login":@"ログイン"
      ,@"forgotpassword":@"パスワードをお忘れですか"
      ,@"login_with_fb":@"あなたはログインできます"
      ,@"donot_have_account":@"アカウントを持っていないのですか？"
      ,@"signup_btn":@"今すぐ申し込む"
      
      //signup
      
      ,@"youremail":@"あなたのメールアドレス"
      ,@"yourpassword":@"あなたのパスワード"
      ,@"signup":@"サインアップ"
      ,@"signupterm":@"アカウントの作成またはFacebookでの登録をクリックすると、利用規約に同意することが確認されます"
      ,@"signupwithfb":@"あなたはでサインアップすることができます"
      ,@"loginpage":@"既にメンバー"
      ,@"login_now":@"ここでログイン"
      
      //calender
      
      ,@"calender":@"カレンダー"
      ,@"date_lbl":@"開始日と終了日を選択"
      ,@"cancel":@"キャンセル"
      ,@"ok":@"[OK]"
      
      //booking
      
      ,@"booking":@"予約"
      ,@"nodata_lbl":@"何もデータが見つかりませんでした"
      ,@"upcoming":@"     アップアップ      |"
      ,@"current":@"   現在      |"
      ,@"pending":@"   保留中      |"
      ,@"past":@"   過去       "
      
      //messages
      
      ,@"messages":@"メッセージ"
      ,@"allmessages":@"    すべてのメッセージ   |"
      ,@"unread":@" 未読   |"
      ,@"unresponded":@" 未応答   |"
      ,@"reservation":@" 予約   |"
      ,@"meetgreet":@" ご挨拶   |"
      ,@"general":@" 一般的なお問い合わせ    "
      
      //profile
      
      ,@"favorite_sitters":@"お気に入りの食卓"
      ,@"past_sitters":@"過去の食卓"
      ,@"profile":@"プロフィール"
      
      
      ,@"search":@"サーチ"
      ,@"message":@"メッセージ"
      ,@"booking":@"予約"
      ,@"yourpet":@"あなたのペット"
      ,@"payment":@"支払い"
      ,@"profile":@"プロフィール"
      ,@"help":@"助けて"
      ,@"logout":@"ログアウト"
      ,@"loginnow":@"ここでログイン"};
    
    
    NSDictionary *english =    //initial
    
    @{@"login_lbl":@"THE PERFECT PET SITTER NEAR YOUR"
      ,@"skip":@"SKIP"
      ,@"login_img":@"Login"
      ,@"signup_img":@"Sign Up"
      
      //login
      
      ,@"email":@"Email"
      ,@"password":@"Password"
      ,@"login":@"LOG IN"
      ,@"forgotpassword":@"Forgot Password"
      ,@"login_with_fb":@"You can Log In with"
      ,@"donot_have_account":@"Don't have an account?"
      ,@"signup_btn":@"Sign Up now"
      
      //signup
      
      ,@"youremail":@"Your Email"
      ,@"yourpassword":@"Your Password"
      ,@"signup":@"Sign Up"
      ,@"signupterm":@"By clicking Create Account or Sign Up with Facebook, you confirm that you accept the Terms of Service"
      ,@"signupwithfb":@"You can Sign Up with"
      ,@"loginpage":@"Already a member"
      ,@"login_now":@"Log In now"
      
      //calender
      
      ,@"calender":@"Calender"
      ,@"date_lbl":@"Select start and end date"
      ,@"cancel":@"Cancel"
      ,@"ok":@"OK"
      
      //booking
      
      ,@"booking":@"Bookings"
      ,@"nodata_lbl":@"No Data Found"
      ,@"upcoming":@"     Up Coming      |"
      ,@"current":@"   Current      |"
      ,@"pending":@"   Pending      |"
      ,@"past":@"   Past       "
      
      //messages
      
      ,@"messages":@"Messages"
      ,@"allmessages":@"    All Messages   |"
      ,@"unread":@" Unread   |"
      ,@"unresponded":@" Un Responded   |"
      ,@"reservation":@" Reservation   |"
      ,@"meetgreet":@" Meet Greet   |"
      ,@"general":@" General Enquiry    "
      
      //profile
      
      ,@"favorite_sitters":@"Favorite Sitters"
      ,@"past_sitters":@"Past Sitters"
      ,@"profile":@"Profile"
      
      ,@"search":@"Search"
      ,@"message":@"Messages"
      ,@"booking":@"Bookings"
      ,@"yourpet":@"Your Pet"
      ,@"payment":@"Payment"
      ,@"profile":@"Profile"
      ,@"help":@"Help"
      ,@"logout":@"Log Out"
      ,@"loginnow":@"Log in now"};
    
    
    //    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"lan_code"] isEqualToString:@"en"])
    //    {
    [[NSUserDefaults standardUserDefaults]setValue:@"en" forKey:@"lan_code"];
    
    current_language = english;
    //    }
    //    else
    //    {
    //         [[NSUserDefaults standardUserDefaults]setValue:@"ja" forKey:@"lan_code"];
    //
    //        current_language = japan;
    //    }
    //
    
    [[NSUserDefaults standardUserDefaults]setObject:current_language forKey:@"language"];
    
    
    
    
    return YES;
}


- (BOOL)application:(UIApplication *)application  openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication  annotation:(id)annotation {
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    [FBSDKAppEvents activateApp];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Happywannyan"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
