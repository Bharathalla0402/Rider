//
//  ViewController.m
//  GetUsHere For Rider
//
//  Created by bharat on 12/02/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"
#import "DejalActivityView.h"
#import "UserInformation.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "ForgotPasswordViewController.h"
#import "RiderConformViewController.h"
#import "Alertview.h"
#import <Fabric/Fabric.h>
#import "GetUsHere.pch"
#import "MVPopView.h"
#import "DriverDetailsViewController.h"
#import "UpcomingRidesViewController.h"
#import "RatingViewController.h"
#import "ArrivepicknavigateViewController.h"
#import "StartridenavigateViewController.h"
#import "Reachability.h"



@interface ViewController ()
{
    UserInformation *userInfo;
    UIView *popview;
    UIView *footerview;
    
    UITextField *txtverifycode;
    UILabel *forgotPasswordMobileUnderlabel;

}

@end



static NSString * const kClientId = @"941640482857-6sk1v6g933ihv4qh2ml0omr1spfi3jot.apps.googleusercontent.com";

static NSString * const kClientSecret = @"BurxxJzsnm2XX-6hoxPvoKMn";



@implementation ViewController
@synthesize str,strNmae;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back.jpg"]];
    
    arrname=[[NSMutableArray alloc]init];
   // str=[[NSString alloc]init];
    
    self.title=@"SIGN IN";
     self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [[[self navigationController] navigationBar] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    
    
    _loginbutt.layer.cornerRadius = 10; // this value vary as per your desire
    _loginbutt.clipsToBounds = YES;
    _loginbutt.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    _emailview.layer.masksToBounds = YES;
    _emailview.layer.cornerRadius = 19.0;
    _emailview.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];
    
    _passwordview.layer.masksToBounds = YES;
    _passwordview.layer.cornerRadius = 19.0;
    _passwordview.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];
    
    _forgotbutt.tintColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
  //  self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back.jpg"]];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
  
    
    
    NSAttributedString *strname = [[NSAttributedString alloc] initWithString:@"Enter Your Mobile number/Email Id" attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor] }];
    self.txtUserName.attributedPlaceholder = strname;
    self.txtUserName.textColor=[UIColor purpleColor];
    
    
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor] }];
    self.txtPwd.attributedPlaceholder = str1;
    self.txtPwd.textColor=[UIColor purpleColor];
    
    strdevicetoken=[[NSUserDefaults standardUserDefaults]valueForKey:@"devicetoken"];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
     [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    UIButton *facebookbutt=[[UIButton alloc] initWithFrame:CGRectMake(20, 80, self.view.frame.size.width/3-20, 40)];
    facebookbutt.backgroundColor=[UIColor colorWithRed:103.0/255.0f green:125.0/255.0f blue:180.0/255.0f alpha:1.0];
    [facebookbutt setImage:[UIImage imageNamed:@"icon-6.png"] forState:UIControlStateNormal];
    facebookbutt.layer.cornerRadius = 10; // this value vary as per your desire
    facebookbutt.clipsToBounds = YES;
    [facebookbutt addTarget:self action:@selector(LoginwithFacebook:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:facebookbutt];
    
    
    
    UIButton *twitterbutt=[[UIButton alloc] initWithFrame:CGRectMake(facebookbutt.frame.size.width+30, 80, self.view.frame.size.width/3-20, 40)];
     twitterbutt.backgroundColor=[UIColor colorWithRed:109.0/255.0f green:184.0/255.0f blue:240.0/255.0f alpha:1.0];
    [twitterbutt setImage:[UIImage imageNamed:@"icon-7.png"] forState:UIControlStateNormal];
    twitterbutt.layer.cornerRadius = 10; // this value vary as per your desire
    twitterbutt.clipsToBounds = YES;
    [twitterbutt addTarget:self action:@selector(LoginwithTwitter:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:twitterbutt];
    
    UIButton *googlebutt=[[UIButton alloc] initWithFrame:CGRectMake(facebookbutt.frame.size.width+twitterbutt.frame.size.width+40, 80, self.view.frame.size.width/3-20, 40)];
     googlebutt.backgroundColor=[UIColor colorWithRed:218.0/255.0f green:72.0/255.0f blue:53.0/255.0f alpha:1.0];
    [googlebutt setImage:[UIImage imageNamed:@"icon-8.png"] forState:UIControlStateNormal];
    googlebutt.layer.cornerRadius = 10; // this value vary as per your desire
    googlebutt.clipsToBounds = YES;
    [googlebutt addTarget:self action:@selector(LoginwithGoogle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:googlebutt];
    
    _orlabel.layer.cornerRadius = 15;
    _orlabel.layer.masksToBounds = true;
    _orlabel.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    
    _linelabel1.backgroundColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    _linelabel2.backgroundColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   
                                   initWithTarget:self
                                   
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    
    self.txtUserName.delegate =self;
    self.txtPwd.delegate = self;
    
    
    name=[[NSMutableArray alloc]init];
    [self.revealViewController.view removeGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    [self setupOutlets];
   // userInfo=[[UserInformation alloc] init];
    
}

- (void)setupOutlets
{
    self.txtUserName.delegate = self;
    self.txtUserName.tag = 1;
    
    self.txtPwd.delegate = self;
    self.txtPwd.tag = 2;
    
}

- (void)jumpToNextTextField:(UITextField *)textField withTag:(NSInteger)tag
{
    UIResponder *nextResponder = [self.view viewWithTag:tag];
    
    if ([nextResponder isKindOfClass:[UITextField class]])
    {
        [nextResponder becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nextTag = textField.tag + 1;
    [self jumpToNextTextField:textField withTag:nextTag];
    return NO;
}


- (void)dismissKeyboard
{
    [self.txtUserName resignFirstResponder];
    
    [self.txtPwd resignFirstResponder];
    
}


- (IBAction)LoginClicked:(id)sender
{
    _txtUserName.text =[_txtUserName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    _txtPwd.text=[_txtPwd.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    
    if (_txtUserName.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please Enter Your EmailId/Mobile Number" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    else if (_txtPwd.text.length==0)
    {
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please Enter Your Password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    else
    {
        [self checkNetworkStatus];
        
        if (_isInternetConnectionAvailable == NO)  {
            
            [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
             
                    withTitle:@"Message"];
            
        }else
        {
            
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
            [self next];
            
        }
    }
    
}

-(void)PostdateToServerwithParameters:(NSMutableString *)parameters andApiExtension:(NSString *)ext
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,ext]]];
    request.HTTPMethod = @"POST";
    request.HTTPBody  = [parameters dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                                   [DejalBezelActivityView removeViewAnimated:YES];
                               } else {
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

                                   [DejalBezelActivityView removeViewAnimated:YES];
                               }
                           }];
}

-(void)next
{
    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,loginform]]];
//    
//    request.HTTPMethod = @"POST";
//    
//    NSMutableString* profile = [NSMutableString string];
//    
//    [profile appendString:[NSString stringWithFormat:@"mobile_no=%@", self.txtUserName.text]];
//    [profile appendString:[NSString stringWithFormat:@"&password=%@", self.txtPwd.text]];
//    [profile appendString:[NSString stringWithFormat:@"&device_id=%@", [[NSUserDefaults standardUserDefaults]valueForKey:@"devicetoken"]]];
//    [profile appendString:[NSString stringWithFormat:@"&os=%@", @"ios"]];
//    [profile appendString:[NSString stringWithFormat:@"&user_type=%@", @"rider"]];
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
    
    NSString *post = [NSString stringWithFormat:@"mobile_no=%@&password=%@&device_id=%@&os=%@&user_type=%@",self.txtUserName.text,self.txtPwd.text,[[NSUserDefaults standardUserDefaults]valueForKey:@"devicetoken"],@"ios", @"rider"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *strurl=[NSString stringWithFormat:@"%@%@",BaseUrl,loginform];
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
    
    
    
  //  NSLog(@"*****login details ******* %@", responseJSON);
    
    if (responseJSON==NULL)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"message" message:@"Please wait for some time there is a server problem" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    NSString *status = [responseJSON valueForKey:@"status"];
    NSString *code=[responseJSON valueForKey:@"code"];
    NSString *messag=[[responseJSON valueForKey:@"data"]valueForKey:@"message"];
    NSString *messaenewuser=[responseJSON valueForKey:@"message"];
    
    
    str=[[responseJSON valueForKey:@"data"]valueForKey:@"name"];
    strNmae=[[responseJSON valueForKey:@"data"]valueForKey:@"email"];
    deviceid=[[responseJSON valueForKey:@"data"]valueForKey:@"device_id"];
    riderid=[[responseJSON valueForKey:@"data"]valueForKey:@"user_id"];
    strtotaltrips=[[responseJSON valueForKey:@"data"]valueForKey:@"total_trip"];
    strcancelltrips=[[responseJSON valueForKey:@"data"]valueForKey:@"canceled_trip"];
    mobile=[[responseJSON valueForKey:@"data"]valueForKey:@"mobile_no"];
    strimage=[[responseJSON valueForKey:@"data"]valueForKey:@"image"];
    NSLog(@"name:   %@",str);
    
    [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"named"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:strNmae forKey:@"email"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:deviceid forKey:@"device"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:riderid forKey:@"rid"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:riderid forKey:@"UID"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:mobile forKey:@"phone"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:strtotaltrips forKey:@"total"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:strcancelltrips forKey:@"cancelled"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:strimage forKey:@"imag"];
    [[NSUserDefaults standardUserDefaults]synchronize];


    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        
        if (([[NSString stringWithFormat:@"%@",code] isEqualToString:@"Your account is not verified yet"])||([[NSString stringWithFormat:@"%@",messag] isEqualToString:@"Your account is not verified yet"]))
        {
//            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"message" message:[[responseJSON valueForKey:@"data"]valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
//            
//            [alert show];
//           
//            RiderConformViewController *con=[self.storyboard instantiateViewControllerWithIdentifier:@"RiderConformViewController"];
//            [self.navigationController pushViewController:con animated:YES];
            
            [self ReverifyAccount];
            
        }
        else if ([[NSString stringWithFormat:@"%@",messaenewuser] isEqualToString:@"new_user"])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Your Not Registered With Us.Please Register to Communicate with us." delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        else
        {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            
            [alert show];
        }

    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        
        [[UserInformation sharedController] updateuserinfo:responseJSON];
        
        NSData *encode = [NSKeyedArchiver archivedDataWithRootObject:[UserInformation sharedController]];
        [[NSUserDefaults standardUserDefaults] setObject:encode forKey:@"name"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        

        [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"Login"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
        [self performSegueWithIdentifier:@"rider" sender:nil];
    }
    
}


-(void)ReverifyAccount
{

    popview = [[ UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2-100, 300, 200)];
    footerview.backgroundColor = [UIColor whiteColor];
    [popview addSubview:footerview];
    
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, footerview.frame.size.width, 40)];
    lab.text=@"Verify Account";
    lab.textColor=[UIColor blackColor];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font=[UIFont systemFontOfSize:16];
    [footerview addSubview:lab];
    
    UILabel *labeunder=[[UILabel alloc]initWithFrame:CGRectMake(0, lab.frame.origin.y+lab.frame.size.height+1, footerview.frame.size.width, 2)];
    labeunder.backgroundColor=[UIColor darkGrayColor];
    [footerview addSubview:labeunder];
    
    
    txtverifycode=[[UITextField alloc]initWithFrame:CGRectMake(10, labeunder.frame.size.height+labeunder.frame.origin.y+15, footerview.frame.size.width-20, 40)];
    NSAttributedString *strw = [[NSAttributedString alloc] initWithString:@"Enter Your Verification Code" attributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }];
    txtverifycode.attributedPlaceholder = strw;
    txtverifycode.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    txtverifycode.textColor=[UIColor blackColor];
    txtverifycode.font = [UIFont systemFontOfSize:15];
    txtverifycode.backgroundColor=[UIColor clearColor];
    txtverifycode.delegate=self;
    [txtverifycode setKeyboardType:UIKeyboardTypeNumberPad];
    txtverifycode.returnKeyType = UIReturnKeyDone;
    [footerview addSubview:txtverifycode];
    
    forgotPasswordMobileUnderlabel=[[UILabel alloc] initWithFrame:CGRectMake(10, txtverifycode.frame.size.height+txtverifycode.frame.origin.y+1, footerview.frame.size.width-20, 2)];
    forgotPasswordMobileUnderlabel.backgroundColor=[UIColor lightGrayColor];
    [footerview addSubview:forgotPasswordMobileUnderlabel];
    
    UIButton *butt=[[UIButton alloc]initWithFrame:CGRectMake(6,forgotPasswordMobileUnderlabel.frame.origin.y+forgotPasswordMobileUnderlabel.frame.size.height+35,footerview.frame.size.width/3-8,40)];
    [butt setTitle:@"Cancel" forState:UIControlStateNormal];
    butt.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    butt.titleLabel.textAlignment = NSTextAlignmentCenter;
    [butt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [butt addTarget:self action:@selector(CancelButtClicked:) forControlEvents:UIControlEventTouchUpInside];
    butt.backgroundColor=[UIColor grayColor];
    [footerview addSubview:butt];
    
    UIButton *butt1=[[UIButton alloc]initWithFrame:CGRectMake(butt.frame.size.width+butt.frame.origin.x+6, forgotPasswordMobileUnderlabel.frame.origin.y+forgotPasswordMobileUnderlabel.frame.size.height+35, footerview.frame.size.width/3-8, 40)];
    [butt1 setTitle:@"Done" forState:UIControlStateNormal];
    butt1.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    butt1.titleLabel.textAlignment = NSTextAlignmentCenter;
    [butt1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [butt1 addTarget:self action:@selector(DoneButtClicked:) forControlEvents:UIControlEventTouchUpInside];
    butt1.backgroundColor=[UIColor lightGrayColor];
    [footerview addSubview:butt1];
    
    
    UIButton *butt2=[[UIButton alloc]initWithFrame:CGRectMake(butt1.frame.size.width+butt1.frame.origin.x+6, forgotPasswordMobileUnderlabel.frame.origin.y+forgotPasswordMobileUnderlabel.frame.size.height+35, footerview.frame.size.width/3-8, 40)];
    [butt2 setTitle:@"Re-Send" forState:UIControlStateNormal];
    butt2.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    butt2.titleLabel.textAlignment = NSTextAlignmentCenter;
    [butt2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    butt2.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [butt2 addTarget:self action:@selector(ResendButtClicked:) forControlEvents:UIControlEventTouchUpInside];
    butt2.backgroundColor=[UIColor darkGrayColor];
    [footerview addSubview:butt2];
    
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.tintColor=[UIColor whiteColor];
    numberToolbar.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad2)],
                           nil];
    [numberToolbar sizeToFit];
    
    txtverifycode.inputAccessoryView = numberToolbar;
    
}

