//
//  TwitterViewController.m
//  GetUsHere For Rider
//
//  Created by bharat on 12/04/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "TwitterViewController.h"
#import "DejalActivityView.h"
#import "RiderData.h"
#import "RiderConformViewController.h"
#import "SWRevealViewController.h"
#import "GetUsHere.pch"

@interface TwitterViewController ()
{
    RiderData *Rdata;
}


@end

@implementation TwitterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   
                                   initWithTarget:self
                                   
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back.jpg"]];
    self.txtMobileNumber.delegate=self;
    self.txtCountryCode.delegate=self;
    self.txtEmailid.delegate=self;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[[self navigationController] navigationBar] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    self.navigationItem.title=@"REGISTRATION";
    checked = NO;
    _txtUserName.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"tname"];
 //   _txtEmailid.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"gmail"];
    
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:@"CCode" attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor] }];
    self.txtCountryCode.attributedPlaceholder = str1;
    
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:@"Phone no" attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor] }];
    self.txtMobileNumber.attributedPlaceholder = str2;
    
    NSAttributedString *str3 = [[NSAttributedString alloc] initWithString:@"Enter Email Id" attributes:@{ NSForegroundColorAttributeName : [UIColor purpleColor] }];
    self.txtEmailid.attributedPlaceholder = str3;
    
    self.txtUserName.textColor=[UIColor purpleColor];
    
    _fullView.layer.masksToBounds = YES;
    _fullView.layer.cornerRadius = 19.0;
    _fullView.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];
    
    _cccodeview.layer.masksToBounds = YES;
    _cccodeview.layer.cornerRadius = 19.0;
    _cccodeview.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];
    
    _phoneView.layer.masksToBounds = YES;
    _phoneView.layer.cornerRadius = 19.0;
    _phoneView.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];
    
    _emailView.layer.masksToBounds = YES;
    _emailView.layer.cornerRadius = 19.0;
    _emailView.backgroundColor=[UIColor colorWithRed:232.0/255.0f green:223.0/255.0f blue:228.0/255.0f alpha:1.0];
    
    _registerbutt.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
     _termLabel.textColor=[UIColor purpleColor];
      _plusLabel.textColor=[UIColor purpleColor];
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.tintColor=[UIColor whiteColor];
    numberToolbar.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    
    _txtMobileNumber.inputAccessoryView = numberToolbar;
    _txtCountryCode.inputAccessoryView=numberToolbar;
    [self.revealViewController.view removeGestureRecognizer:self.revealViewController.panGestureRecognizer];


}

-(void)doneWithNumberPad
{
    [_txtMobileNumber resignFirstResponder];
    [_txtCountryCode resignFirstResponder];
    
    
}

- (void)dismissKeyboard
{
    [self.txtMobileNumber resignFirstResponder];
    [self.txtCountryCode resignFirstResponder];
    [self.txtEmailid resignFirstResponder];
}


- (IBAction)CheckbookClicked:(id)sender
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


- (IBAction)RegisterClicked:(id)sender
{
    if(_txtMobileNumber.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Enter Your Mobile Number" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if(_txtCountryCode.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Enter Your Country Code" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if(_txtEmailid.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please Enter Email Number" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    else if (![self NSStringIsValidEmail:_txtEmailid.text])
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
        
        NSString *sre=[NSString stringWithFormat:@"+%@",_txtCountryCode.text];
        
        strCountryCodeMobile = [sre stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
        
        NSString *string = _txtEmailid.text;
        NSString *stremailid = [string stringByTrimmingCharactersInSet:
                                [NSCharacterSet whitespaceCharacterSet]];
        
        NSMutableString* profile = [NSMutableString string];
        
        [profile appendString:[NSString stringWithFormat:@"name=%@", _txtUserName.text]];
        [profile appendString:[NSString stringWithFormat:@"&ccode=%@", strCountryCodeMobile]];
        [profile appendString:[NSString stringWithFormat:@"&mobile_no=%@", _txtMobileNumber.text]];
        [profile appendString:[NSString stringWithFormat:@"&email=%@", stremailid]];
        [profile appendString:[NSString stringWithFormat:@"&fb_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"tid"]]];
        [profile appendString:[NSString stringWithFormat:@"&register_with=%@", @"twitter"]];
        [profile appendString:[NSString stringWithFormat:@"&user_type=%@", @"rider"]];
        [profile appendString:[NSString stringWithFormat:@"&os=%@", @"ios"]];
        [profile appendString:[NSString stringWithFormat:@"&device_id=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"devicetoken"]]];
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        [self PostdateToServerwithParameters:profile andApiExtension:@"register"];
    }
}


-(void)PostdateToServerwithParameters:(NSMutableString *)parameters andApiExtension:(NSString *)ext
{
    
    NSString *sre=[NSString stringWithFormat:@"+%@",_txtCountryCode.text];
    
    strCountryCodeMobile = [sre stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    
    NSString *string = _txtEmailid.text;
    NSString *stremailid = [string stringByTrimmingCharactersInSet:
                            [NSCharacterSet whitespaceCharacterSet]];
    
    NSString *post = [NSString stringWithFormat:@"name=%@&ccode=%@&mobile_no=%@&email=%@&fb_id=%@&register_with=%@&user_type=%@&os=%@&device_id=%@", _txtUserName.text, strCountryCodeMobile,_txtMobileNumber.text,stremailid,[[NSUserDefaults standardUserDefaults]objectForKey:@"tid"],@"twitter",@"rider",@"ios",[[NSUserDefaults standardUserDefaults]valueForKey:@"devicetoken"]];
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
    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,ext]]];
//    request.HTTPMethod = @"POST";
//    request.HTTPBody  = [parameters dataUsingEncoding:NSUTF8StringEncoding];
//    
//    [NSURLConnection sendAsynchronousRequest:request
//                                       queue:[NSOperationQueue mainQueue]
//                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//                               if (error) {
//                                   // Handle error
//                                   //[self handleError:error];
//                                   [DejalBezelActivityView removeViewAnimated:YES];
//                               } else {
//                                   [self parseJSONResponse:data];
//                                   [DejalBezelActivityView removeViewAnimated:YES];
//                               }
//                           }];
}


-(void)parseJSONResponse:(NSMutableDictionary*)responseData
{
    //  NSError *err;
    
    NSMutableDictionary *responseJSON = responseData;
    
  //  NSLog(@"*****login details ******* %@", responseJSON);
    
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
        
        [[NSUserDefaults standardUserDefaults]setObject:_txtMobileNumber.text forKey:@"phone"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:_txtEmailid.text forKey:@"email"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        RiderConformViewController *edit = [self.storyboard instantiateViewControllerWithIdentifier:@"RiderConformViewController"];
        UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
        [navController setViewControllers: @[edit] animated: NO ];
        [self.revealViewController setFrontViewController:navController animated:YES];
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
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
    const int movementDistance = -100; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
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
