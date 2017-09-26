//
//  ForgotPasswordViewController.m
//  GetUsHere For Rider
//
//  Created by bharat on 24/02/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "ViewController.h"
#import "DejalActivityView.h"
#import "GetUsHere.pch"
#import "SWRevealViewController.h"


@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back.jpg"]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   
                                   initWithTarget:self
                                   
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    self.title=@"Forgot Password";
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[[self navigationController] navigationBar] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    
    self.txtMobilenumber.delegate =self;
    self.txtCountryCode.delegate=self;
    
    NSAttributedString *str4 = [[NSAttributedString alloc] initWithString:@"CCode" attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor] }];
    self.txtCountryCode.attributedPlaceholder = str4;
      self.txtCountryCode.textColor=[UIColor purpleColor];
    
    NSAttributedString *str5 = [[NSAttributedString alloc] initWithString:@"Phone no" attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor] }];
    self.txtMobilenumber.attributedPlaceholder = str5;
      self.txtMobilenumber.textColor=[UIColor purpleColor];
    
    _plusLabel.textColor=[UIColor purpleColor];
    _noteLabel.textColor=[UIColor purpleColor];
    
    _sendbutt.layer.masksToBounds = YES;
    _sendbutt.layer.cornerRadius = 19.0;
    
    _cancelbutt.layer.masksToBounds = YES;
    _cancelbutt.layer.cornerRadius = 19.0;
    
    _ccodeView.layer.masksToBounds = YES;
    _ccodeView.layer.cornerRadius = 19.0;
    _ccodeView.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];
    
    _phoneView.layer.masksToBounds = YES;
    _phoneView.layer.cornerRadius = 19.0;
    _phoneView.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];
    
    _sendbutt.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _cancelbutt.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    [self.revealViewController.view removeGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
}

- (void)dismissKeyboard
{
    [self.txtMobilenumber resignFirstResponder];
    [self.txtCountryCode resignFirstResponder];
}

- (IBAction)CancelClicked:(id)sender
{
    ViewController *bookTax=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    [self.navigationController pushViewController:bookTax animated:YES];
}


- (IBAction)SendClicked:(id)sender
{
    
    if (_txtCountryCode.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"Please enter proper Country code" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (_txtMobilenumber.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"Please enter Reg Mobile Number" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        
        
        NSString *sre=[NSString stringWithFormat:@"+%@",_txtCountryCode.text];
        strCountryCodeMobile = [sre stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        [self next];
    }
}

-(void)next
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,forgotpassword]]];
    
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"ccode=%@", strCountryCodeMobile]];
    [profile appendString:[NSString stringWithFormat:@"&mobile_no=%@", _txtMobilenumber.text]];
    
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
    
 //   NSLog(@"*****Forgot password Details ******* %@", responseJSON);
    
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
        ViewController *bookTax=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        [self.navigationController pushViewController:bookTax animated:YES];
        
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

-(void)viewDidDisappear:(BOOL)animated{
    
    self.title = @"";
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.title = @"Forgot Password";
    
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
