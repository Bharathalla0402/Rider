//
//  RiderMainPageViewController.m
//  Jaguar Enterprises
//
//  Created by bharat on 25/01/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "RiderMainPageViewController.h"
#import "SWRevealViewController.h"
#import "RidereditViewController.h"
#import "ViewController.h"
#import "DejalActivityView.h"
#import "UserInformation.h"
#import "SidebarViewController.h"
#import "FarecarselectViewController.h"
#import "SettingsViewController.h"
#import "FareEstimateViewController.h"
#import "UpcomingRidesViewController.h"
#import "AboutUsViewController.h"
#import "TermsofuseViewController.h"
#import "GetUsHere.pch"
#import "UIImageView+WebCache.h"
#import "SplachscreenViewController.h"
#import "Reachability.h"



@interface RiderMainPageViewController ()

@end

@implementation RiderMainPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    arr=[[NSMutableArray alloc]init];
    mdata=[[NSMutableData alloc]init];
    arrdetails=[[NSMutableArray alloc]init];
    
    
    
    arrtitle=[[NSMutableArray alloc]initWithObjects:@"My Rides",@"Fare Estimate",@"Settings",@"About HoppInRide",@"Rate the app",@"Support",@"Terms of use",@"Logout",@"version 1.0.5", nil];
    
   arrimage=[[NSMutableArray alloc]initWithObjects:@"car5.png",@"price5.png",@"settings5.png",@"about5.png",@"rate5.png",@"support5.png",@"terms5.png",@"logout5.png",@"version5.png", nil];
    
     self.view.backgroundColor = [UIColor whiteColor];
    
    arrcount=[[NSMutableArray alloc]init];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    _profiimage.layer.cornerRadius = _profiimage.frame.size.height /2;
    _profiimage.layer.masksToBounds = YES;
    _profiimage.layer.borderWidth = 0;
    
    _profileView.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    _backView.backgroundColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    
    
//    NSData *Decode=[[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
//    UserInformation *info = [NSKeyedUnarchiver unarchiveObjectWithData:Decode];

 //   _txtname.text=aValue;
//    _txtTrips.text=[NSString stringWithFormat:@"%@",info.totalTrips];
    //[[NSUserDefaults standardUserDefaults] objectForKey:@"trip"];
//   _txtCancell.text=[NSString stringWithFormat:@"%@",info.cancelTrips];
    //[[NSUserDefaults standardUserDefaults] objectForKey:@"Cancel"];
    
//    [DejalBezelActivityView activityViewForView:self.view withLabel:@"pleasewait..."];
//    [self nak];
    
}

-(void)nak
{
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getUserCounts]]];
//    
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
    
  //  NSLog(@"*****Trip details ******* %@", responseJSON);
    
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
        strtotal=[NSString stringWithFormat:@"%@",[arrcount valueForKey:@"total_trip"]];
        strcancelled=[NSString stringWithFormat:@"%@",[arrcount valueForKey:@"canceled_trip"]];
        
        _txtTrips.text=strtotal;
        _txtCancell.text=strcancelled;
    }
}


