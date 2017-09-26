//
//  BookcancelViewController.m
//  GetUsHere For Rider
//
//  Created by bharat on 08/04/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "BookcancelViewController.h"
#import "DejalActivityView.h"
#import "SidebarViewController.h"
#import "GetUsHere.pch"
#import "UpcomingRidesViewController.h"
#import "SplachscreenViewController.h"
#import "Reachability.h"

@interface BookcancelViewController ()

@end

@implementation BookcancelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"Cancel Ride";
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
   // arrtripinfod=[[NSUserDefaults standardUserDefaults]objectForKey:@"tripinfo"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"tripinfo"];
    
    arrtripinfod = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    NSString *strid=[NSString stringWithFormat:@"%@",[arrtripinfod valueForKey:@"trip_id"]];
    [[NSUserDefaults standardUserDefaults]setObject:strid forKey:@"tripid"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    _doneClick.backgroundColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    _backClick.backgroundColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];

    
    
    [_btn1 setImage:[UIImage imageNamed:@"radio button unselected_20-20.png"] forState:UIControlStateNormal];
    [_btn2 setImage:[UIImage imageNamed:@"radio button unselected_20-20.png"] forState:UIControlStateNormal];
    [_btn3 setImage:[UIImage imageNamed:@"radio button unselected_20-20.png"] forState:UIControlStateNormal];
    [_btn4 setImage:[UIImage imageNamed:@"radio button unselected_20-20.png"] forState:UIControlStateNormal];
}
- (IBAction)btnclicked:(UIButton*)sender
{
    if (sender.tag==1)
    {
        [_btn1 setImage:[UIImage imageNamed:@"radio button selected_20-20.png"] forState:UIControlStateNormal];
        [_btn2 setImage:[UIImage imageNamed:@"radio button unselected_20-20.png"] forState:UIControlStateNormal];
        [_btn3 setImage:[UIImage imageNamed:@"radio button unselected_20-20.png"] forState:UIControlStateNormal];
        [_btn4 setImage:[UIImage imageNamed:@"radio button unselected_20-20.png"] forState:UIControlStateNormal];
        
        str=@"Driver is Late";
    }
    else if (sender.tag==2)
    {
        [_btn1 setImage:[UIImage imageNamed:@"radio button unselected_20-20.png"] forState:UIControlStateNormal];
        [_btn2 setImage:[UIImage imageNamed:@"radio button selected_20-20.png"] forState:UIControlStateNormal];
        [_btn3 setImage:[UIImage imageNamed:@"radio button unselected_20-20.png"] forState:UIControlStateNormal];
        [_btn4 setImage:[UIImage imageNamed:@"radio button unselected_20-20.png"] forState:UIControlStateNormal];
        
         str=@"Booked another car";
       
    }
    else if (sender.tag==3)
    {
        [_btn1 setImage:[UIImage imageNamed:@"radio button unselected_20-20.png"] forState:UIControlStateNormal];
        [_btn2 setImage:[UIImage imageNamed:@"radio button unselected_20-20.png"] forState:UIControlStateNormal];
        [_btn3 setImage:[UIImage imageNamed:@"radio button selected_20-20.png"] forState:UIControlStateNormal];
        [_btn4 setImage:[UIImage imageNamed:@"radio button unselected_20-20.png"] forState:UIControlStateNormal];
        
        str=@"Changed my mind";
    }
    else if (sender.tag==4)
    {
        [_btn1 setImage:[UIImage imageNamed:@"radio button unselected_20-20.png"] forState:UIControlStateNormal];
        [_btn2 setImage:[UIImage imageNamed:@"radio button unselected_20-20.png"] forState:UIControlStateNormal];
        [_btn3 setImage:[UIImage imageNamed:@"radio button unselected_20-20.png"] forState:UIControlStateNormal];
        [_btn4 setImage:[UIImage imageNamed:@"radio button selected_20-20.png"] forState:UIControlStateNormal];
        
        str=@"Driver denied duty";
    }
    
}
- (IBAction)DoneClicked:(id)sender
{
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }
   else if (str.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"Please select proper reason to cancel the ride" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else
    {
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
        [self next];
    }
    
}


-(void)next
{
     NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,cancelTrip]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    [profile appendString:[NSString stringWithFormat:@"&trip_id=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"tripid" ]]];
    [profile appendString:[NSString stringWithFormat:@"&user_type=%@",@"rider"]];
    [profile appendString:[NSString stringWithFormat:@"&canceled_message=%@",str]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONResponse:data];
                               }
                           }];
}

-(void)parseJSONResponse:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
 //   NSLog(@"*****Cancel details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    // NSLog(@"%@",DataArray);
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"message" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"message" message:@"You has been successfully cancelled the Ride" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
        
        SidebarViewController *rides=[self.storyboard instantiateViewControllerWithIdentifier:@"SidebarViewController"];
        [self.navigationController pushViewController:rides animated:YES];
        
    }
}


- (IBAction)CancelClicked:(id)sender
{
    SidebarViewController *rides=[self.storyboard instantiateViewControllerWithIdentifier:@"SidebarViewController"];
    [self.navigationController pushViewController:rides animated:YES];
}


-(void)viewDidDisappear:(BOOL)animated{
    
    self.title = @"";
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"Cancel Ride";
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
