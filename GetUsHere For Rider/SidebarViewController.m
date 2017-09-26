//
//  SidebarViewController.m
//  Jaguar Enterprises
//
//  Created by bharat on 01/02/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "SidebarViewController.h"
#import "SWRevealViewController.h"
#import "DejalActivityView.h"
#import "SettingsViewController.h"
#import "FarecarselectViewController.h"
#import "FareEstimateViewController.h"
#import "AboutUsViewController.h"
#import "UpcomingRidesViewController.h"
#import "CancelledViewController.h"
#import "RidereditViewController.h"
#import "GetUsHere.pch"
#import "FinalpayconformViewController.h"
#import "RatingViewController.h"
#import "Reachability.h"
#import "SplachscreenViewController.h"
#import "ViewController.h"
#import "SelectCarViewController.h"



#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

@interface SidebarViewController ()

@end



@implementation SidebarViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
   //   self.navigationController.title=[UIColor whiteColor];
    
   // self.title = @"Dashboard";
    
    self.title=@"Dashboard";
    self.view.userInteractionEnabled=YES;
    
    [[[self navigationController] navigationBar] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back.jpg"]];
    
    arrcount=[[NSMutableArray alloc]init];
    
     //  [_sidebarButton setImage:[UIImage imageNamed:@"menu_40.png"]];
    
    // [_sidebarButton setBackgroundImage:[UIImage imageNamed:@"green.png"] forState:UIControlStateNormal];
    
    //[_sidebarButton setTintColor:[UIColor yellowColor]];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    arrcars=[[NSMutableArray alloc]init];
    arrid=[[NSMutableArray alloc]init];
    arrdetails=[[NSMutableArray alloc]init];
    
   _pingButt.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    [_pingButt setImage:[UIImage imageNamed:@"ping-a-ride-2.png"] forState:UIControlStateNormal];
   
    
    

    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/2+6, self.view.frame.size.width/3-2, (self.view.frame.size.height/2-70)/2)];
    view1.backgroundColor= [UIColor colorWithRed:250.0/255.0f green:151.0/255.0f blue:2.0/255.0f alpha:1.0];
    [self.view addSubview:view1];
    
    UIImageView *image=[[UIImageView alloc] initWithFrame:CGRectMake(view1.frame.size.width/2-38, view1.frame.size.height/2-31, 76, 36)];
    
    if (self.view.frame.size.height==480 || self.view.frame.size.height==568)
    {
    image.image=[UIImage imageNamed:@"upcoming-1x.jpg"];
    }
    else if (self.view.frame.size.height==667)
    {
     image.image=[UIImage imageNamed:@"upcoming-1x.jpg"];
    }
    else
    {
    image.image=[UIImage imageNamed:@"upcoming-1x.jpg"];
    }
    [view1 addSubview:image];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(view1.frame.size.width/2-40, view1.frame.size.height/2+5, 80, 40)];
    lab.text=@"Upcoming Rides";
    lab.textColor=[UIColor whiteColor];
    lab.numberOfLines=2;
    lab.textAlignment = NSTextAlignmentCenter;
    [lab setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [view1 addSubview:lab];
    
    UIButton *upcomingrides=[[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/2+6, self.view.frame.size.width/3-2, (self.view.frame.size.height/2-70)/2)];
    upcomingrides.backgroundColor=[UIColor clearColor];
  //  [upcomingrides setImage:[UIImage imageNamed:@"upcoming3.jpg"] forState:UIControlStateNormal];
    [upcomingrides addTarget:self action:@selector(UpcomingRidesClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:upcomingrides];
    
    
    
    
    
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(upcomingrides.frame.size.width+3, self.view.frame.size.height/2+6, self.view.frame.size.width/3-2, (self.view.frame.size.height/2-70)/2)];
    view2.backgroundColor= [UIColor colorWithRed:104.0/255.0f green:53.0/255.0f blue:185.0/255.0f alpha:1.0];
    [self.view addSubview:view2];
    
    UIImageView *image1=[[UIImageView alloc] initWithFrame:CGRectMake(view2.frame.size.width/2-37.5, view2.frame.size.height/2-30, 75, 35)];
    image1.image=[UIImage imageNamed:@"cancelled-v1.jpg"];
    [view2 addSubview:image1];
    
    UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(view2.frame.size.width/2-40, view2.frame.size.height/2+5, 80, 40)];
    lab1.text=@"Cancelled Rides";
    lab1.textColor=[UIColor whiteColor];
    lab1.numberOfLines=2;
    lab1.textAlignment = NSTextAlignmentCenter;
    [lab1 setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [view2 addSubview:lab1];
    
    UIButton *Cancelledrides=[[UIButton alloc]initWithFrame:CGRectMake(upcomingrides.frame.size.width+3, self.view.frame.size.height/2+6, self.view.frame.size.width/3-2, (self.view.frame.size.height/2-70)/2)];
     Cancelledrides.backgroundColor=[UIColor clearColor];
   // [Cancelledrides setImage:[UIImage imageNamed:@"cancel3.jpg"] forState:UIControlStateNormal];
    [Cancelledrides addTarget:self action:@selector(CancelledRidesClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Cancelledrides];
    
    
    
    UIView *view3=[[UIView alloc]initWithFrame:CGRectMake(upcomingrides.frame.size.width+Cancelledrides.frame.size.width+6, self.view.frame.size.height/2+6, self.view.frame.size.width/3-2, (self.view.frame.size.height/2-70)/2)];
    view3.backgroundColor= [UIColor colorWithRed:3.0/255.0f green:154.0/255.0f blue:179.0/255.0f alpha:1.0];
    [self.view addSubview:view3];
    
    UIImageView *image2=[[UIImageView alloc] initWithFrame:CGRectMake(view3.frame.size.width/2-22.5, view3.frame.size.height/2-39, 45, 45)];
    image2.image=[UIImage imageNamed:@"fare-1x.jpg"];
    [view3 addSubview:image2];
    
    UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(view3.frame.size.width/2-40, view3.frame.size.height/2+5, 80, 40)];
    lab2.text=@"Fare Estimation";
    lab2.textColor=[UIColor whiteColor];
    lab2.numberOfLines=2;
    lab2.textAlignment = NSTextAlignmentCenter;
    [lab2 setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [view3 addSubview:lab2];
    
    UIButton *fareestimate=[[UIButton alloc]initWithFrame:CGRectMake(upcomingrides.frame.size.width+Cancelledrides.frame.size.width+6, self.view.frame.size.height/2+6, self.view.frame.size.width/3-2, (self.view.frame.size.height/2-70)/2)];
     fareestimate.backgroundColor=[UIColor clearColor];
  //  [fareestimate setImage:[UIImage imageNamed:@"fare3.jpg"] forState:UIControlStateNormal];
    [fareestimate addTarget:self action:@selector(FareEstimationClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fareestimate];
    
    
    
    
    UIView *view4=[[UIView alloc]initWithFrame:CGRectMake(0, upcomingrides.frame.origin.y+upcomingrides.frame.size.height+2, self.view.frame.size.width/3-2, (self.view.frame.size.height/2-70)/2)];
    view4.backgroundColor= [UIColor colorWithRed:12.0/255.0f green:183.0/255.0f blue:165.0/255.0f alpha:1.0];
    [self.view addSubview:view4];
    
    UIImageView *image3=[[UIImageView alloc] initWithFrame:CGRectMake(view4.frame.size.width/2-22.5, view4.frame.size.height/2-32, 45, 45)];
    image3.image=[UIImage imageNamed:@"profile-1x.jpg"];
    [view4 addSubview:image3];
    
    UILabel *lab3=[[UILabel alloc]initWithFrame:CGRectMake(view4.frame.size.width/2-40, view4.frame.size.height/2+5, 80, 40)];
    lab3.text=@"My Profile";
    lab3.textColor=[UIColor whiteColor];
    lab3.numberOfLines=2;
    lab3.textAlignment = NSTextAlignmentCenter;
    [lab3 setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [view4 addSubview:lab3];
    
    UIButton *myprofile=[[UIButton alloc]initWithFrame:CGRectMake(0, upcomingrides.frame.origin.y+upcomingrides.frame.size.height+2, self.view.frame.size.width/3-2, (self.view.frame.size.height/2-70)/2)];
    myprofile.backgroundColor=[UIColor clearColor];
  //  [myprofile setImage:[UIImage imageNamed:@"profile3.jpg"] forState:UIControlStateNormal];
     [myprofile addTarget:self action:@selector(profileClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myprofile];
    
    
    
    
    UIView *view5=[[UIView alloc]initWithFrame:CGRectMake(myprofile.frame.size.width+3, Cancelledrides.frame.origin.y+Cancelledrides.frame.size.height+2, self.view.frame.size.width/3-2, (self.view.frame.size.height/2-70)/2)];
    view5.backgroundColor= [UIColor colorWithRed:158.0/255.0f green:32.0/255.0f blue:177.0/255.0f alpha:1.0];
    [self.view addSubview:view5];
    
    UIImageView *image4=[[UIImageView alloc] initWithFrame:CGRectMake(view5.frame.size.width/2-22.5, view5.frame.size.height/2-32, 45, 45)];
    image4.image=[UIImage imageNamed:@"about-1x.jpg"];
    [view5 addSubview:image4];
    
    UILabel *lab4=[[UILabel alloc]initWithFrame:CGRectMake(view5.frame.size.width/2-40, view5.frame.size.height/2+5, 80, 40)];
    lab4.text=@"About Us";
    lab4.textColor=[UIColor whiteColor];
    lab4.numberOfLines=2;
    lab4.textAlignment = NSTextAlignmentCenter;
    [lab4 setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [view5 addSubview:lab4];
    
    UIButton *aboutus=[[UIButton alloc]initWithFrame:CGRectMake(myprofile.frame.size.width+3, Cancelledrides.frame.origin.y+Cancelledrides.frame.size.height+2, self.view.frame.size.width/3-2, (self.view.frame.size.height/2-70)/2)];
    aboutus.backgroundColor=[UIColor clearColor];
 //   [aboutus setImage:[UIImage imageNamed:@"about2.jpg"] forState:UIControlStateNormal];
     [aboutus addTarget:self action:@selector(AboutusClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aboutus];
    
    
    
    
    UIView *view6=[[UIView alloc]initWithFrame:CGRectMake(myprofile.frame.size.width+aboutus.frame.size.width+6, fareestimate.frame.origin.y+fareestimate.frame.size.height+2, self.view.frame.size.width/3-2, (self.view.frame.size.height/2-70)/2)];
    view6.backgroundColor= [UIColor colorWithRed:222.0/255.0f green:162.0/255.0f blue:13.0/255.0f alpha:1.0];
    [self.view addSubview:view6];
    
    UIImageView *image5=[[UIImageView alloc] initWithFrame:CGRectMake(view6.frame.size.width/2-22.5, view6.frame.size.height/2-32, 45, 45)];
    image5.image=[UIImage imageNamed:@"settings-1x.jpg"];
    [view6 addSubview:image5];
    
    UILabel *lab5=[[UILabel alloc]initWithFrame:CGRectMake(view6.frame.size.width/2-40, view6.frame.size.height/2+5, 80, 40)];
    lab5.text=@"Settings";
    lab5.textColor=[UIColor whiteColor];
    lab5.numberOfLines=2;
    lab5.textAlignment = NSTextAlignmentCenter;
    [lab5 setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [view6 addSubview:lab5];
    
    UIButton *settings=[[UIButton alloc]initWithFrame:CGRectMake(myprofile.frame.size.width+aboutus.frame.size.width+8, fareestimate.frame.origin.y+fareestimate.frame.size.height+2, self.view.frame.size.width/3-2, (self.view.frame.size.height/2-70)/2)];
    settings.backgroundColor=[UIColor clearColor];
  //  [settings setImage:[UIImage imageNamed:@"settings3.jpg"] forState:UIControlStateNormal];
     [settings addTarget:self action:@selector(SettingChanged:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settings];
    
    
    
    
    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getUserCounts]]];
//    
//    request.HTTPMethod = @"POST";
//    
//    NSMutableString* profile = [NSMutableString string];
//    
//    [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
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
//                                   [self parseJSONRespo4:data];
//                               }
//                           }];
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *strurl=[NSString stringWithFormat:@"%@%@",BaseUrl,getUserCounts];
    [request setURL:[NSURL URLWithString:strurl]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
          
            
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *error=nil;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                     [self parseJSONRespo4:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }


        });
    }] resume];

    
    // Change button color
 //   _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
     self.revealViewController.delegate = self;
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
}

- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position
{
    if(position == FrontViewPositionLeft) {
        self.view.userInteractionEnabled = YES;
    } else {
        self.view.userInteractionEnabled = NO;
    }
}

- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position
{
    if(position == FrontViewPositionLeft) {
        self.view.userInteractionEnabled = YES;
    } else {
        self.view.userInteractionEnabled = NO;
    }
}



-(void)parseJSONRespo4:(NSMutableDictionary*)responseData
{
    //  NSError *err;
    
    NSMutableDictionary *responseJSON = responseData;
    
 //   NSLog(@"*****Trip details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    arrcount=[responseJSON valueForKey:@"data"];
    
    [[NSUserDefaults standardUserDefaults]setObject:arrcount forKey:@"tripdetail"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    // NSLog(@"%@",DataArray);
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
       NSString *strtotal=[NSString stringWithFormat:@"%@",[arrcount valueForKey:@"total_trip"]];
       NSString *strcancelled=[NSString stringWithFormat:@"%@",[arrcount valueForKey:@"canceled_trip"]];
        
        [[NSUserDefaults standardUserDefaults] setObject:strtotal forKey:@"totaltrips"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults] setObject:strcancelled forKey:@"cancellrdtrips"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }
}


- (IBAction)FareEstimationClicked:(id)sender
{
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {
        self.view.userInteractionEnabled = NO;
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
        [self nex];
        
    }
}

- (IBAction)SettingChanged:(id)sender
{
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {
        self.view.userInteractionEnabled = NO;
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
        
        SettingsViewController *bookTax=[self.storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
        [self.navigationController pushViewController:bookTax animated:YES];
        
    }
}

- (IBAction)PingrideClicked:(id)sender
{
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"PAKLY"];
        
    }else
    {
        
        
        self.view.userInteractionEnabled = NO;
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
        [self nextcar];
        
    }
}

