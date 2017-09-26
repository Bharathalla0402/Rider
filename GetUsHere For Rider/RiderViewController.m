//
//  RiderViewController.m
//  Jaguar Enterprises
//
//  Created by bharat on 22/01/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "RiderViewController.h"
#import "RiderData.h"
#import "DejalActivityView.h"
#import "SWRevealViewController.h"
#import "GmailViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "TermsofuseViewController.h"
#import "TwitterViewController.h"
#import <TwitterKit/TwitterKit.h>
#import "GetUsHere.pch"
#import "MVPopView.h"
#import "SWRevealViewController.h"
#import "Reachability.h"
#import "SplachscreenViewController.h"

@interface RiderViewController ()
{
    RiderData *Rdata;
    NSString *strgender;
}

@property (nonatomic, strong)MVPopView *popView;
@end
static NSString * const kClientId = @"941640482857-6sk1v6g933ihv4qh2ml0omr1spfi3jot.apps.googleusercontent.com";

static NSString * const kClientSecret = @"BurxxJzsnm2XX-6hoxPvoKMn";

@implementation RiderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   
                                   initWithTarget:self
                                   
                                   action:@selector(dismissKeyboard)];
    
    
    
    [self.view addGestureRecognizer:tap];
    
    self.title = @"REGISTER";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"b" style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(barButtonBackPressed:)];
    [backButton setImage:[UIImage imageNamed:@"Untitled-1-2.png"]];
    
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    _plusLabel.textColor=[UIColor purpleColor];
    _termLabel.textColor=[UIColor purpleColor];
    
    
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Full Name" attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor] }];
    self.txtName.attributedPlaceholder = str;
    self.txtName.textColor=[UIColor purpleColor];
    
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"Set Password" attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor] }];
    self.txtPassword.attributedPlaceholder = str1;
    self.txtPassword.textColor=[UIColor purpleColor];
    
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"Re-enter password" attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor] }];
    self.txtReenter.attributedPlaceholder = str2;
    self.txtReenter.textColor=[UIColor purpleColor];
    
    NSAttributedString *str3 = [[NSAttributedString alloc] initWithString:@"Please Click here to select the Gender" attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor] }];
    self.txtgender.attributedPlaceholder = str3;
    self.txtgender.textColor=[UIColor purpleColor];
    
    NSAttributedString *str4 = [[NSAttributedString alloc] initWithString:@"CCode" attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor] }];
    self.txtCountryCode.attributedPlaceholder = str4;
    self.txtCountryCode.textColor=[UIColor purpleColor];
    
    NSAttributedString *str5 = [[NSAttributedString alloc] initWithString:@"Phone no" attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor] }];
    self.txtPhone.attributedPlaceholder = str5;
    self.txtPhone.textColor=[UIColor purpleColor];
    
    NSAttributedString *str6 = [[NSAttributedString alloc] initWithString:@"Email Id" attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor] }];
    self.txtEmail.attributedPlaceholder = str6;
    self.txtEmail.textColor=[UIColor purpleColor];
    
    
    _nameView.layer.masksToBounds = YES;
    _nameView.layer.cornerRadius = 19.0;
    _nameView.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];
    
    _passwordView.layer.masksToBounds = YES;
    _passwordView.layer.cornerRadius = 19.0;
    _passwordView.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];

    
    _reenterView.layer.masksToBounds = YES;
    _reenterView.layer.cornerRadius = 19.0;
    _reenterView.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];

    
    _genderView.layer.masksToBounds = YES;
    _genderView.layer.cornerRadius = 19.0;
    _genderView.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];


    _ccView.layer.masksToBounds = YES;
    _ccView.layer.cornerRadius = 19.0;
    _ccView.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];

    
    _numberView.layer.masksToBounds = YES;
    _numberView.layer.cornerRadius = 19.0;
    _numberView.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];


    _emailView.layer.masksToBounds = YES;
    _emailView.layer.cornerRadius = 19.0;
    _emailView.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];

    
  _registerbutt.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
  //  _scrollViewlend.contentSize=CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    
    CGSize scrollableSize = CGSizeMake(320, 620);
    [_scrollViewlend setContentSize:scrollableSize];
    
    
    

    
    UIButton *facebookbutt=[[UIButton alloc] initWithFrame:CGRectMake(20, 80, self.view.frame.size.width/3-20, 40)];
    facebookbutt.backgroundColor=[UIColor colorWithRed:103.0/255.0f green:125.0/255.0f blue:180.0/255.0f alpha:1.0];
    [facebookbutt setImage:[UIImage imageNamed:@"icon-6.png"] forState:UIControlStateNormal];
    facebookbutt.layer.cornerRadius = 10; // this value vary as per your desire
    facebookbutt.clipsToBounds = YES;
    [facebookbutt addTarget:self action:@selector(FacebookRegistrationClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollViewlend addSubview:facebookbutt];
    
    
    UIButton *twitterbutt=[[UIButton alloc] initWithFrame:CGRectMake(facebookbutt.frame.size.width+30, 80, self.view.frame.size.width/3-20, 40)];
    twitterbutt.backgroundColor=[UIColor colorWithRed:109.0/255.0f green:184.0/255.0f blue:240.0/255.0f alpha:1.0];
    [twitterbutt setImage:[UIImage imageNamed:@"icon-7.png"] forState:UIControlStateNormal];
    twitterbutt.layer.cornerRadius = 10; // this value vary as per your desire
    twitterbutt.clipsToBounds = YES;
    [twitterbutt addTarget:self action:@selector(TwitterClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollViewlend addSubview:twitterbutt];
    
    UIButton *googlebutt=[[UIButton alloc] initWithFrame:CGRectMake(facebookbutt.frame.size.width+twitterbutt.frame.size.width+40, 80, self.view.frame.size.width/3-20, 40)];
    googlebutt.backgroundColor=[UIColor colorWithRed:218.0/255.0f green:72.0/255.0f blue:53.0/255.0f alpha:1.0];
    [googlebutt setImage:[UIImage imageNamed:@"icon-8.png"] forState:UIControlStateNormal];
    googlebutt.layer.cornerRadius = 10; // this value vary as per your desire
    googlebutt.clipsToBounds = YES;
    [googlebutt addTarget:self action:@selector(googlesigninClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollViewlend addSubview:googlebutt];
    
    _orlabel.layer.cornerRadius = 15;
    _orlabel.layer.masksToBounds = true;
    _orlabel.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    
    _linelabel1.backgroundColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    _linelabel2.backgroundColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];

    
    
    [[[self navigationController] navigationBar] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    self.txtName.delegate =self;
    self.txtPassword.delegate = self;
    self.txtReenter.delegate = self;
    self.txtEmail.delegate = self;
    self.txtPhone.delegate = self;
    self.txtCountryCode.delegate=self;
    
     mdata = [[NSMutableData alloc]init];
     checked = NO;
    Rdata = [RiderData sharedManager];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back.jpg"]];
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.tintColor=[UIColor whiteColor];
    numberToolbar.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    
    _txtPhone.inputAccessoryView = numberToolbar;
    _txtCountryCode.inputAccessoryView=numberToolbar;
    [self.revealViewController.view removeGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;

    
    [self setupOutlets];
}

-(void)doneWithNumberPad
{
    [_txtPhone resignFirstResponder];
    [_txtCountryCode resignFirstResponder];
}

-(void)barButtonBackPressed:(id)sender
{
        SplachscreenViewController *side=[self.storyboard instantiateViewControllerWithIdentifier:@"SplachscreenViewController"];
        [self.navigationController pushViewController:side animated:YES];
}

    
    
- (void)dismissKeyboard
{
    [self.txtName resignFirstResponder];
    [self.txtPassword resignFirstResponder];
    [self.txtReenter resignFirstResponder];
    [self.txtEmail resignFirstResponder];
    [self.txtPhone resignFirstResponder];
    [self.txtCountryCode resignFirstResponder];
}



- (IBAction)RegisterClicked:(id)sender
{
    if(_txtName.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please enter YourName" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    else if(_txtPassword.text.length==0)
    {
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please enter Password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
    else if(_txtReenter.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please Confirm Password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    else if (![_txtPassword.text isEqualToString:_txtReenter.text])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Confirm password is not matching" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];

    }
    else if(_txtCountryCode.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please enter Your Country Code" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if(_txtPhone.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please enter Your Mobile Number" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if(_txtEmail.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please Enter Email Id" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    else if (![self NSStringIsValidEmail:_txtEmail.text])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please Enter Valid Email Id" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (checked !=YES)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please Agree user terms and conditions" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
          //      Rdata.Phone = _txtPhone.text;
        //        [self performSegueWithIdentifier:@"conform" sender:nil];
        
        
        [self checkNetworkStatus];
        
        if (_isInternetConnectionAvailable == NO)  {
            
            [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
             
                    withTitle:@"message"];
            
        }else
        {
            
            NSString *string = _txtEmail.text;
            stremailid = [string stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceCharacterSet]];
            
            NSString *sre=[NSString stringWithFormat:@"+%@",_txtCountryCode.text];
            
            strCountryCodeMobile = [sre stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
            
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
            [self next];
            
        }
    }
}

-(void)next
{
    
  //  NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UID"];
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,registration]]];
//    
//    request.HTTPMethod = @"POST";
//    
//    NSMutableString* profile = [NSMutableString string];
//    
//    [profile appendString:[NSString stringWithFormat:@"name=%@", self.txtName.text]];
//    [profile appendString:[NSString stringWithFormat:@"&password=%@", self.txtPassword.text]];
//    [profile appendString:[NSString stringWithFormat:@"&email=%@", stremailid]];
//    [profile appendString:[NSString stringWithFormat:@"&ccode=%@", strCountryCodeMobile]];
//    [profile appendString:[NSString stringWithFormat:@"&mobile_no=%@", _txtPhone.text]];
//    [profile appendString:[NSString stringWithFormat:@"&user_sex=%@", strgender]];
//    [profile appendString:[NSString stringWithFormat:@"&user_type=%@", @"rider"]];
//    [profile appendString:[NSString stringWithFormat:@"&os=%@", @"ios"]];
//    [profile appendString:[NSString stringWithFormat:@"&device_id=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"devicetoken"]]];
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
    
    
    
    NSString *post = [NSString stringWithFormat:@"name=%@&password=%@&email=%@&ccode=%@&mobile_no=%@&user_sex=%@&user_type=%@&os=%@&device_id=%@", self.txtName.text, self.txtPassword.text,stremailid,strCountryCodeMobile,_txtPhone.text,strgender,@"rider",@"ios",[[NSUserDefaults standardUserDefaults]valueForKey:@"devicetoken"]];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *strurl=[NSString stringWithFormat:@"%@%@",BaseUrl,registration];
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
    
  //  NSLog(@"*****Registration details ******* %@", responseJSON);
    
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
        
        Rdata.UserId = [[responseJSON valueForKey:@"data"] valueForKey:@"user_id"];
        
        [[NSUserDefaults standardUserDefaults] setObject:[[responseJSON valueForKey:@"data"] valueForKey:@"user_id"] forKey:@"UID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:_txtPhone.text forKey:@"phone"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:_txtEmail.text forKey:@"email"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:_txtPassword.text forKey:@"password"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [self performSegueWithIdentifier:@"conform" sender:nil];
    }
}



-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    NSString *trimmedString = [checkString stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    return [emailTest evaluateWithObject:trimmedString];
}


- (IBAction)FacebookRegistrationClicked:(id)sender
{
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
                         
                         [[NSUserDefaults standardUserDefaults]setObject:[result valueForKey:@"id"] forKey:@"ID"];
                         [[NSUserDefaults standardUserDefaults]synchronize];
                         
                         [self performSegueWithIdentifier:@"facebook" sender:self];
                        
                     }
                 }];
                
            }
        }
        
    }];

}



