//
//  StartridenavigateViewController.m
//  GetUsHere For Rider
//
//  Created by bharat on 20/06/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "StartridenavigateViewController.h"
#import "SidebarViewController.h"
#import "GetUsHere.pch"
#import "DejalActivityView.h"
#import "ChatVController.h"
#import "GPSViewController.h"
#import "GPSPathlocationViewController.h"
#import "UpcomingRidesViewController.h"
#import "UIImageView+WebCache.h"
#import "SplachscreenViewController.h"
#import "Reachability.h"

@interface StartridenavigateViewController ()

@end

@implementation StartridenavigateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    strpic=[[NSUserDefaults standardUserDefaults]objectForKey:@"pic"];
//    strdes=[[NSUserDefaults standardUserDefaults]objectForKey:@"des"];
    
    self.navigationItem.title=@"Rider Location";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"itemType"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    _callbutton.hidden=YES;
    _chatbutt.hidden=YES;
    
    
    
    arrdriverinfo=[[NSUserDefaults standardUserDefaults]objectForKey:@"driverinfo"];
    _txtname.text=[arrdriverinfo valueForKey:@"name"];
    
    tripinfo=[[NSMutableArray alloc]init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"tripinfo"];
    
    tripinfo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    Driverlocationdetails=[[NSMutableArray alloc]init];
    
    _detailview.backgroundColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    
    _NavigateButton.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    _pickuplab.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"pic"];
    _deslab.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"des"];
   
    
    strtripid=[[NSUserDefaults standardUserDefaults]objectForKey:@"tripid"];
    
    NSString *strurl=[arrdriverinfo valueForKey:@"image"];
    
    _estimatedtime.text=[tripinfo valueForKey:@"total_time"];
    _distancelab.text=[tripinfo valueForKey:@"total_distance"];
    _estimateView.backgroundColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    _distanceView.backgroundColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    
    TPFloatRatingView *ratingview=(TPFloatRatingView *)[self.view viewWithTag:2];
    
    ratingview.backgroundColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    
    NSString *str1=[NSString stringWithFormat:@"%@",[arrdriverinfo valueForKey:@"avg_rating"]];
    float value = [str1 floatValue];
    
    ratingview.emptySelectedImage = [UIImage imageNamed:@"StarEmpty"];
    ratingview.fullSelectedImage = [UIImage imageNamed:@"StarFull"];
    ratingview.contentMode = UIViewContentModeScaleAspectFill;
    ratingview.editable = NO;
    ratingview.halfRatings = YES;
    ratingview.floatRatings = YES;
    ratingview.rating=value;
    
    _driverprofileimage.layer.cornerRadius = _driverprofileimage.frame.size.height /2;
    _driverprofileimage.layer.masksToBounds = YES;
    _driverprofileimage.layer.borderWidth = 0;
    
    if (![strurl isEqualToString:@""])
    {
        [_driverprofileimage sd_setImageWithURL:[NSURL URLWithString:strurl]
                               placeholderImage:[UIImage imageNamed:@"profilepic.png"]];
    }
    
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"b" style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(barButtonBackPressed:)];
    [backButton setImage:[UIImage imageNamed:@"Untitled-1-2.png"]];
    
    self.navigationItem.leftBarButtonItem = backButton;
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
    

}

-(void)barButtonBackPressed:(id)sender
{
    //    SidebarViewController *side=[self.storyboard instantiateViewControllerWithIdentifier:@"SidebarViewController"];
    //    [self.navigationController pushViewController:side animated:YES];
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {
        
    self.view.userInteractionEnabled=NO;
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
    
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
    
}

-(void)parseJSONResp:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
 //   NSLog(@"***** Upcoming details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    // NSLog(@"%@",DataArray);
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        NSMutableArray *arrdetails=[[NSMutableArray alloc]init];
        arrdetails=nil;
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrdetails];
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"detailsofall"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSMutableArray *arrpages=[[NSMutableArray alloc]init];
        arrpages=[responseJSON valueForKey:@"data"];
        
        [[NSUserDefaults standardUserDefaults]setObject:arrpages forKey:@"detailsofall2"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        UpcomingRidesViewController *butt=[self.storyboard instantiateViewControllerWithIdentifier:@"UpcomingRidesViewController"];
        [self.navigationController pushViewController:butt animated:YES];
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
        
        UpcomingRidesViewController *butt=[self.storyboard instantiateViewControllerWithIdentifier:@"UpcomingRidesViewController"];
        [self.navigationController pushViewController:butt animated:YES];
    }
}