-(void)nextcar
{
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getcarTypes]]];
//    
//    request.HTTPMethod = @"POST";
//    
//    NSMutableString* profile = [NSMutableString string];
//    
//  //  [profile appendString:[NSString stringWithFormat:@"mobile_no=%@", self.txtUserName.text]];
//  //  [profile appendString:[NSString stringWithFormat:@"&password=%@", self.txtPwd.text]];
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
//                                   [self parseJSONResponse:data];
//                               }
//                           }];
    
    NSString *post = @"";
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *strurl=[NSString stringWithFormat:@"%@%@",BaseUrl,getcarTypes];
    [request setURL:[NSURL URLWithString:strurl]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *error=nil;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                    [self parseJSONResponse:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }

            
        });
    }] resume];

}

-(void)parseJSONResponse:(NSMutableDictionary*)responseData
{
    //  NSError *err;
    
    NSMutableDictionary *responseJSON = responseData;
    NSLog(@"*****Cars details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    arrcars=[[responseJSON valueForKey:@"data"]valueForKey:@"name"];
    arrid=[[responseJSON valueForKey:@"data"]valueForKey:@"id"];
    
    [[NSUserDefaults standardUserDefaults]setObject:arrcars forKey:@"cars"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:arrid forKey:@"id"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
        
        self.view.userInteractionEnabled=YES;
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        
        SelectCarViewController *sc=[self.storyboard instantiateViewControllerWithIdentifier:@"SelectCarViewController"];
        [self.navigationController pushViewController:sc animated:YES];
       // [self performSegueWithIdentifier:@"cars" sender:self];
    }
}

-(void)nex
{
    
//   NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getcarTypes]]];
//    
//    
//    request.HTTPMethod = @"POST";
//    
//    NSMutableString* profile = [NSMutableString string];
//    
//    //  [profile appendString:[NSString stringWithFormat:@"mobile_no=%@", self.txtUserName.text]];
//    //  [profile appendString:[NSString stringWithFormat:@"&password=%@", self.txtPwd.text]];
//    
//    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
//    
//    [NSURLConnection sendAsynchronousRequest:request
//                                       queue:[NSOperationQueue mainQueue]
//                           completionHandler:^(NSURLResponse *response, NSData *dat, NSError *error) {
//                               if (error) {
//                                   // Handle error
//                                   //[self handleError:error];
//                               } else {
//                                   [self parseJSONRespons:dat];
//                               }
//                           }];
    
    NSString *post = @"";
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *strurl=[NSString stringWithFormat:@"%@%@",BaseUrl,getcarTypes];
    [request setURL:[NSURL URLWithString:strurl]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *dat, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
            if (error)
            {
                
            } else
            {
                if(dat != nil) {
                    NSError *error=nil;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:dat options:0 error:&error];
                    [self parseJSONRespons:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];

    
}

-(void)parseJSONRespons:(NSMutableDictionary*)responseData
{
    //  NSError *err;
    
    NSMutableDictionary *responseJSON = responseData;
    
 //   NSLog(@"*****Cars ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    arrcars=[responseJSON valueForKey:@"data"];
   
    [[NSUserDefaults standardUserDefaults]setObject:arrcars forKey:@"cars"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
        
        self.view.userInteractionEnabled=YES;
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        FareEstimateViewController *bookTax=[self.storyboard instantiateViewControllerWithIdentifier:@"FareEstimateViewController"];
        [self.navigationController pushViewController:bookTax animated:YES];
    }
}

- (IBAction)AboutusClicked:(id)sender
{
    
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {
        self.view.userInteractionEnabled = NO;
        
        AboutUsViewController *butt=[self.storyboard instantiateViewControllerWithIdentifier:@"AboutUsViewController"];
        [self.navigationController pushViewController:butt animated:YES];
        
    }
    
}

- (IBAction)UpcomingRidesClicked:(id)sender
{
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {
        self.view.userInteractionEnabled = NO;
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
        [self n];
    }
}

- (IBAction)CancelledRidesClicked:(id)sender
{
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {
        self.view.userInteractionEnabled = NO;
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
        [self nee];
    }
}

-(void)n
{
//     NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getTrips]]];
//    
//    request.HTTPMethod = @"POST";
//    
//    NSMutableString* profile = [NSMutableString string];
//    
//    [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
//    [profile appendString:[NSString stringWithFormat:@"&user_type=%@",@"rider"]];
//    [profile appendString:[NSString stringWithFormat:@"&trip_type=%@",@"upcoming"]];
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
//                                   [self parseJSONResp:data];
//                               }
//                           }];
    
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@&user_type=%@&trip_type=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ], @"rider",@"upcoming"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *strurl=[NSString stringWithFormat:@"%@%@",BaseUrl,getTrips];
    [request setURL:[NSURL URLWithString:strurl]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
           
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *error=nil;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                      [self parseJSONResp:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }

        });
    }] resume];
}