-(void)doneWithNumberPad2
{
    [txtverifycode resignFirstResponder];
}

-(IBAction)CancelButtClicked:(id)sender
{
    [footerview removeFromSuperview];
    popview.hidden = YES;
}

-(IBAction)DoneButtClicked:(id)sender
{
    if (txtverifycode.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please Enter Your  Verification Code" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UID"];
        NSString *post = [NSString stringWithFormat:@"user_id=%@&otp=%@&user_type=%@", userID, txtverifycode.text,@"rider"];
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        NSString *strurl=[NSString stringWithFormat:@"%@%@",BaseUrl,verification];
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
        [footerview removeFromSuperview];
        popview.hidden = YES;
    }
}


-(IBAction)ResendButtClicked:(id)sender
{
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"pleasewait..."];
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UID"];
    NSString *post = [NSString stringWithFormat:@"user_id=%@", userID];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *strurl=[NSString stringWithFormat:@"%@%@",BaseUrl,resendOtp];
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
                    [self parseJSONRespons:responseJSON];
                    [DejalBezelActivityView removeView];
                }
            }
            
        });
    }] resume];
}


-(void)parseJSONRespons:(NSMutableDictionary*)responseData
{
    NSMutableDictionary *responseJSON = responseData;
    NSLog(@"***** Re-verify details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    // NSLog(@"%@",DataArray);
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
    
    }
}


