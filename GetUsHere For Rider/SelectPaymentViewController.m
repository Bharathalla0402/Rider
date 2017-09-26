//
//  SelectPaymentViewController.m
//  GetUsHere For Rider
//
//  Created by bharat on 27/05/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "SelectPaymentViewController.h"
#import "StripeVcViewController.h"
#import "FinalpayconformViewController.h"
#import "GetUsHere.pch"
#import "SWRevealViewController.h"
#import "SplachscreenViewController.h"
#import "Reachability.h"
#import "PayPalPayment.h"
#import "PayPalMobile.h"
#import "RatingViewController.h"
#import "DejalActivityView.h"

#import <PayPal-iOS-SDK/PayPalMobile.h>
#import <PayPalPayment.h>
#import <CardIO/CardIO.h>
#import <CardIO.h>


#define PayPal_TEST_ClienKey @"AUFa3m-z0k6MKo1y7XqwTKLRKAu8U-daqnX0rLPwlaUIPqYnO3sjLLeaBOpJJH4EmbRPbbPVBZyL7wzt"
#define PayPal_LIVE_ClienKey @"Ae_mnK_jhfhghkjhkjhkjjhkjhkjkd1QKPg-ir6pAq26Mb787CP"
#define PayPal_LIVE_SecretKey @"Esfdfffdefgg46CT0VcHvZw9uoDIIQFtor6fd1QKPg-ir6pAq26Mb787CP"

#define kPayPalEnvironment PayPalEnvironmentNoNetwork

@interface SelectPaymentViewController ()<PayPalPaymentDelegate,CardIOPaymentViewControllerDelegate>
{
    NSData *confirmation;
    NSArray *paymentData;
    NSString *email,*fname,*lname,*userid,*tokenid;
    
    NSString *stramount,*strammount2,*strpaypalid;
}

//@property(nonatomic, strong) PayPalConfiguration *payPalConfig;
@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;
@property(nonatomic, retain) PayPalPayment *payment;
@end

@implementation SelectPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"Select Payment";
    
     paymentData = [[NSArray alloc]init];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.view.backgroundColor=[UIColor lightGrayColor];
    
    stramount=[[NSUserDefaults standardUserDefaults]objectForKey:@"totalfare"];
    strammount2=[stramount substringFromIndex:1];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"body_background2.png"]];
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
    
    _payPalConfig = [[PayPalConfiguration alloc] init];
    _payPalConfig.acceptCreditCards = YES;
    _payPalConfig.merchantName = @"More Movies";
    _payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
    _payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
    _payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    _payPalConfig.payPalShippingAddressOption = PayPalShippingAddressOptionNone;
    self.environment = kPayPalEnvironment;
    NSLog(@"PayPal iOS SDK version: %@", [PayPalMobile libraryVersion]);
}

- (IBAction)CashClicked:(id)sender
{
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,paymenttrip]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"trip_amt=%@", strammount2]];
    [profile appendString:[NSString stringWithFormat:@"&trip_id=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"tripid"]]];
    [profile appendString:[NSString stringWithFormat:@"&pymt_type=%@",@"cash"]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else {
                                   [self parseJSONResp1:data];
                               }
                           }];
    }

    
}

- (BOOL)acceptCreditCards
{
    return self.payPalConfig.acceptCreditCards;
}

- (void)setAcceptCreditCards:(BOOL)acceptCreditCards
{
    self.payPalConfig.acceptCreditCards = acceptCreditCards;
}


- (IBAction)PaywithpaypalClicked:(id)sender
{
    
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {
//      self.resultText = nil;
//    PayPalPayment *payment = [[PayPalPayment alloc] init];
//    payment.amount = [[NSDecimalNumber alloc] initWithString:strammount2];
//    payment.currencyCode = @"USD";
//    payment.shortDescription = @"HoppInRide Payment";
//    // Check whether payment is processable.
//    if (!payment.processable) {
//        
//    }
//    
//  //  For Live Account purpose
//    [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction : PayPal_LIVE_ClienKey,
//                                                           PayPalEnvironmentSandbox : PayPal_LIVE_SecretKey}];
//    
//    //For Test Account purpose
//    [PayPalMobile initializeWithClientIdsForEnvironments:@{
//                                                           PayPalEnvironmentSandbox : PayPal_TEST_ClienKey}];
//    
//#ifdef CONFIGURATION_ReleaseLive
//    [PayPalMobile preconnectWithEnvironment:PayPalEnvironmentProduction];
//#else
//    [PayPalMobile preconnectWithEnvironment:PayPalEnvironmentSandbox]; // PayPalEnvironmentSandbox ?
//#endif
//    
//    [self setPayPalConfig:[[PayPalConfiguration alloc] init]];
//    [[self payPalConfig] setAcceptCreditCards:YES];
//    [[self payPalConfig] setPayPalShippingAddressOption:PayPalShippingAddressOptionBoth];
//    
//    [[self payPalConfig] setLanguageOrLocale:[NSLocale preferredLanguages][0]];
//    // Create a PayPalPaymentViewController.
//    PayPalPaymentViewController *paymentViewController;
//    paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
//                                                                   configuration:_payPalConfig
//                                                                        delegate:self];
//    
//    // Present the PayPalPaymentViewController.
//    [self presentViewController:paymentViewController animated:YES completion:nil];
        
        
        
        self.resultText = nil;
        
        PayPalItem * item = [PayPalItem itemWithName:@"HoppInRide" withQuantity:1 withPrice:[NSDecimalNumber decimalNumberWithString:strammount2] withCurrency:@"USD" withSku:nil];
        NSArray *items = @[item];
        NSDecimalNumber *subtotal = [PayPalItem totalPriceForItems:items];
        PayPalPaymentDetails *paymentDetails = [PayPalPaymentDetails paymentDetailsWithSubtotal:subtotal withShipping:nil withTax:nil];
        PayPalPayment *payment = [[PayPalPayment alloc] init];
        payment.amount = subtotal;
        payment.currencyCode = @"USD";
        payment.shortDescription = @"HoppInRide Payment";
        payment.items = items;
        payment.paymentDetails = paymentDetails;
        if (!payment.processable)
        {
        }
        self.payPalConfig.acceptCreditCards = self.acceptCreditCards;
        
        PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment configuration:self.payPalConfig delegate:self];
        [self presentViewController:paymentViewController animated:YES completion:nil];
    }
}

