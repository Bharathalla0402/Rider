//
//  AppDelegate.m
//  GetUsHere For Rider
//
//  Created by bharat on 12/02/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <GoogleMaps/GoogleMaps.h>
@import GoogleMaps;
#import <GooglePlus/GooglePlus.h>
#import <JCNotificationBannerPresenter/JCNotificationCenter.h>
#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>
#import "ViewController.h"
#import "SidebarViewController.h"
#import <Stripe/Stripe.h>
#import "SWRevealViewController.h"
#import "GetUsHere.pch"
#import "DriverDetailsViewController.h"
#import "RiderMainPageViewController.h"
#import "ArrivepicknavigateViewController.h"
#import "StartridenavigateViewController.h"
#import "UpcomingRidesViewController.h"
#import "RatingViewController.h"
#import "CancelledViewController.h"
#import "SplachscreenViewController.h"
#import "PayPalMobile.h"


//Stripe_Test API's
#define STRIPE_TEST_PUBLIC_KEY @"pk_test_PWcuHKUy4CTiYeHtvmG1po6h"
#define kStripeSecretKey @"sk_test_g9FDnJi8VW6B9891DgIlhiI3"

//Stripe_Live API's
#define STRIPE_LIVE_PUBLIC_KEY @"pk_live_wOl3eZScNyLCeOuzX4iBZssC"
#define kStripe_Live_SecretKey @"sk_live_468mRxca7WpHrqWFhpvqkL7v"

#define PayPal_TEST_ClienKey @"AUFa3m-z0k6MKo1y7XqwTKLRKAu8U-daqnX0rLPwlaUIPqYnO3sjLLeaBOpJJH4EmbRPbbPVBZyL7wzt"
#define PayPal_LIVE_ClienKey @"Ae_mnK_jhfhghkjhkjhkjjhkjhkjkd1QKPg-ir6pAq26Mb787CP"
#define PayPal_LIVE_SecretKey @"Esfdfffdefgg46CT0VcHvZw9uoDIIQFtor6fd1QKPg-ir6pAq26Mb787CP"


//@import TwitterKit;

@interface AppDelegate ()
{
    UINavigationController *navLoginViewController;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    
    
    NSDictionary *userInfo = [launchOptions valueForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if (userInfo)
    {
        NSDictionary *userInfo = [launchOptions valueForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
        
        if (apsInfo)
        {
            NSDictionary* aps = [userInfo objectForKey:@"aps"];
            NSString* alert2 = [aps objectForKey:@"code"];
            NSString *playSoundOnAlert = [NSString stringWithFormat:@"%@", [[userInfo objectForKey:@"aps"] objectForKey:@"sound"]];
            NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath],playSoundOnAlert]];
            NSError *error;
            AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
            audioPlayer.numberOfLoops = 0;
            [audioPlayer play];
            
            
            if ([alert2 isEqualToString:@"accepted"])
            {
                NSDictionary* aps = [userInfo objectForKey:@"aps"];
                NSString *strChangetoJSON=[aps objectForKey:@"data"];
                NSData *data = [strChangetoJSON dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:kNilOptions
                                                                               error:nil];
                
                NSLog(@"Response Decode:%@",jsonResponse);
                
                NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
                NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:jsonResponse];
                [currentDefaults setObject:data2 forKey:@"drivedat"];
                
                [[NSUserDefaults standardUserDefaults]setObject:@"accepted" forKey:@"itemType"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                
                NSMutableArray *arr=[[NSMutableArray alloc]init];
                
                NSUserDefaults *currentDefaults2 = [NSUserDefaults standardUserDefaults];
                NSData *data3 = [currentDefaults2 objectForKey:@"drivedat"];
                arr = [NSKeyedUnarchiver unarchiveObjectWithData:data3];
                
                NSString *str12=[NSString stringWithFormat:@"%@",[arr valueForKey:@"trip_id"]];
                
                [[NSUserDefaults standardUserDefaults]setObject:str12 forKey:@"tripid"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,gettrip]]];
                
                request.HTTPMethod = @"POST";
                
                NSMutableString* profile = [NSMutableString string];
                
                [profile appendString:[NSString stringWithFormat:@"trip_id=%@",str12]];
                [profile appendString:[NSString stringWithFormat:@"&user_type=%@",@"rider"]];
                
                request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
                