- (IBAction)callbuttonClicked:(id)sender
{
    // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:8143547797"]];
    NSString *phone_number = [[[arrdriverinfo valueForKey:@"mobile_no"] componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", phone_number]]];
}

-(void)viewDidDisappear:(BOOL)animated
{
    self.title = @"";
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"Rider Location";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,logincheck]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    [profile appendString:[NSString stringWithFormat:@"&device_id=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"devicetoken"]]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONRdevicecheck:data];
                               }
                           }];
    
    
    
}


-(void)parseJSONRdevicecheck:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
  //  NSLog(@"***** login check details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        //        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        //
        //        [alert show];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Login"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        SplachscreenViewController *edit = [self.storyboard instantiateViewControllerWithIdentifier:@"SplachscreenViewController"];
        UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
        [navController setViewControllers: @[edit] animated: NO ];
        [self.revealViewController setFrontViewController:navController animated:YES];
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        
        
    }
}


- (IBAction)NavigateButtonClicked:(id)sender
{
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {
        
        
    NSString *googleMapUrlString = [NSString stringWithFormat:@"comgooglemaps://?.saddr=%@&daddr=%@&directionsmode=driving",_pickuplab.text, _deslab.text];
    
    NSString *trimmedString = [googleMapUrlString stringByReplacingOccurrencesOfString:@" " withString:@""];
        
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]])
    {
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:trimmedString]];
    }
    else
    {
//        [self showMessage:@"Please install Google Maps - Navigation & Transport app from iTunes store and then press." withTitle:@"Navigation"];
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"Please install Google Maps - Navigation & Transport app from iTunes store before Navigation" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Install", nil];
        [alert show];
    }
        
//    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getBookingInfo]]];
//    
//    request.HTTPMethod = @"POST";
//    
//    NSMutableString* profile = [NSMutableString string];
//    
//    
//    
//    [profile appendString:[NSString stringWithFormat:@"trip_id=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"tripid"]]];
//    
//    [profile appendString:[NSString stringWithFormat:@"&user_type=%@", @"rider"]];
//    
//    
//    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
//    
//    [NSURLConnection sendAsynchronousRequest:request
//                                       queue:[NSOperationQueue mainQueue]
//                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//                               if (error) {
//                                   // Handle error
//                                   //[self handleError:error];
//                               } else {
//                                   [self parseJSONRespon1:data];
//                                   
//                               }
//                           }];
    }
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == [alertView firstOtherButtonIndex])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://itunes.apple.com/in/app/google-maps-navigation-transport/id585027354?mt=8"]];
    }
}

-(void)parseJSONRespon1:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
    NSLog(@"***** Driver Details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        
        Driverlocationdetails=[[responseJSON valueForKey:@"data"] valueForKey:@"trip"];
        
        [[NSUserDefaults standardUserDefaults]setObject:Driverlocationdetails forKey:@"driverlocdetails"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        GPSPathlocationViewController *gps=[self.storyboard instantiateViewControllerWithIdentifier:@"GPSPathlocationViewController"];
        [self.navigationController pushViewController:gps animated:YES];
    }
}



- (IBAction)ChatButtonClicked:(id)sender
{
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {
        
    ChatVController *chat=[self.storyboard instantiateViewControllerWithIdentifier:@"ChatVController"];
    [self.navigationController pushViewController:chat animated:YES];
    }
}

#pragma mark -- checkNetworkStatus
-(void)checkNetworkStatus{
    Reachability* internetAvailable = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [internetAvailable currentReachabilityStatus];
    switch (internetStatus)
    {
        case NotReachable:{
            NSLog(@"The internet is down.");
            _isInternetConnectionAvailable = NO;
            break;
        }
        case ReachableViaWiFi:{
            _isInternetConnectionAvailable = YES;
            NSLog(@"The internet is working via WIFI.");
            break;
        }
        case ReachableViaWWAN:{
            _isInternetConnectionAvailable = YES;
            NSLog(@"The internet is working via WWAN.");
            break;
        }
    }
}
#pragma mark -- UIAlertView Method
-(void)showMessage:(NSString*)message withTitle:(NSString *)title{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
    });
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
