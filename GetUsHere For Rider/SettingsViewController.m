//
//  SettingsViewController.m
//  GetUsHere For Rider
//
//  Created by bharat on 26/02/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "SettingsViewController.h"
#import "SidebarViewController.h"
#import "UserInformation.h"
#import "DejalActivityView.h"
#import "Alertview.h"
#import "GetUsHere.pch"
#import "SplachscreenViewController.h"

@interface SettingsViewController ()
{
    BOOL isClicked;
}

@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _thirdView.hidden=YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   
                                   initWithTarget:self
                                   
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    self.txtnewpass.delegate=self;
    self.txtEmail.delegate=self;
    self.txtCurrentpass.delegate=self;
    self.txtcomformnewpass.delegate=self;
    
    isClicked=YES;
    [self.revealViewController.view removeGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    _DoneClick.hidden=YES;
    _CancelClick.hidden=YES;
    _bottomlab.backgroundColor=[UIColor clearColor];
    _txtCurrentpass.userInteractionEnabled=NO;
    _txtnewpass.userInteractionEnabled=NO;
    _txtcomformnewpass.userInteractionEnabled=NO;
    _txtEmail.userInteractionEnabled=NO;
    _SwichCheck.userInteractionEnabled=NO;
    
   
    _emaillab.textColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _firstLab.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _passwordlab.textColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _secondlab1.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _notificationlab.textColor =[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _notifylab4.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"b" style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(barButtonBackPressed:)];
    [backButton setImage:[UIImage imageNamed:@"Untitled-1-2.png"]];
    
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    NSData *Decode=[[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
    UserInformation *info = [NSKeyedUnarchiver unarchiveObjectWithData:Decode];
    
    strid=info.userid;
    NSLog(@"%@",strid);
    NSString *str1=@"ON";
    _txtlab.text=str1;
    
    self.navigationItem.title=@"My Settings";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
   // self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back.jpg"]];
     self.view.backgroundColor =[UIColor colorWithRed:246.0/255.0f green:244.0/255.0f blue:245.0/255.0f alpha:1.0];
    
    _firstView.backgroundColor= [UIColor whiteColor];
    _secondView.backgroundColor=[UIColor whiteColor];
    _thirdView.backgroundColor=[UIColor whiteColor];
    
    _DoneClick.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    _CancelClick.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    backButton2 = [[UIBarButtonItem alloc] initWithTitle:@"b" style:UIBarButtonItemStylePlain target:self
                                                  action:@selector(barButtonBackPressed2:)];
    
    [backButton2 setImage:[UIImage imageNamed:@"menu-2.png"]];
    
    self.navigationItem.rightBarButtonItem = backButton2;
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    _CancelClick.userInteractionEnabled=YES;
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
    
    
}


-(void)barButtonBackPressed:(id)sender
{
    
    SidebarViewController *side=[self.storyboard instantiateViewControllerWithIdentifier:@"SidebarViewController"];
    [self.navigationController pushViewController:side animated:YES];
}


-(void)barButtonBackPressed2:(id)sender
{
    
    if (isClicked==YES)
    {
        // self.navigationItem.rightBarButtonItem.enabled = NO;
        
        popview = [[ UIView alloc]init];
        popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        //  popview.backgroundColor = [UIColor clearColor];
        popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
        
        [self.view addSubview:popview];
        
        footerview=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-120, 60, 120, 100)];
        footerview.backgroundColor=[UIColor whiteColor];
        [popview addSubview:footerview];
        
        UIButton *btn =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, footerview.frame.size.width, footerview.frame.size.height/2-2)];
        [btn addTarget:self action:@selector(hideBtnTapped) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"Edit" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [footerview addSubview:btn];
        
        UILabel *la1=[[UILabel alloc]initWithFrame:CGRectMake(0, 49, footerview.frame.size.width, 2)];
        [la1 setBackgroundColor:[UIColor lightGrayColor]];
        [footerview addSubview:la1];
        
        UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 51, footerview.frame.size.width, footerview.frame.size.height/2+1)];
        [btn1 addTarget:self action:@selector(hideBtnTapped1) forControlEvents:UIControlEventTouchUpInside];
        [btn1 setTitle:@"Logout" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [footerview addSubview:btn1];
        
        isClicked=NO;
    }
    else
    {
        [footerview removeFromSuperview];
        popview.hidden = YES;
        isClicked=YES;
    }
    
 
}