                [NSURLConnection sendAsynchronousRequest:request
                                                   queue:[NSOperationQueue mainQueue]
                                       completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                           if (error) {
                                               // Handle error
                                               //[self handleError:error];
                                           } else {
                                               [self parseJSONRespon6:data];
                                               
                                           }
                                       }];
                
            }
            
            else if([alert2 isEqualToString:@"canceled"])
            {
                NSDictionary* aps = [userInfo objectForKey:@"aps"];
                NSString *strChangetoJSON=[aps objectForKey:@"data"];
                NSData *data = [strChangetoJSON dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:kNilOptions
                                                                               error:nil];
                
                NSLog(@"Response Decode:%@",jsonResponse);
                
                
                
                
                NSMutableArray *arr=[[NSMutableArray alloc]init];
                
                NSUserDefaults *currentDefaults2 = [NSUserDefaults standardUserDefaults];
                NSData *data3 = [currentDefaults2 objectForKey:@"drivedat"];
                arr = [NSKeyedUnarchiver unarchiveObjectWithData:data3];
                
                NSString *str12=[NSString stringWithFormat:@"%@",[arr valueForKey:@"trip_id"]];
                
                [[NSUserDefaults standardUserDefaults]setObject:str12 forKey:@"tripid"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getTrips]]];
                
                request.HTTPMethod = @"POST";
                
                NSMutableString* profile = [NSMutableString string];
                
                [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
                [profile appendString:[NSString stringWithFormat:@"&user_type=%@",@"rider"]];
                [profile appendString:[NSString stringWithFormat:@"&trip_type=%@",@"canceled"]];
                
                request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
                
                [NSURLConnection sendAsynchronousRequest:request
                                                   queue:[NSOperationQueue mainQueue]
                                       completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                           if (error) {
                                               // Handle error
                                               //[self handleError:error];
                                           } else {
                                               [self parseJSONR:data];
                                           }
                                       }];
                
            }
            
            else if ([alert2 isEqualToString:@"arrived"])
            {
                NSDictionary* aps = [userInfo objectForKey:@"aps"];
                NSString *strChangetoJSON=[aps objectForKey:@"data"];
                NSData *data = [strChangetoJSON dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:kNilOptions
                                                                               error:nil];
                
                NSLog(@"Response Decode:%@",jsonResponse);
                
                NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
                NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:jsonResponse];
                [currentDefaults setObject:data2 forKey:@"drivedat1"];
                
                
                
                [[NSUserDefaults standardUserDefaults]setObject:@"arrived" forKey:@"itemType"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                
                NSMutableArray *arr=[[NSMutableArray alloc]init];
                
                NSUserDefaults *currentDefaults2 = [NSUserDefaults standardUserDefaults];
                NSData *data22 = [currentDefaults2 objectForKey:@"drivedat1"];
                arr = [NSKeyedUnarchiver unarchiveObjectWithData:data22];
                
                NSString *str12=[NSString stringWithFormat:@"%@",[arr valueForKey:@"trip_id"]];
                
                [[NSUserDefaults standardUserDefaults]setObject:str12 forKey:@"tripid"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,gettrip]]];
                
                request.HTTPMethod = @"POST";
                
                NSMutableString* profile = [NSMutableString string];
                
                [profile appendString:[NSString stringWithFormat:@"trip_id=%@",str12]];
                [profile appendString:[NSString stringWithFormat:@"&user_type=%@",@"rider"]];
                
                request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
                
                [NSURLConnection sendAsynchronousRequest:request
                                                   queue:[NSOperationQueue mainQueue]
                                       completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                           if (error) {
                                               // Handle error
                                               //[self handleError:error];
                                           } else {
                                               [self parseJSONResponarrive:data];
                                               
                                           }
                                       }];
                
            }
            else if ([alert2 isEqualToString:@"started"])
            {
                NSDictionary* aps = [userInfo objectForKey:@"aps"];
                NSString *strChangetoJSON=[aps objectForKey:@"data"];
                NSData *data = [strChangetoJSON dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:kNilOptions
                                                                               error:nil];
                
                NSLog(@"Response Decode:%@",jsonResponse);
                
                NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
                NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:jsonResponse];
                [currentDefaults setObject:data2 forKey:@"drivedat2"];
                
                
                
                [[NSUserDefaults standardUserDefaults]setObject:@"started" forKey:@"itemType"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                
                NSMutableArray *arr=[[NSMutableArray alloc]init];
                
                NSUserDefaults *currentDefaults2 = [NSUserDefaults standardUserDefaults];
                NSData *data22 = [currentDefaults2 objectForKey:@"drivedat2"];
                arr = [NSKeyedUnarchiver unarchiveObjectWithData:data22];
                
                NSString *str12=[NSString stringWithFormat:@"%@",[arr valueForKey:@"trip_id"]];
                
                [[NSUserDefaults standardUserDefaults]setObject:str12 forKey:@"tripid"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,gettrip]]];
                
                request.HTTPMethod = @"POST";
                
                NSMutableString* profile = [NSMutableString string];
                
                [profile appendString:[NSString stringWithFormat:@"trip_id=%@",str12]];
                [profile appendString:[NSString stringWithFormat:@"&user_type=%@",@"rider"]];
                
                request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
                
                [NSURLConnection sendAsynchronousRequest:request
                                                   queue:[NSOperationQueue mainQueue]
                                       completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                           if (error) {
                                               // Handle error
                                               //[self handleError:error];
                                           } else {
                                               [self parseJSONResponstart:data];
                                               
                                           }
                                       }];
            }
            else if ([alert2 isEqualToString:@"stopped"])
            {
                NSDictionary* aps = [userInfo objectForKey:@"aps"];
                NSString *strChangetoJSON=[aps objectForKey:@"data"];
                NSData *data = [strChangetoJSON dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:kNilOptions
                                                                               error:nil];
                
                NSLog(@"Response Decode:%@",jsonResponse);
                
                NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
                NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:jsonResponse];
                [currentDefaults setObject:data2 forKey:@"drivedat3"];
                
                
                
                [[NSUserDefaults standardUserDefaults]setObject:@"stopped" forKey:@"itemType"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                
                NSMutableArray *arr=[[NSMutableArray alloc]init];
                
                NSUserDefaults *currentDefaults2 = [NSUserDefaults standardUserDefaults];
                NSData *data22 = [currentDefaults2 objectForKey:@"drivedat3"];
                arr = [NSKeyedUnarchiver unarchiveObjectWithData:data22];
                
                NSString *str12=[NSString stringWithFormat:@"%@",[arr valueForKey:@"trip_id"]];
                
                [[NSUserDefaults standardUserDefaults]setObject:str12 forKey:@"tripid"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getTrips]]];
                
                request.HTTPMethod = @"POST";
                
                NSMutableString* profile = [NSMutableString string];
                
                [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
                [profile appendString:[NSString stringWithFormat:@"&user_type=%@",@"rider"]];
                [profile appendString:[NSString stringWithFormat:@"&trip_type=%@",@"upcoming"]];
                
                request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
                
                [NSURLConnection sendAsynchronousRequest:request
                                                   queue:[NSOperationQueue mainQueue]
                                       completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                           if (error) {
                                               // Handle error
                                               //[self handleError:error];
                                           } else {
                                               [self parseJSONResp:data];
                                           }
                                       }];
                
            }
            else if ([alert2 isEqualToString:@"completed"])
            {
                NSDictionary* aps = [userInfo objectForKey:@"aps"];
                NSString *strChangetoJSON=[aps objectForKey:@"data"];
                NSData *data = [strChangetoJSON dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:kNilOptions
                                                                               error:nil];
                
                NSLog(@"Response Decode:%@",jsonResponse);
                
                NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
                NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:jsonResponse];
                [currentDefaults setObject:data2 forKey:@"drivedat4"];
                
                
                
                [[NSUserDefaults standardUserDefaults]setObject:@"completed" forKey:@"itemType"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                NSMutableArray *arr=[[NSMutableArray alloc]init];
                
                NSUserDefaults *currentDefaults2 = [NSUserDefaults standardUserDefaults];
                NSData *data22 = [currentDefaults2 objectForKey:@"drivedat4"];
                arr = [NSKeyedUnarchiver unarchiveObjectWithData:data22];
                
                NSString *str12=[NSString stringWithFormat:@"%@",[arr valueForKey:@"trip_id"]];
                NSString *str13=[NSString stringWithFormat:@"%@",[arr valueForKey:@"driver_id"]];
                
                [[NSUserDefaults standardUserDefaults]setObject:str12 forKey:@"tripid"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                [[NSUserDefaults standardUserDefaults]setObject:str13 forKey:@"driveridrate"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                
                UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
                // this any item in list you want navigate to
                RatingViewController *home = (RatingViewController *) [storyboard instantiateViewControllerWithIdentifier:@"RatingViewController"];
                
                RiderMainPageViewController *slidemenu = (RiderMainPageViewController *)[storyboard instantiateViewControllerWithIdentifier:@"RiderMainPageViewController"];
                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:home];
                UINavigationController *smVC = [[UINavigationController alloc]initWithRootViewController:slidemenu];
                // define rear and frontviewcontroller
                SWRevealViewController *revealController = [[SWRevealViewController alloc]initWithRearViewController:smVC frontViewController:nav];
                self.window.rootViewController=revealController;
                
            }
        }
    }
    else
    {
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"Login"] isEqualToString:@"YES"])
        {
            UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            // this any item in list you want navigate to
            SidebarViewController *home = (SidebarViewController *) [storyboard instantiateViewControllerWithIdentifier:@"SidebarViewController"];
        
            RiderMainPageViewController *slidemenu = (RiderMainPageViewController *)[storyboard instantiateViewControllerWithIdentifier:@"RiderMainPageViewController"];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:home];
            UINavigationController *smVC = [[UINavigationController alloc]initWithRootViewController:slidemenu];
            // define rear and frontviewcontroller
            SWRevealViewController *revealController = [[SWRevealViewController alloc]initWithRearViewController:smVC frontViewController:nav];
            self.window.rootViewController=revealController;
        }
    }
    
    [application setStatusBarHidden:NO];
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [GMSServices provideAPIKey:@"AIzaSyAIyff4QNwE1x_0KZ7xVZhMQUMNX_VGEd4"];
    
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    
    
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                    UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                             categories:nil];
    [application registerUserNotificationSettings:settings];
    [application registerForRemoteNotifications];
    
   [Fabric with:@[[Twitter class]]];
    
    [self startLocationUpdates];
    