- (IBAction)LoginwithFacebook:(id)sender {
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"email",@"public_profile",@"user_friends"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            // Process error
            //self.lblReturn.text = [NSString stringWithFormat:@"FB: %@", error];
            NSLog(@"%@",error);
            
        } else if (result.isCancelled) {
            // Handle cancellations
            NSLog(@"FB Cancelled");
            
        } else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if ([result.grantedPermissions containsObject:@"email"]) {
                // Do work
                [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields" : @"email,name,first_name,last_name,gender,birthday"}]
                 startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                     if (!error) {
                         NSLog(@"fetched user:%@", result);
                         
                         [[NSUserDefaults standardUserDefaults]setObject:[result valueForKey:@"name"] forKey:@"name"];
                         [[NSUserDefaults standardUserDefaults]synchronize];
                         
                         [[NSUserDefaults standardUserDefaults]setObject:[result valueForKey:@"email"] forKey:@"email"];
                         [[NSUserDefaults standardUserDefaults]synchronize];
                         
//                         NSMutableString* profile = [NSMutableString string];
//                         [profile appendString:[NSString stringWithFormat:@"fb_id=%@", [result objectForKey:@"id"]]];
//                         [profile appendString:[NSString stringWithFormat:@"&login_with=%@", @"facebook"]];
//                         [profile appendString:[NSString stringWithFormat:@"&device_id=%@", [[NSUserDefaults standardUserDefaults]valueForKey:@"devicetoken"]]];
//                         
//                         [self PostdateToServerwithParameters:profile andApiExtension:@"social_login"];
                         
                         NSString *post = [NSString stringWithFormat:@"fb_id=%@&login_with=%@&device_id=%@", [result objectForKey:@"id"],@"facebook",[[NSUserDefaults standardUserDefaults]valueForKey:@"devicetoken"]];
                         NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
                         NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
                         NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                         NSString *strurl=[NSString stringWithFormat:@"%@%@",BaseUrl,socialLogin];
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
                 }];
                
            }
        }
        
    }];
}



