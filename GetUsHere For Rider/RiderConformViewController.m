//
//  RiderConformViewController.m
//  Jaguar Enterprises
//
//  Created by bharat on 22/01/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "RiderConformViewController.h"
#import "RiderData.h"
#import "ViewController.h"
#import "DejalActivityView.h"
#import "SWRevealViewController.h"
#import "SidebarViewController.h"
#import "GetUsHere.pch"
#import "RiderViewController.h"


@interface RiderConformViewController ()
{
    RiderData *Riderdata;
}

@end

@implementation RiderConformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title=@"Verify Mobile";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[[self navigationController] navigationBar] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Enter Verification Code" attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor] }];
    self.txtverifycode.attributedPlaceholder = str1;
    self.txtverifycode.textColor=[UIColor purpleColor];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"b" style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(barButtonBackPressed:)];
    [backButton setImage:[UIImage imageNamed:@"Untitled-1-2.png"]];
    
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   
                                   initWithTarget:self
                                   
                                   action:@selector(dismissKeyboard)];
    
    
    
    [self.view addGestureRecognizer:tap];
    
    _verifyCodeview.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];
    
//    _nextbutt.layer.cornerRadius = 10; // this value vary as per your desire
//    _nextbutt.clipsToBounds = YES;
    
    _nextbutt.layer.masksToBounds = YES;
    _nextbutt.layer.cornerRadius = 19.0;
    
    _clickherebutt.layer.masksToBounds = YES;
    _clickherebutt.layer.cornerRadius = 19.0;
    
//    _clickherebutt.layer.cornerRadius = 10; // this value vary as per your desire
//    _clickherebutt.clipsToBounds = YES;
    
    _verifyCodeview.layer.masksToBounds = YES;
    _verifyCodeview.layer.cornerRadius = 19.0;
    
    _nextbutt.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _clickherebutt.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    self.txtverifycode.delegate = self;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back.jpg"]];
    mdata = [NSMutableData data];
    
    
    Riderdata=[RiderData sharedManager];
    
    _resendlab.textColor=[UIColor blackColor];
    _txtverifycode.textColor=[UIColor purpleColor];
    
   // _txtmobile.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
  //  _txtnumber.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
    _txtnumber.text=[NSString stringWithFormat:@"We have been sent a Verification code on your Mobile Number %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"phone"]];
    _txtnumber.textColor=[UIColor blackColor];
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.tintColor=[UIColor whiteColor];
    numberToolbar.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    _txtverifycode.inputAccessoryView = numberToolbar;
    [self.revealViewController.view removeGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;

    
}
    
    
-(void)barButtonBackPressed:(id)sender
{
        RiderViewController *side=[self.storyboard instantiateViewControllerWithIdentifier:@"RiderViewController"];
        [self.navigationController pushViewController:side animated:YES];
}
    
    
-(void)doneWithNumberPad
{
    [_txtverifycode resignFirstResponder];
    
}


- (void)dismissKeyboard

{
    
    [self.txtverifycode resignFirstResponder];
    
}
-(void)nextclickver
{
    
     NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UID"];
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,verification]]];
//
//    
//    
//    request.HTTPMethod = @"POST";
//    
//    NSMutableString* profile = [NSMutableString string];
//    
//    [profile appendString:[NSString stringWithFormat:@"user_id=%@", userID]];
//    [profile appendString:[NSString stringWithFormat:@"&otp=%@", self.txtverifycode.text]];
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
    
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@&otp=%@&user_type=%@", userID, self.txtverifycode.text,@"rider"];
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
    

    
    
}

-(void)parseJSONResponse:(NSMutableDictionary*)responseData
{
    //  NSError *err;
    
    NSMutableDictionary *responseJSON = responseData;
    
 //   NSLog(@"*****verify details ******* %@", responseJSON);
    
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
        str=[[responseJSON valueForKey:@"data"]valueForKey:@"name"];
        strNmae=[[responseJSON valueForKey:@"data"]valueForKey:@"email"];
        deviceid=[[responseJSON valueForKey:@"data"]valueForKey:@"device_id"];
        riderid=[[responseJSON valueForKey:@"data"]valueForKey:@"user_id"];
        mobile=[[responseJSON valueForKey:@"data"]valueForKey:@"mobile_no"];
        strimage=[[responseJSON valueForKey:@"data"]valueForKey:@"image"];
        
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
        [[NSUserDefaults standardUserDefaults] setObject:strimage forKey:@"imag"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"Login"];
        [[NSUserDefaults standardUserDefaults]synchronize];

        
        SidebarViewController *edit = [self.storyboard instantiateViewControllerWithIdentifier:@"SidebarViewController"];
        UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
        [navController setViewControllers: @[edit] animated: NO ];
        [self.revealViewController setFrontViewController:navController animated:YES];
    }
}


- (IBAction)NextClicked:(id)sender
{
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"pleasewait..."];
    
     [self nextclickver];
}

- (IBAction)CallMeClicked:(id)sender
{
     [DejalBezelActivityView activityViewForView:self.view withLabel:@"pleasewait..."];
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UID"];
    
//     NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,resendOtp]]];
//    
//    request.HTTPMethod = @"POST";
//    
//    NSMutableString* profile = [NSMutableString string];
//    
//    [profile appendString:[NSString stringWithFormat:@"user_id=%@", userID]];
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
//                                   [self parseJSONRespons:data];
//                               }
//                           }];
    
    
    NSString *post = [NSString stringWithFormat:@"user_id=%@", userID];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *strurl=[NSString stringWithFormat:@"%@%@",BaseUrl,emailme];
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
    //  NSError *err;
    
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
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"OTP has been sended to your Registered Email Id." delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
      
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}
-(void)viewDidDisappear:(BOOL)animated{
    
    self.title = @"";
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = YES;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"Verify Mobile";
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return NO;
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