//    if (STRIPE_TEST_PUBLIC_KEY != nil) {
//        [Stripe setDefaultPublishableKey:STRIPE_LIVE_PUBLIC_KEY];
//    }
    
  //  [PayPalMobile initializeWithClientIdsForEnvironments:@{
  //                                                         PayPalEnvironmentSandbox : PayPal_TEST_ClienKey}];
    
     [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction : @"AZWL1TRofLyc3KQZBu6u035Nv2b27bHRriRNYG8NAwbNy-dmb1yJpMF-ga4g3Xt8Pi7uW6HCjW-4ril3", PayPalEnvironmentSandbox : @"AaewP5F9JetdUoEEgLVivUEJKkYmGVt5KaZsPOt5tXhFr2vgu6t9Tf_DLP4fYqg3jyfpzWEL6B5pThFe"}];
   
    [Stripe setDefaultPublishableKey:STRIPE_TEST_PUBLIC_KEY];
    
    return YES;
    
}

- (void)startLocationUpdates
{
    if (locationManager == nil)
    {
        locationManager = [[CLLocationManager alloc] init];
    }
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.activityType = CLActivityTypeFitness;
    
    // Movement threshold for new events.
    locationManager.distanceFilter = 10; // meters
    
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
}



- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
        [GPPURLHandler handleURL:url sourceApplication:sourceApplication annotation:annotation];
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}