- (IBAction)LoginwithGoogle:(id)sender
{
    
    GTMOAuth2ViewControllerTouch *authController;
    authController = [[GTMOAuth2ViewControllerTouch alloc]
                      initWithScope:@"https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/plus.me"
                      clientID:kClientId
                      clientSecret:kClientSecret
                      keychainItemName:[GPPSignIn sharedInstance].keychainName
                      delegate:self
                      finishedSelector:@selector(viewController:finishedWithAuth:error:)];
    [[self navigationController] pushViewController:authController animated:YES];
    
}


- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController finishedWithAuth:(GTMOAuth2Authentication *)auth error:(NSError *)error{
    if (error != nil) {
        // Authentication failed
        NSLog(@"Authentication Error %@", error.localizedDescription);
        self.auth=nil;
        return;
    }
    else
    {
        self.auth = auth;
        [self finishedWithAuth:auth error:error];
    }
    
}
- (void)finishedWithAuth:(GTMOAuth2Authentication *)auth
                   error:(NSError *)error
{
    if (error) {
        // Do some error handling here.
    } else {
        [self refreshInterfaceBasedOnSignIn];
    }
}
-(void)refreshInterfaceBasedOnSignIn{
        // The user is signed in.
        // NSLog(@"user email - %@",[GPPSignIn sharedInstance].authentication.userEmail);
        GTLServicePlus* plusService = [[GTLServicePlus alloc] init] ;
        plusService.retryEnabled = YES;
        // 2. Set a valid |GTMOAuth2Authentication| object as the authorizer.
        [plusService setAuthorizer:self.auth];
   
        GTLQueryPlus *query = [GTLQueryPlus queryForPeopleGetWithUserId:@"me"];
    
        [plusService executeQuery:query
                completionHandler:^(GTLServiceTicket *ticket,
                                    GTLPlusPerson *person,
                                    NSError *error) {
                    if (error) {
                    
                    } else
                    {
                        NSLog(@" person%@",person);
                        
                        [self performLoginWIthGoogle:person];
                        
                    }
                }];
        
        // Perform other actions here, such as showing a sign-out button
    
}
-(void)performLoginWIthGoogle:(GTLPlusPerson *)me
{
   
    email = self.auth.userEmail;
    NSString *userid = me.identifier;
    NSString *firstname = me.name.givenName;
    NSString *lastname = me.name.familyName;
    NSString *fullname = [firstname stringByAppendingString:lastname];
    
    NSLog(@"\n%@\n%@\n%@\n%@\n%@",email,userid,firstname,lastname,fullname);
    
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    [self nexgmail];
    
}
-(void)nexgmail
{
    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,socialLogin]]];