- (IBAction)EditClicked:(id)sender
{
    RidereditViewController *edit = [self.storyboard instantiateViewControllerWithIdentifier:@"RidereditViewController"];
    UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
    [navController setViewControllers: @[edit] animated: NO ];
    [self.revealViewController setFrontViewController:navController animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 51;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrtitle.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellClassName = @"Customcell1";
    
   cell = (Customcell1 *)[tableView dequeueReusableCellWithIdentifier: CellClassName];
    
    if (cell == nil)
    {
        cell = [[Customcell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellClassName];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Customcell1"
                                                     owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.backgroundColor=[UIColor blackColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    UILabel *lblName=(UILabel *)[cell viewWithTag:2];
    UIImageView *image=(UIImageView*)[cell viewWithTag:1];
    lblName.text=[arrtitle objectAtIndex:indexPath.row];
    NSString *imageName=[arrimage objectAtIndex:indexPath.row];
    image.image=[UIImage imageNamed:imageName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
        [self n];

    }
    else if (indexPath.row==1)
    {
       [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
        [self next];
        
    }
    else if (indexPath.row==2)
    {
        SettingsViewController *edit = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
        UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
        [navController setViewControllers: @[edit] animated: NO ];
        [self.revealViewController setFrontViewController:navController animated:YES];
    }
    else if (indexPath.row==3)
    {
        AboutUsViewController *edit = [self.storyboard instantiateViewControllerWithIdentifier:@"AboutUsViewController"];
        UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
        [navController setViewControllers: @[edit] animated: NO ];
        [self.revealViewController setFrontViewController:navController animated:YES];
    }
    else if (indexPath.row==4)
    {
        
   NSString *iTunesLink = @"itms://itunes.apple.com/us/app/apple-store/id1133221799?mt=8"; [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
    }
    else if (indexPath.row==5)
    {
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://hoppinride.com/#contact"]];
    }
    else if (indexPath.row==6)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://hoppinride.com/#contact"]];

    }
    else if (indexPath.row==7)
    {
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"Are You Sure Want to Logout" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Signout", nil];
        [alert show];
    }
    else if (indexPath.row==8)
    {
      
    }
    else
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
   
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [alertView firstOtherButtonIndex])
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Login"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
//        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
        
        SplachscreenViewController *edit = [self.storyboard instantiateViewControllerWithIdentifier:@"SplachscreenViewController"];
        UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
        [navController setViewControllers: @[edit] animated: NO ];
        [self.revealViewController setFrontViewController:navController animated:YES];
    }
}


-(void)n
{
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getTrips]]];
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
    
    NSMutableDictionary *responseJSON = responseData;  //  NSLog(@"*****Near Driver details ******* %@", responseJSON);
    NSString *status = [responseJSON valueForKey:@"status"];
  
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        arrdetails=nil;
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrdetails];
        [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"detailsofall"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSMutableArray *arrpages=[[NSMutableArray alloc]init];
        arrpages=[responseJSON valueForKey:@"data"];
        
        [[NSUserDefaults standardUserDefaults]setObject:arrpages forKey:@"detailsofall2"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        UpcomingRidesViewController *edit = [self.storyboard instantiateViewControllerWithIdentifier:@"UpcomingRidesViewController"];
        UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
        [navController setViewControllers: @[edit] animated: NO ];
        [self.revealViewController setFrontViewController:navController animated:YES];
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

        
        UpcomingRidesViewController *edit = [self.storyboard instantiateViewControllerWithIdentifier:@"UpcomingRidesViewController"];
        UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
        [navController setViewControllers: @[edit] animated: NO ];
        [self.revealViewController setFrontViewController:navController animated:YES];
    }
}

-(void)next
{
//     NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,getcarTypes]]];
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
                  [self parseJSONResponsej:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }

        });
    }] resume];
}

-(void)parseJSONResponsej:(NSMutableDictionary*)responseData
{
    //  NSError *err;
    
    NSMutableDictionary *responseJSON = responseData;
  //  NSLog(@"*****Cars details ******* %@", responseJSON);
    NSString *status = [responseJSON valueForKey:@"status"];
    arrcars=[responseJSON valueForKey:@"data"];
    
    [[NSUserDefaults standardUserDefaults]setObject:arrcars forKey:@"cars"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        FareEstimateViewController *edit = [self.storyboard instantiateViewControllerWithIdentifier:@"FareEstimateViewController"];
        UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
        [navController setViewControllers: @[edit] animated: NO ];
        [self.revealViewController setFrontViewController:navController animated:YES];
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    str=[[NSUserDefaults standardUserDefaults]valueForKey:@"named"];
    NSLog(@"%@",str);
    
    _txtname.text=str;
    
    NSString *strurl=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"imag"]];
    
        [_profiimage sd_setImageWithURL:[NSURL URLWithString:strurl]
                       placeholderImage:[UIImage imageNamed:@"profilepic.png"]];
    
    _txtTrips.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"totaltrips"];
    _txtCancell.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"cancellrdtrips"];
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
    
 //   NSLog(@"***** login check details ******* %@", responseJSON);
    
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


- (IBAction)buttonClicked:(id)sender
{
    
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)
    {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {
        
     //   self.view.userInteractionEnabled=NO;
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"pleasewait..."];
        [self nakp];
        
    }
}

-(void)nakp
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
//                                   [self parseJSONRespoprofile:data];
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
             [self parseJSONRespoprofile:data];
            
        });
    }] resume];
}

-(void)parseJSONRespoprofile:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
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
        RidereditViewController *edit = [self.storyboard instantiateViewControllerWithIdentifier:@"RidereditViewController"];
        UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
        [navController setViewControllers: @[edit] animated: NO ];
        [self.revealViewController setFrontViewController:navController animated:YES];
        
        //        RidereditViewController *edit=[self.storyboard instantiateViewControllerWithIdentifier:@"RidereditViewController"];
        //        [self.navigationController pushViewController:edit animated:YES];
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




-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
   // [self.revealViewController.view removeGestureRecognizer:self.revealViewController.panGestureRecognizer];
  //  [self.revealViewController.frontViewController.view setUserInteractionEnabled:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