- (IBAction)googlesigninClicked:(id)sender
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


- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController finishedWithAuth:(GTMOAuth2Authentication *)auth error:(NSError *)error
{
    if (error != nil)
    {
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
    
    NSString *email = self.auth.userEmail;
    NSString *userid = me.identifier;
    NSString *firstname = me.name.givenName;
    NSString *lastname = me.name.familyName;
    NSString *fullname = [firstname stringByAppendingString:lastname];
    
    NSLog(@"\n%@\n%@\n%@\n%@\n%@",email,userid,firstname,lastname,fullname);
    
    
    [[NSUserDefaults standardUserDefaults]setObject:email forKey:@"gmail"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:userid forKey:@"usergmail"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults]setObject:fullname forKey:@"gmailname"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    GmailViewController *gmail=[self.storyboard instantiateViewControllerWithIdentifier:@"GmailViewController"];
    [self.navigationController pushViewController:gmail animated:YES];
}


- (IBAction)TwitterClicked:(id)sender
{
     [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    
    [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
        if (session) {
            NSLog(@"UserName: %@", [session userName]);
            NSLog(@"Twitter Id: %@", [session userID]);
            
            strtwitterid=[NSString stringWithFormat:@"%@",[session userID]];
            strtwername=[NSString stringWithFormat:@"%@",[session userName]];
            
            [[NSUserDefaults standardUserDefaults]setObject:strtwitterid forKey:@"tid"];
            [[NSUserDefaults standardUserDefaults]setObject:strtwername forKey:@"tname"];
            
            TwitterViewController *twitter=[self.storyboard instantiateViewControllerWithIdentifier:@"TwitterViewController"];
            [self.navigationController pushViewController:twitter animated:YES];
            
            
        } else {
            NSLog(@"error: %@", [error localizedDescription]);
        }
    }];
}


- (IBAction)CheckBoxClicked:(id)sender
{
    if (checked ==NO)
    {
        [checkboxbutton1 setImage:[UIImage imageNamed:@"remember check2.png"] forState:UIControlStateNormal];
        checked =YES;
    }
    else
    {
        [checkboxbutton1 setImage:[UIImage imageNamed:@"remember Check.png"] forState:UIControlStateNormal];
        checked =NO;
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
        NSInteger nextTag = textField.tag + 1;
        [self jumpToNextTextField:textField withTag:nextTag];
        return NO;

}

- (void)setupOutlets
{
    self.txtName.delegate = self;
    self.txtName.tag = 1;
    
    self.txtPassword.delegate = self;
    self.txtPassword.tag = 2;
    
    self.txtReenter.delegate = self;
    self.txtReenter.tag = 3;
    
    self.txtCountryCode.delegate = self;
    self.txtCountryCode.tag = 4;
    
    self.txtPhone.delegate = self;
    self.txtPhone.tag = 5;
    
    self.txtEmail.delegate = self;
    self.txtEmail.tag = 6;
    
   
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


-(void)viewDidDisappear:(BOOL)animated{
    
    self.title = @"";
    [DejalBezelActivityView removeView];
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = YES;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"REGISTER";
    
    _popView = [[MVPopView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-20, 80)];
    _popView.backgroundColor =  [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2)-(self.view.frame.size.width/2),7,self.view.frame.size.width,30)];
    [btn addTarget:self action:@selector(hideBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"Male" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_popView addSubview:btn];
    
    UILabel *la1=[[UILabel alloc]initWithFrame:CGRectMake(0, 41, self.view.frame.size.width-20, 2)];
    [la1 setBackgroundColor:[UIColor whiteColor]];
    [_popView addSubview:la1];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2)-(self.view.frame.size.width/2),45,self.view.frame.size.width,30)];
    [btn1 addTarget:self action:@selector(hideBtnTapped1) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitle:@"Female" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_popView addSubview:btn1];
}