//    
//    request.HTTPMethod = @"POST";
//    
//    NSMutableString* profile = [NSMutableString string];
//    
//    [profile appendString:[NSString stringWithFormat:@"email=%@", email]];
//    [profile appendString:[NSString stringWithFormat:@"&login_with=%@", @"google"]];
//    [profile appendString:[NSString stringWithFormat:@"&device_id=%@", [[NSUserDefaults standardUserDefaults]valueForKey:@"devicetoken"]]];
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
    
    
    NSString *post = [NSString stringWithFormat:@"email=%@&login_with=%@&device_id=%@",email,@"google",[[NSUserDefaults standardUserDefaults]valueForKey:@"devicetoken"]];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *strurl=[NSString stringWithFormat:@"%@%@",BaseUrl,socialLogin];
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

//http://stackoverflow.com/questions/18845028/get-my-twitter-email
- (IBAction)LoginwithTwitter:(id)sender{
     [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
        if (session) {
            NSLog(@"UserName: %@", [session userName]);
            NSLog(@"Twitter Id: %@", [session userID]);
            strtwitterid=[NSString stringWithFormat:@"%@",[session userID]];
            [self twitter];
        } else {
            NSLog(@"error: %@", [error localizedDescription]);
            [DejalBezelActivityView removeView];
        }
    }];
}
-(void)twitter
{
//     NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,socialLogin]]];
//    request.HTTPMethod = @"POST";
//    NSMutableString* profile = [NSMutableString string];
//    [profile appendString:[NSString stringWithFormat:@"fb_id=%@", strtwitterid]];
//    [profile appendString:[NSString stringWithFormat:@"&login_with=%@", @"twitter"]];
//    [profile appendString:[NSString stringWithFormat:@"&device_id=%@", [[NSUserDefaults standardUserDefaults]valueForKey:@"devicetoken"]]];
//    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
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
    
    NSString *post = [NSString stringWithFormat:@"fb_id=%@&login_with=%@&device_id=%@",strtwitterid,@"twitter",[[NSUserDefaults standardUserDefaults]valueForKey:@"devicetoken"]];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *strurl=[NSString stringWithFormat:@"%@%@",BaseUrl,socialLogin];
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


- (IBAction)ForgotPasswordClicked:(id)sender
{
    ForgotPasswordViewController *bookTax=[self.storyboard instantiateViewControllerWithIdentifier:@"ForgotPasswordViewController"];
    [self.navigationController pushViewController:bookTax animated:YES];

}




-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    const int movementDistance = -50; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}


-(void)viewWillAppear:(BOOL)animated
{
      strdevicetoken=[[NSUserDefaults standardUserDefaults]valueForKey:@"devicetoken"];
      NSLog(@"%@",strdevicetoken);
    self.title=@"SIGN IN";
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }

    

}

-(void)viewDidDisappear:(BOOL)animated
{
    self.title = @"";
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    
//       
//    [[UIApplication sharedApplication] setStatusBarHidden:NO];
//    [DejalBezelActivityView removeView];
}

-(void)viewDidAppear:(BOOL)animated
{
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    [self.revealViewController.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