-(void)parseJSONResp:(NSMutableDictionary*)responseData
{
    //  NSError *err;
    
    NSMutableDictionary *responseJSON = responseData;
    
  //  NSLog(@"*****Near Driver details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    // NSLog(@"%@",DataArray);
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//        
//        [alert show];
        
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

-(void)nee
{
    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getTrips]]];
//    
//    request.HTTPMethod = @"POST";
//    
//    NSMutableString* profile = [NSMutableString string];
//    
//    [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
//    [profile appendString:[NSString stringWithFormat:@"&user_type=%@",@"rider"]];
//    [profile appendString:[NSString stringWithFormat:@"&trip_type=%@",@"canceled"]];
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
//                                   [self parseJSONR:data];
//                               }
//                           }];
    
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@&user_type=%@&trip_type=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ], @"rider",@"canceled"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *strurl=[NSString stringWithFormat:@"%@%@",BaseUrl,getTrips];
    [request setURL:[NSURL URLWithString:strurl]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
           
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *error=nil;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                    [self parseJSONR:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }

        });
    }] resume];

}

-(void)parseJSONR:(NSMutableDictionary*)responseData
{
    //  NSError *err;
    
    NSMutableDictionary *responseJSON = responseData;
  //  NSLog(@"*****Near Driver details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
  
    
    
    // NSLog(@"%@",DataArray);
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
        
        self.view.userInteractionEnabled=YES;
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        arrdetails=[[[responseJSON valueForKey:@"data"]valueForKey:@"tripDetail"] valueForKey:@"trip"];
        
        [[NSUserDefaults standardUserDefaults]setObject:arrdetails forKey:@"detailsofall"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSMutableArray *arrpages=[[NSMutableArray alloc]init];
        arrpages=[responseJSON valueForKey:@"data"];
        
        [[NSUserDefaults standardUserDefaults]setObject:arrpages forKey:@"detailsofall2"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        CancelledViewController *butt=[self.storyboard instantiateViewControllerWithIdentifier:@"CancelledViewController"];
        [self.navigationController pushViewController:butt animated:YES];
    }
}
- (IBAction)profileClicked:(id)sender
{
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {
        self.view.userInteractionEnabled = NO;
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
        [self nak];
    }
}

-(void)nak
{
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getUserCounts]]];
//    
//    request.HTTPMethod = @"POST";
//    
//    NSMutableString* profile = [NSMutableString string];
//    
//    [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
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
//                                   [self parseJSONRespo:data];
//                               }
//                           }];
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *strurl=[NSString stringWithFormat:@"%@%@",BaseUrl,getUserCounts];
    [request setURL:[NSURL URLWithString:strurl]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async (dispatch_get_main_queue(), ^{
       
            if (error)
            {
                
            } else
            {
                if(data != nil) {
                    NSError *error=nil;
                    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                    [self parseJSONRespo:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
        });
    }] resume];

}