- (void)dismissKeyboard
{
     [self.txtEmail resignFirstResponder];
     [self.txtCurrentpass resignFirstResponder];
     [self.txtcomformnewpass resignFirstResponder];
     [self.txtnewpass resignFirstResponder];
}

- (void)hideBtnTapped
{
    
    _DoneClick.hidden=NO;
    _CancelClick.hidden=NO;
    
    _txtCurrentpass.userInteractionEnabled=YES;
    _txtnewpass.userInteractionEnabled=YES;
    _txtcomformnewpass.userInteractionEnabled=YES;
    _txtEmail.userInteractionEnabled=YES;
    _SwichCheck.userInteractionEnabled=YES;
    
    [footerview removeFromSuperview];
    popview.hidden = YES;
    
}

- (void)hideBtnTapped1
{
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"Are You Sure Want to Logout" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Signout", nil];
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [alertView firstOtherButtonIndex])
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Login"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
        
        SplachscreenViewController *edit = [self.storyboard instantiateViewControllerWithIdentifier:@"SplachscreenViewController"];
        UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
        [navController setViewControllers: @[edit] animated: NO ];
        [self.revealViewController setFrontViewController:navController animated:YES];
    }
}


- (IBAction)SwitchChanged:(id)sender
{
    if(_SwichCheck.isOn==YES)
    {
        NSString *str1=@"on";
        _txtlab.text=str1;
    }
    else if(_SwichCheck.isOn==NO)
    {
        NSString *str2=@"off";
        _txtlab.text=str2;
    }
}


- (IBAction)DoneClicked:(id)sender
{
    if (![_txtnewpass.text isEqualToString:_txtcomformnewpass.text])
    {
        if ([_txtCurrentpass.text isEqualToString:@""])
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please Enter Current Password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Re-enter New password is not matching" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }

    }
    else if (![self NSStringIsValidEmail:_txtEmail.text])
    {
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please Enter Valid Email Id" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
      
        [alert show];
       
    }
    else
    {
        
        NSString *string = _txtEmail.text;
        stremailid = [string stringByTrimmingCharactersInSet:
                      [NSCharacterSet whitespaceCharacterSet]];
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        [self next];
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
-(void)next
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,userSettings]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"user_id=%@", strid]];
    [profile appendString:[NSString stringWithFormat:@"&email=%@", stremailid]];
    [profile appendString:[NSString stringWithFormat:@"&notification=%@", self.txtlab.text]];
    [profile appendString:[NSString stringWithFormat:@"&old_password=%@", self.txtCurrentpass.text]];
    [profile appendString:[NSString stringWithFormat:@"&password=%@", self.txtnewpass.text]];
    
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
    
 //   NSLog(@"*****Update details ******* %@", responseJSON);
    
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
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"message" message:@"Account Updated Successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    
        SidebarViewController *bookTax=[self.storyboard instantiateViewControllerWithIdentifier:@"SidebarViewController"];
        [self.navigationController pushViewController:bookTax animated:YES];
    }
    
    
}

- (IBAction)CancelClicked:(id)sender
{
    _DoneClick.hidden=YES;
    _CancelClick.hidden=YES;
    _txtCurrentpass.userInteractionEnabled=NO;
    _txtnewpass.userInteractionEnabled=NO;
    _txtcomformnewpass.userInteractionEnabled=NO;
    _txtEmail.userInteractionEnabled=NO;
    _SwichCheck.userInteractionEnabled=NO;
    
     _txtEmail.text=str;
    
    _txtCurrentpass.text=@"";
    _txtnewpass.text=@"";
    _txtcomformnewpass.text=@"";
    isClicked=YES;
}


-(void)viewWillAppear:(BOOL)animated
{
 //  self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    str=[[NSUserDefaults standardUserDefaults]valueForKey:@"email"];
  //  NSLog(@"%@",str);
    
    _txtEmail.text=str;
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
    if (textField==_txtEmail)
    {
        const int movementDistance = -2; // tweak as needed
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
        const int movementDistance = -100; // tweak as needed
        const float movementDuration = 0.3f; // tweak as needed
        
        int movement = (up ? movementDistance : -movementDistance);
        
        [UIView beginAnimations: @"animateTextField" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
    }
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
  //  self.navigationController.interactivePopGestureRecognizer.enabled = NO;

    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    
    [self.revealViewController.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer isEqual:self.navigationController.interactivePopGestureRecognizer]) {
        
        return NO;
        
    } else {
        
        return YES;
        
    }
}
- (void)didReceiveMemoryWarning
{
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
