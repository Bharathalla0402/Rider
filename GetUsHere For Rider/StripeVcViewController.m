//
//  StripeVcViewController.m
//  GetUsHere For Rider
//
//  Created by bharat on 27/05/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "StripeVcViewController.h"
#import "PaymentViewController.h"
#import "FinalpayconformViewController.h"
#import "GetUsHere.pch"
#import "DejalActivityView.h"
#import "SplachscreenViewController.h"
#import "SWRevealViewController.h"
#import "Reachability.h"
#import "RatingViewController.h"

#define STRIPE_TEST_POST_URL @"https://shopgt.com/iphonewebservices/paymentStripe.php?"

@interface StripeVcViewController ()

@end

@implementation StripeVcViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"Stripe Payment";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"body_background2.png"]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   
                                   initWithTarget:self
                                   
                                   action:@selector(dismissKeyboard)];
    
    
    
    [self.view addGestureRecognizer:tap];
    
    self.txtCardNumber.delegate=self;
    self.txtyear.delegate=self;
    self.txtCvvNumber.delegate=self;
    self.txtmonth.delegate=self;

    _paynowbutt.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    stramount=[[NSUserDefaults standardUserDefaults]objectForKey:@"totalfare"];
    strammount2=[stramount substringFromIndex:1];
    int value = [strammount2 intValue];
    int value2=100;
    int value3=value*value2;
    tripamount = [NSString stringWithFormat:@"%d", value3];
    _amountlabel.text=strammount2;
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.tintColor=[UIColor whiteColor];
    numberToolbar.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    
    _txtCardNumber.inputAccessoryView = numberToolbar;
    _txtCvvNumber.inputAccessoryView = numberToolbar;
    _txtyear.inputAccessoryView = numberToolbar;
    _txtmonth.inputAccessoryView = numberToolbar;
    
}

-(void)doneWithNumberPad
{
    [_txtCardNumber resignFirstResponder];
    [_txtCvvNumber resignFirstResponder];
    [_txtmonth resignFirstResponder];
    [_txtyear resignFirstResponder];
    
}


- (void)dismissKeyboard
{
    [self.txtCardNumber resignFirstResponder];
    [self.txtCardNumber resignFirstResponder];
    [self.txtmonth resignFirstResponder];
    [self.txtyear resignFirstResponder];
    
}

- (IBAction)paynowbuttClicked:(id)sender
{
    [self checkNetworkStatus];
   
    
    NSString *str1=_txtmonth.text;
    NSString *str2=_txtyear.text;
    
    int value1=[str1 intValue];
    int value2=[str2 intValue];
    
    if (_txtCardNumber.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"message" message:@"Please enter Valid card number" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (!(_txtCardNumber.text.length==16 || _txtCardNumber.text.length==19))
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"message" message:@"Please enter Valid card number" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (!(_txtCvvNumber.text.length==3))
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"message" message:@"Please enter valid CVV  number" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (!(_txtmonth.text.length==2))
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"message" message:@"Please enter Valid month" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (!(value1<13))
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"message" message:@"Please enter Valid month" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (value2<15)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"message" message:@"Please enter Valid year" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (!(_txtyear.text.length==2))
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"message" message:@"Please enter Valid year" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
    else if (_isInternetConnectionAvailable == NO)
    {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }
    else
    {
    _param = [[STPCardParams alloc]init];
    _param.number = _txtCardNumber.text;
    _param.cvc = _txtCvvNumber.text;
    _param.expMonth =[self.txtmonth.text integerValue];
    _param.expYear = [self.txtyear.text integerValue];
        
        self.view.userInteractionEnabled=NO;
         [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
    [self performStripeOperation];
    }
}

- (void)performStripeOperation
{
    [[STPAPIClient sharedClient] createTokenWithCard:_param
                                          completion:^(STPToken *token, NSError *error) {
                                              if (error) {
                                                  //[self handleError:error];
                                                  NSLog(@"ERRRRR = %@",error);
                                                  [self showMessage:error.localizedDescription
                                                          withTitle:@"Error"];
                                                  [DejalBezelActivityView removeView];
                                                  self.view.userInteractionEnabled=YES;
                                              } else {
                                                  NSLog(@"Current Sale Token :%@",token);
                                                  //when credit card details is correct code here
                                               //   [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
                                                  [self Invoicepayment:token];
                                                  
                                                  NSLog(@"Token Id: %@",token.tokenId);
                                              }
                                          }];
}



-(void)Invoicepayment:(STPToken *)token
{
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,paymenttrip]]];
        
    request.HTTPMethod = @"POST";
        
    NSMutableString* profile = [NSMutableString string];
    [profile appendString:[NSString stringWithFormat:@"trip_amt=%@", strammount2]];
    [profile appendString:[NSString stringWithFormat:@"&trip_id=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"tripid"]]];
    [profile appendString:[NSString stringWithFormat:@"&pymt_type=%@",@"strip"]];
    [profile appendString:[NSString stringWithFormat:@"&payment_id=%@",token.tokenId]];
        
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

-(void)parseJSONResp:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
  //  NSLog(@"***** Payment Response ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        RatingViewController *rate=[self.storyboard instantiateViewControllerWithIdentifier:@"RatingViewController"];
        [self.navigationController pushViewController:rate animated:YES];
    }
}



#pragma mark
#pragma mark -- UIAlertViewDelegate Method
-(void)showMessage:(NSString*)message withTitle:(NSString *)title
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //do something when click button
    }];
    [alert addAction:okAction];
    UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [vc presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated
{
    self.title = @"";
    self.view.userInteractionEnabled=YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.title=@"Stripe Payment";
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