-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    devicetokenString = [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]stringByReplacingOccurrencesOfString: @">" withString: @""] stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    NSLog(@"Device Token :%@",devicetokenString);
    
    NSLog(@"Did Register for Remote Notifications with Device Token DATA (%@) \n STRING token (%@)", deviceToken,devicetokenString);
    
    [[NSUserDefaults standardUserDefaults]setValue:devicetokenString forKey:@"devicetoken"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    //If Same token received again dont take any action else save in NSUserdefaults or system and send to server to register against this device to send push notification on the token specified here.
}
 
-(void)application:(UIApplication *)application    didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Did Fail to Register for Remote Notifications");
    NSLog(@"%s:%@, %@",__PRETTY_FUNCTION__,error, error.localizedDescription);
}

//-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
//{
//    NSLog(@"Did Receive for Remote Notifications with UserInfo:%@", userInfo);
//}

- (void) application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)notification
{
    NSLog(@"remote notification: %@",[notification description]);
    
        if (notification) {
            NSLog(@"%@",notification);
    
            if ([notification objectForKey:@"aps"]) {
                if([[notification objectForKey:@"aps"] objectForKey:@"badgecount"]) {
                    [UIApplication sharedApplication].applicationIconBadgeNumber = [[[notification objectForKey:@"aps"] objectForKey: @"badge"] intValue];
                }
            }
    }
  //  NSString* title = @"HoppInRide";
    NSDictionary* aps = [notification objectForKey:@"aps"];
  //  NSString* alert = [aps objectForKey:@"alert"];
    NSString *alert2=[aps objectForKey:@"code"];
    NSString *playSoundOnAlert = [NSString stringWithFormat:@"%@", [[notification objectForKey:@"aps"] objectForKey:@"sound"]];
    
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath],playSoundOnAlert]];
    
    NSError *error;
    
   AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    audioPlayer.numberOfLoops = 0;
    [audioPlayer play];
    
    if ([alert2 isEqualToString:@"accepted"])
    {
        NSDictionary* aps = [notification objectForKey:@"aps"];
        NSString *strChangetoJSON=[aps objectForKey:@"data"];
        NSData *data = [strChangetoJSON dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:nil];
        
        NSLog(@"Response Decode:%@",jsonResponse);
        
        NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
        NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:jsonResponse];
        [currentDefaults setObject:data2 forKey:@"drivedat"];
    
        [[NSUserDefaults standardUserDefaults]setObject:@"accepted" forKey:@"itemType"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        NSMutableArray *arr=[[NSMutableArray alloc]init];
        
        NSUserDefaults *currentDefaults2 = [NSUserDefaults standardUserDefaults];
        NSData *data3 = [currentDefaults2 objectForKey:@"drivedat"];
        arr = [NSKeyedUnarchiver unarchiveObjectWithData:data3];
        
        NSString *str12=[NSString stringWithFormat:@"%@",[arr valueForKey:@"trip_id"]];
        
        [[NSUserDefaults standardUserDefaults]setObject:str12 forKey:@"tripid"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,gettrip]]];
        
        request.HTTPMethod = @"POST";
        
        NSMutableString* profile = [NSMutableString string];
        
        [profile appendString:[NSString stringWithFormat:@"trip_id=%@",str12]];
        [profile appendString:[NSString stringWithFormat:@"&user_type=%@",@"rider"]];
        
        request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   if (error) {
                                       // Handle error
                                       //[self handleError:error];
                                   } else {
                                       [self parseJSONRespon6:data];
                                       
                                   }
                               }];

    }
    
   else if([alert2 isEqualToString:@"canceled"])
    {
        NSDictionary* aps = [notification objectForKey:@"aps"];
        NSString *strChangetoJSON=[aps objectForKey:@"data"];
        NSData *data = [strChangetoJSON dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:nil];
        
        NSLog(@"Response Decode:%@",jsonResponse);
        
        
        
        
        NSMutableArray *arr=[[NSMutableArray alloc]init];
        
        NSUserDefaults *currentDefaults2 = [NSUserDefaults standardUserDefaults];
        NSData *data3 = [currentDefaults2 objectForKey:@"drivedat"];
        arr = [NSKeyedUnarchiver unarchiveObjectWithData:data3];
        
        NSString *str12=[NSString stringWithFormat:@"%@",[arr valueForKey:@"trip_id"]];
        
        [[NSUserDefaults standardUserDefaults]setObject:str12 forKey:@"tripid"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getTrips]]];
        
        request.HTTPMethod = @"POST";
        
        NSMutableString* profile = [NSMutableString string];
        
        [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
        [profile appendString:[NSString stringWithFormat:@"&user_type=%@",@"rider"]];
        [profile appendString:[NSString stringWithFormat:@"&trip_type=%@",@"canceled"]];
        
        request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   if (error) {
                                       // Handle error
                                       //[self handleError:error];
                                   } else {
                                       [self parseJSONR:data];
                                   }
                               }];
        
    }

    else if ([alert2 isEqualToString:@"arrived"])
    {
        NSDictionary* aps = [notification objectForKey:@"aps"];
        NSString *strChangetoJSON=[aps objectForKey:@"data"];
        NSData *data = [strChangetoJSON dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:nil];
        
        NSLog(@"Response Decode:%@",jsonResponse);
        
        NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
        NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:jsonResponse];
        [currentDefaults setObject:data2 forKey:@"drivedat1"];
        
        
        
        [[NSUserDefaults standardUserDefaults]setObject:@"arrived" forKey:@"itemType"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        NSMutableArray *arr=[[NSMutableArray alloc]init];
        
        NSUserDefaults *currentDefaults2 = [NSUserDefaults standardUserDefaults];
        NSData *data22 = [currentDefaults2 objectForKey:@"drivedat1"];
        arr = [NSKeyedUnarchiver unarchiveObjectWithData:data22];
        
        NSString *str12=[NSString stringWithFormat:@"%@",[arr valueForKey:@"trip_id"]];
        
        [[NSUserDefaults standardUserDefaults]setObject:str12 forKey:@"tripid"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,gettrip]]];
        
        request.HTTPMethod = @"POST";
        
        NSMutableString* profile = [NSMutableString string];
        
        [profile appendString:[NSString stringWithFormat:@"trip_id=%@",str12]];
        [profile appendString:[NSString stringWithFormat:@"&user_type=%@",@"rider"]];
        
        request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   if (error) {
                                       // Handle error
                                       //[self handleError:error];
                                   } else {
                                       [self parseJSONResponarrive:data];
                                       
                                   }
                               }];

    }
    else if ([alert2 isEqualToString:@"started"])
    {
        NSDictionary* aps = [notification objectForKey:@"aps"];
        NSString *strChangetoJSON=[aps objectForKey:@"data"];
        NSData *data = [strChangetoJSON dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:nil];
        
        NSLog(@"Response Decode:%@",jsonResponse);
        
        NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
        NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:jsonResponse];
        [currentDefaults setObject:data2 forKey:@"drivedat2"];
        
        
        
        [[NSUserDefaults standardUserDefaults]setObject:@"started" forKey:@"itemType"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        NSMutableArray *arr=[[NSMutableArray alloc]init];
        
        NSUserDefaults *currentDefaults2 = [NSUserDefaults standardUserDefaults];
        NSData *data22 = [currentDefaults2 objectForKey:@"drivedat2"];
        arr = [NSKeyedUnarchiver unarchiveObjectWithData:data22];
        
        NSString *str12=[NSString stringWithFormat:@"%@",[arr valueForKey:@"trip_id"]];
        
        [[NSUserDefaults standardUserDefaults]setObject:str12 forKey:@"tripid"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,gettrip]]];
        
        request.HTTPMethod = @"POST";
        
        NSMutableString* profile = [NSMutableString string];
        
        [profile appendString:[NSString stringWithFormat:@"trip_id=%@",str12]];
        [profile appendString:[NSString stringWithFormat:@"&user_type=%@",@"rider"]];
        
        request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   if (error) {
                                       // Handle error
                                       //[self handleError:error];
                                   } else {
                                       [self parseJSONResponstart:data];
                                       
                                   }
                               }];
    }
    else if ([alert2 isEqualToString:@"stopped"])
    {
        NSDictionary* aps = [notification objectForKey:@"aps"];
        NSString *strChangetoJSON=[aps objectForKey:@"data"];
        NSData *data = [strChangetoJSON dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:nil];
        
        NSLog(@"Response Decode:%@",jsonResponse);
        
        NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
        NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:jsonResponse];
        [currentDefaults setObject:data2 forKey:@"drivedat3"];
        
        
        
        [[NSUserDefaults standardUserDefaults]setObject:@"stopped" forKey:@"itemType"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        NSMutableArray *arr=[[NSMutableArray alloc]init];
        
        NSUserDefaults *currentDefaults2 = [NSUserDefaults standardUserDefaults];
        NSData *data22 = [currentDefaults2 objectForKey:@"drivedat3"];
        arr = [NSKeyedUnarchiver unarchiveObjectWithData:data22];
        
        NSString *str12=[NSString stringWithFormat:@"%@",[arr valueForKey:@"trip_id"]];
        
        [[NSUserDefaults standardUserDefaults]setObject:str12 forKey:@"tripid"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getTrips]]];
        
        request.HTTPMethod = @"POST";
        
        NSMutableString* profile = [NSMutableString string];
        
        [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
        [profile appendString:[NSString stringWithFormat:@"&user_type=%@",@"rider"]];
        [profile appendString:[NSString stringWithFormat:@"&trip_type=%@",@"upcoming"]];
        
        request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   if (error) {
                                       // Handle error
                                       //[self handleError:error];
                                   } else {
                                       [self parseJSONResp:data];
                                   }
                               }];

    }
    else if ([alert2 isEqualToString:@"completed"])
    {
        NSDictionary* aps = [notification objectForKey:@"aps"];
        NSString *strChangetoJSON=[aps objectForKey:@"data"];
        NSData *data = [strChangetoJSON dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:kNilOptions
                                                                       error:nil];
        
        NSLog(@"Response Decode:%@",jsonResponse);
        
        NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
        NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:jsonResponse];
        [currentDefaults setObject:data2 forKey:@"drivedat4"];
        
        
        
        [[NSUserDefaults standardUserDefaults]setObject:@"completed" forKey:@"itemType"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSMutableArray *arr=[[NSMutableArray alloc]init];
        
        NSUserDefaults *currentDefaults2 = [NSUserDefaults standardUserDefaults];
        NSData *data22 = [currentDefaults2 objectForKey:@"drivedat4"];
        arr = [NSKeyedUnarchiver unarchiveObjectWithData:data22];
        
        NSString *str12=[NSString stringWithFormat:@"%@",[arr valueForKey:@"trip_id"]];
        NSString *str13=[NSString stringWithFormat:@"%@",[arr valueForKey:@"driver_id"]];
        
        [[NSUserDefaults standardUserDefaults]setObject:str12 forKey:@"tripid"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:str13 forKey:@"driveridrate"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        // this any item in list you want navigate to
        RatingViewController *home = (RatingViewController *) [storyboard instantiateViewControllerWithIdentifier:@"RatingViewController"];
        
        RiderMainPageViewController *slidemenu = (RiderMainPageViewController *)[storyboard instantiateViewControllerWithIdentifier:@"RiderMainPageViewController"];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:home];
        UINavigationController *smVC = [[UINavigationController alloc]initWithRootViewController:slidemenu];
        // define rear and frontviewcontroller
        SWRevealViewController *revealController = [[SWRevealViewController alloc]initWithRearViewController:smVC frontViewController:nav];
        self.window.rootViewController=revealController;
        
        
    }
    