#pragma mark
#pragma mark -- scanCreditCardBtnClicked

- (IBAction)scanCreditCardBtnClicked:(id)sender
{
    CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
    scanViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:scanViewController animated:YES completion:nil];
}

#pragma mark - CardIOPaymentViewControllerDelegate

- (void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)info inPaymentViewController:(CardIOPaymentViewController *)paymentViewController {
    NSLog(@"Scan succeeded with info: %@", info);
    // Do whatever needs to be done to deliver the purchased items.
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)paymentViewController
{
    NSLog(@"User cancelled scan");
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - PayPalPaymentDelegate methods
- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController
                 didCompletePayment:(PayPalPayment *)completedPayment
{
    self.resultText = [completedPayment description];
    NSLog(@"PayPal Payment Success!");
    // Payment was processed successfully; send to server for verification and fulfillment.
    [self verifyCompletedPayment:completedPayment];
    
    // Dismiss the PayPalPaymentViewController.
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController
{
    NSLog(@"PayPal Payment Canceled");
    self.resultText = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)verifyCompletedPayment:(PayPalPayment *)completedPayment {
    // Send the entire confirmation dictionary
    confirmation = [NSJSONSerialization dataWithJSONObject:completedPayment.confirmation
                                                   options:0
                                                     error:nil];
    paymentData = [completedPayment.confirmation valueForKey:@"response"];
    tokenid = [paymentData valueForKey:@"id"];
    //  [self setupPayment];
    NSLog(@"Here is your proof of payment:\n\n%@\n\nSend this to your server for confirmation and fulfillment.", completedPayment.confirmation);
    
    NSDictionary *arr=[[NSDictionary alloc]init];
    arr=completedPayment.confirmation;
    strpaypalid=[NSString stringWithFormat:@"%@",[[arr objectForKey:@"response"]objectForKey:@"id"]];
    NSLog(@"payment id:%@",strpaypalid);
    
    
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Please wait..."];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,paymentstatus]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"payment_id=%@", strpaypalid]];
    
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
    
  //  NSLog(@"***** Payment status ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        
        [DejalBezelActivityView removeView];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }
    
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:@"completed"])
    {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,paymenttrip]]];
        
        request.HTTPMethod = @"POST";
        
        NSMutableString* profile = [NSMutableString string];
        
        [profile appendString:[NSString stringWithFormat:@"trip_amt=%@", strammount2]];
        [profile appendString:[NSString stringWithFormat:@"&trip_id=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"tripid"]]];
        [profile appendString:[NSString stringWithFormat:@"&pymt_type=%@",@"paypal"]];
        [profile appendString:[NSString stringWithFormat:@"&payment_id=%@",strpaypalid]];
        
        request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   if (error) {
                                       // Handle error
                                       //[self handleError:error];
                                   } else {
                                       [self parseJSONResp1:data];
                                   }
                               }];

    }
}
-(void)parseJSONResp1:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
 //   NSLog(@"***** Payment Response ******* %@", responseJSON);
    
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


#pragma mark -
#pragma mark PayPalPaymentDelegate method

- (void)paymentFailedWithCorrelationID:(NSString *)correlationID andErrorCode:(NSString *)errorCode andErrorMessage:(NSString *)errorMessage
{
    [self showMessage:@"PAYMENTSTATUS_FAILED"
            withTitle:nil];
}

//- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
//    self.resultText = nil;
//    [self dismissViewControllerAnimated:YES completion:nil];
//  //  [self.navigationController popViewControllerAnimated:YES];
//}
//



-(void)showMessage:(NSString*)message withTitle:(NSString *)title{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:^{
        }];
    });
}






- (IBAction)paywithstripe:(id)sender
{
    [self checkNetworkStatus];
    
    if (_isInternetConnectionAvailable == NO)  {
        
        [self showMessage:@"It looks like You're not connected to the internet. Please check your settings and try again."
         
                withTitle:@"message"];
        
    }else
    {

    StripeVcViewController *strvc=[self.storyboard instantiateViewControllerWithIdentifier:@"StripeVcViewController"];
    [self.navigationController pushViewController:strvc animated:YES];
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidDisappear:(BOOL)animated
{
    
    self.title = @"";
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = YES;
    
}

- (void)setPayPalEnvironment:(NSString *)environment
{
    self.environment = environment;
    [PayPalMobile preconnectWithEnvironment:environment];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self setPayPalEnvironment:self.environment];
    self.title=@"Select Payment";
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