- (void)hideBtnTapped
{
    _txtgender.text=@"Male";
    strgender=@"m";
    [_popView dismiss];
}

- (void)hideBtnTapped1
{
    _txtgender.text=@"Female";
    strgender=@"f";
    [_popView dismiss];
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
    if (textField==_txtName)
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
    else if (textField==_txtPassword)
    {
        const int movementDistance = -100; // tweak as needed
        const float movementDuration = 0.3f; // tweak as needed
        
        int movement = (up ? movementDistance : -movementDistance);
        
        [UIView beginAnimations: @"animateTextField" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
    }
    else if (textField==_txtReenter)
    {
        const int movementDistance = -190; // tweak as needed
        const float movementDuration = 0.3f; // tweak as needed
        
        int movement = (up ? movementDistance : -movementDistance);
        
        [UIView beginAnimations: @"animateTextField" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
    }
    else if (textField==_txtCountryCode || textField==_txtPhone)
    {
        const int movementDistance = -210; // tweak as needed
        const float movementDuration = 0.3f; // tweak as needed
        
        int movement = (up ? movementDistance : -movementDistance);
        
        [UIView beginAnimations: @"animateTextField" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
    }
    else if (textField==_txtEmail)
    {
        const int movementDistance = -230; // tweak as needed
        const float movementDuration = 0.3f; // tweak as needed
        
        int movement = (up ? movementDistance : -movementDistance);
        
        [UIView beginAnimations: @"animateTextField" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
    }
    
    else
    {
        
        const int movementDistance = -210; // tweak as needed
        const float movementDuration = 0.3f; // tweak as needed
        
        int movement = (up ? movementDistance : -movementDistance);
        
        [UIView beginAnimations: @"animateTextField" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
    }
}

- (IBAction)genderbuttClicked:(id)sender
{
    [self.txtgender resignFirstResponder];
    [self.view endEditing:YES];
     [_popView showInView:self.view];
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



@end