//    [JCNotificationCenter
//     enqueueNotificationWithTitle:title
//     message:alert
//     tapHandler:^{
//         NSLog(@"Received tap on notification banner!");
//     }];
    
    NSLog(@"Did Receive for Remote Notifications with UserInfo:%@", notification);
}


-(void)parseJSONR:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
  //  NSLog(@"*****Near Driver details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    

    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
        
       
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        NSMutableArray *arrdetails=[[NSMutableArray alloc] init];
        
        arrdetails=[[[responseJSON valueForKey:@"data"]valueForKey:@"tripDetail"] valueForKey:@"trip"];
        
        [[NSUserDefaults standardUserDefaults]setObject:arrdetails forKey:@"detailsofall"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSMutableArray *arrpages=[[NSMutableArray alloc]init];
        arrpages=[responseJSON valueForKey:@"data"];
        
        [[NSUserDefaults standardUserDefaults]setObject:arrpages forKey:@"detailsofall2"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        // this any item in list you want navigate to
        CancelledViewController *home = (CancelledViewController *) [storyboard instantiateViewControllerWithIdentifier:@"CancelledViewController"];
        
        RiderMainPageViewController *slidemenu = (RiderMainPageViewController *)[storyboard instantiateViewControllerWithIdentifier:@"RiderMainPageViewController"];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:home];
        UINavigationController *smVC = [[UINavigationController alloc]initWithRootViewController:slidemenu];
        // define rear and frontviewcontroller
        SWRevealViewController *revealController = [[SWRevealViewController alloc]initWithRearViewController:smVC frontViewController:nav];
        self.window.rootViewController=revealController;
    }
}