-(void)parseJSONRespo:(NSMutableDictionary*)responseData
{
    //  NSError *err;
    
    NSMutableDictionary *responseJSON = responseData;
    
 //   NSLog(@"*****Trip details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    arrcount=[responseJSON valueForKey:@"data"];
    
    [[NSUserDefaults standardUserDefaults]setObject:arrcount forKey:@"tripdetail"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    // NSLog(@"%@",DataArray);
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
        
        self.view.userInteractionEnabled=YES;
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        
        RidereditViewController *edit=[self.storyboard instantiateViewControllerWithIdentifier:@"RidereditViewController"];
        [self.navigationController pushViewController:edit animated:YES];
    }
}



//- (IBAction)sidebarButton:(id)sender {
//

//    [self.revealViewController revealToggle:sender];
//    
//    
//}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidDisappear:(BOOL)animated{
    
    self.title = @"";
    self.view.userInteractionEnabled = YES;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    
        [self.revealViewController.view removeGestureRecognizer:self.revealViewController.panGestureRecognizer];

    [DejalBezelActivityView removeView];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"Dashboard";
    [DejalBezelActivityView removeView];
    self.view.userInteractionEnabled=YES;
    
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    self.revealViewController.delegate = self;
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [self.revealViewController.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }

    
    
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


@end