-(void)parseJSONRespon6:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
  //  NSLog(@"***** Driver Response ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        NSMutableArray *arrdriverinfo=[[NSMutableArray alloc]init];
        NSMutableArray *arrtripinfo=[[NSMutableArray alloc]init];
        
        arrdriverinfo=[[responseJSON valueForKey:@"data"]valueForKey:@"user"];
        arrtripinfo=[[responseJSON valueForKey:@"data"]valueForKey:@"trip"];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrtripinfo];
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"tripinfo"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSString *str1=[NSString stringWithFormat:@"%@",[arrtripinfo valueForKey:@"src_addr"]];
        [[NSUserDefaults standardUserDefaults]setObject:str1 forKey:@"pic"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSString *str2=[NSString stringWithFormat:@"%@",[arrtripinfo valueForKey:@"dest_addr"]];
        [[NSUserDefaults standardUserDefaults]setObject:str2 forKey:@"des"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        [[NSUserDefaults standardUserDefaults]setObject:arrdriverinfo forKey:@"driverinfo"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSString *strbooktime=[NSString stringWithFormat:@"%@  %@",[arrtripinfo valueForKey:@"booking_date"],[arrtripinfo valueForKey:@"booking_time"]];
        NSString *status=[NSString stringWithFormat:@"%@",[arrtripinfo valueForKey:@"status"]];
        
        [[NSUserDefaults standardUserDefaults]setObject:strbooktime forKey:@"tripinfotime"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:status forKey:@"tripinfostatus"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        // this any item in list you want navigate to
        DriverDetailsViewController *home = (DriverDetailsViewController *) [storyboard instantiateViewControllerWithIdentifier:@"DriverDetailsViewController"];
        
        RiderMainPageViewController *slidemenu = (RiderMainPageViewController *)[storyboard instantiateViewControllerWithIdentifier:@"RiderMainPageViewController"];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:home];
        UINavigationController *smVC = [[UINavigationController alloc]initWithRootViewController:slidemenu];
        // define rear and frontviewcontroller
        SWRevealViewController *revealController = [[SWRevealViewController alloc]initWithRearViewController:smVC frontViewController:nav];
        self.window.rootViewController=revealController;
    }
}

-(void)parseJSONResponarrive:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
 //   NSLog(@"***** Driver Response ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        NSMutableArray *arrdriverinfo=[[NSMutableArray alloc]init];
        NSMutableArray *arrtripinfo=[[NSMutableArray alloc]init];
        
        arrdriverinfo=[[responseJSON valueForKey:@"data"]valueForKey:@"user"];
        arrtripinfo=[[responseJSON valueForKey:@"data"]valueForKey:@"trip"];
        
        NSString *str1=[NSString stringWithFormat:@"%@",[arrtripinfo valueForKey:@"src_addr"]];
        [[NSUserDefaults standardUserDefaults]setObject:str1 forKey:@"pic"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSString *str2=[NSString stringWithFormat:@"%@",[arrtripinfo valueForKey:@"dest_addr"]];
        [[NSUserDefaults standardUserDefaults]setObject:str2 forKey:@"des"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        [[NSUserDefaults standardUserDefaults]setObject:arrdriverinfo forKey:@"driverinfo"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrtripinfo];
        
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"tripinfo"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        // this any item in list you want navigate to
        ArrivepicknavigateViewController *home = (ArrivepicknavigateViewController *) [storyboard instantiateViewControllerWithIdentifier:@"ArrivepicknavigateViewController"];
        
        RiderMainPageViewController *slidemenu = (RiderMainPageViewController *)[storyboard instantiateViewControllerWithIdentifier:@"RiderMainPageViewController"];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:home];
        UINavigationController *smVC = [[UINavigationController alloc]initWithRootViewController:slidemenu];
        // define rear and frontviewcontroller
        SWRevealViewController *revealController = [[SWRevealViewController alloc]initWithRearViewController:smVC frontViewController:nav];
        self.window.rootViewController=revealController;
    }
}

-(void)parseJSONResponstart:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
  //  NSLog(@"***** Driver Response ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        NSMutableArray *arrdriverinfo=[[NSMutableArray alloc]init];
        NSMutableArray *arrtripinfo=[[NSMutableArray alloc]init];
        
        arrdriverinfo=[[responseJSON valueForKey:@"data"]valueForKey:@"user"];
        arrtripinfo=[[responseJSON valueForKey:@"data"]valueForKey:@"trip"];
        
        NSString *str1=[NSString stringWithFormat:@"%@",[arrtripinfo valueForKey:@"src_addr"]];
        [[NSUserDefaults standardUserDefaults]setObject:str1 forKey:@"pic"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSString *str2=[NSString stringWithFormat:@"%@",[arrtripinfo valueForKey:@"dest_addr"]];
        [[NSUserDefaults standardUserDefaults]setObject:str2 forKey:@"des"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        [[NSUserDefaults standardUserDefaults]setObject:arrdriverinfo forKey:@"driverinfo"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrtripinfo];
        
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"tripinfo"];
        [[NSUserDefaults standardUserDefaults]synchronize];

        
//        [[NSUserDefaults standardUserDefaults]setObject:arrtripinfo forKey:@"tripinfo"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
        
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        // this any item in list you want navigate to
        StartridenavigateViewController *home = (StartridenavigateViewController *) [storyboard instantiateViewControllerWithIdentifier:@"StartridenavigateViewController"];
        
        RiderMainPageViewController *slidemenu = (RiderMainPageViewController *)[storyboard instantiateViewControllerWithIdentifier:@"RiderMainPageViewController"];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:home];
        UINavigationController *smVC = [[UINavigationController alloc]initWithRootViewController:slidemenu];
        // define rear and frontviewcontroller
        SWRevealViewController *revealController = [[SWRevealViewController alloc]initWithRearViewController:smVC frontViewController:nav];
        self.window.rootViewController=revealController;
    }
}

-(void)parseJSONResp:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
  //  NSLog(@"*****Near Driver details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
        
        NSMutableArray *arrdetails=[[NSMutableArray alloc]init];
        
        arrdetails=nil;
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrdetails];
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"detailsofall"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSMutableArray *arrpages=[[NSMutableArray alloc]init];
        arrpages=[responseJSON valueForKey:@"data"];
        
        [[NSUserDefaults standardUserDefaults]setObject:arrpages forKey:@"detailsofall2"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        // this any item in list you want navigate to
        UpcomingRidesViewController *home = (UpcomingRidesViewController *) [storyboard instantiateViewControllerWithIdentifier:@"UpcomingRidesViewController"];
        
        RiderMainPageViewController *slidemenu = (RiderMainPageViewController *)[storyboard instantiateViewControllerWithIdentifier:@"RiderMainPageViewController"];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:home];
        UINavigationController *smVC = [[UINavigationController alloc]initWithRootViewController:slidemenu];
        // define rear and frontviewcontroller
        SWRevealViewController *revealController = [[SWRevealViewController alloc]initWithRearViewController:smVC frontViewController:nav];
        self.window.rootViewController=revealController;
        
    }
    
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
         NSMutableArray *arrdetails=[[NSMutableArray alloc]init];
        arrdetails=[[[responseJSON valueForKey:@"data"] valueForKey:@"tripDetail"]valueForKey:@"trip"];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrdetails];
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"detailsofall"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSMutableArray *arrpages=[[NSMutableArray alloc]init];
        arrpages=[responseJSON valueForKey:@"data"];
        
        [[NSUserDefaults standardUserDefaults]setObject:arrpages forKey:@"detailsofall2"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        UIStoryboard *storyboard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        // this any item in list you want navigate to
        UpcomingRidesViewController *home = (UpcomingRidesViewController *) [storyboard instantiateViewControllerWithIdentifier:@"UpcomingRidesViewController"];
        
        RiderMainPageViewController *slidemenu = (RiderMainPageViewController *)[storyboard instantiateViewControllerWithIdentifier:@"RiderMainPageViewController"];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:home];
        UINavigationController *smVC = [[UINavigationController alloc]initWithRootViewController:slidemenu];
        // define rear and frontviewcontroller
        SWRevealViewController *revealController = [[SWRevealViewController alloc]initWithRearViewController:smVC frontViewController:nav];
        self.window.rootViewController=revealController;
    }
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBSDKAppEvents activateApp];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}



- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
