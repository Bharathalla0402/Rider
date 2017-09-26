//
//  RidereditViewController.m
//  Jaguar Enterprises
//
//  Created by bharat on 27/01/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "RidereditViewController.h"
#import "SidebarViewController.h"
#import "SWRevealViewController.h"
#import "DejalActivityView.h"
#import "UserInformation.h"
#import "Customcell2.h"
#import "GetUsHere.pch"
#import "DejalActivityView.h"
#import "SettingsViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIImageView+WebCache.h"
#import "SplachscreenViewController.h"

#import <PayPal-iOS-SDK/PayPalMobile.h>
#import <PayPalPayment.h>
#import <CardIO/CardIO.h>

#import "ChatVController.h"

#define PayPal_TEST_ClienKey @"AeEDIlSB8IzkYxBK0CYgouV6uE6ia22pEoMG5ZTxbd_uxxpOOFnL9H3Jq8g8HBi4MkcNdNshq0VY44O5"

#define PayPal_LIVE_ClienKey @"Ae_mnK_jhfhghkjhkjhkjjhkjhkjkd1QKPg-ir6pAq26Mb787CP" 
#define PayPal_LIVE_SecretKey @"Esfdfffdefgg46CT0VcHvZw9uoDIIQFtor6fd1QKPg-ir6pAq26Mb787CP"


@interface RidereditViewController ()
{
    NSData *confirmation;
    NSArray *paymentData;
    NSString *email,*fname,*lname,*userid,*tokenid;
    
    IBOutlet UIButton *editbutton;
    IBOutlet UIButton *cancel;
    IBOutlet UIButton *update;
    IBOutlet UIButton *deletebu;
    
    IBOutlet UITextField *lblname1;
    IBOutlet UITextField *txtnumber;
    
    IBOutlet UILabel *label5;
    
    UIImage *currentSelectedImage;
    
  //  UITextField *lblname1;
  //  UITextField *txtnumber;
    
    UITextField *lab;
    UITextField *lab1;
    
   // UILabel *label5;
    
  //  UIButton *editbutt;
  //  UIButton *cancel;
  //  UIButton *update;
  //  UIButton *deletebu;
    
    BOOL isClicked;
    Customcell2 *cell;
    Customcell2 *cell1;
    NSInteger selectedIndex;
    
    
    NSString *byteArray;
    NSMutableDictionary *imagedictionary;
    NSString *jsonString;
    UILabel *labcon;
    UIBarButtonItem *backButton2;
    BOOL isClicked2;
    
}
@property(nonatomic, strong) PayPalConfiguration *payPalConfig;
@property(nonatomic, retain) PayPalPayment *payment;
@end

@implementation RidereditViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"My Profile";
    
    selectedIndex = -1;
    isClicked = NO;
    isClicked2=YES;
    
  //  int tablcount=50;
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = NO;
    
   
    _txtcontact.delegate=self;
   // _txtemail.delegate=self;
    
    lblname1.delegate=self;
    txtnumber.delegate=self;
    
   // _contacttable.backgroundColor=[UIColor lightGrayColor];
   // self.view.backgroundColor=[UIColor lightGrayColor];
    
    self.view.backgroundColor =[UIColor colorWithRed:246.0/255.0f green:244.0/255.0f blue:245.0/255.0f alpha:1.0];
    _first.backgroundColor=[UIColor colorWithRed:120.0/255.0f green:65.0/255.0f blue:99.0/255.0f alpha:1.0];
    
    _pictureedit.hidden=YES;
    _contacttable.backgroundColor=[UIColor whiteColor];
    
    _personalindolab.textColor=[UIColor colorWithRed:52.0/255.0f green:150.0/255.0f blue:73.0/255.0f alpha:1.0];
    _lineLab.backgroundColor=[UIColor colorWithRed:52.0/255.0f green:150.0/255.0f blue:73.0/255.0f alpha:1.0];
    _linelab.backgroundColor=[UIColor colorWithRed:52.0/255.0f green:150.0/255.0f blue:73.0/255.0f alpha:1.0];
    
    _emergencycontactlab.textColor=[UIColor colorWithRed:52.0/255.0f green:150.0/255.0f blue:73.0/255.0f alpha:1.0];
    
    _addanother.layer.cornerRadius = 10;
    _addanother.clipsToBounds = YES;
    
    _addanother.backgroundColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    
    _third.backgroundColor=[UIColor whiteColor];
    
    
    
    _personalCancel.backgroundColor=[UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    
     _personalUpdate.backgroundColor=[UIColor colorWithRed:148.0/255.0f green:151.0/255.0f blue:149.0/255.0f alpha:1.0];
    
    
    //    _second.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"body_background2.png"]];
//    _third.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"body_background2.png"]];
//    _fourth.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"body_background2.png"]];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[[self navigationController] navigationBar] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"b" style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(barButtonBackPressed:)];
    [backButton setImage:[UIImage imageNamed:@"Untitled-1-2.png"]];
    
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    _imag.layer.cornerRadius = _imag.frame.size.height /2;
    _imag.layer.masksToBounds = YES;
    _imag.layer.borderWidth = 0;
    
    _imag.image=[UIImage imageNamed:@"profilepic.png"];
    _imag.hidden=NO;
 
    
    
    backButton2 = [[UIBarButtonItem alloc] initWithTitle:@"b" style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(barButtonBackPressed2:)];
    
    [backButton2 setImage:[UIImage imageNamed:@"menu-2.png"]];
    
    self.navigationItem.rightBarButtonItem = backButton2;
    self.navigationItem.rightBarButtonItem.enabled = YES;

    
    
    
//    self.imag.layer.cornerRadius = self.imag.frame.size.width / 2;
//    self.imag.clipsToBounds = YES;
    
    _personalCancel.hidden=YES;
    _personalUpdate.hidden=YES;
    _pictureImage.hidden=YES;
    
    
    imagedictionary=[[NSMutableDictionary alloc]init];
    
    
    _personalCancel.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _personalUpdate.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    _txtcontact.userInteractionEnabled=NO;
    _txtemail.userInteractionEnabled=NO;
    _txtName.userInteractionEnabled=NO;
    [_txtName setBorderStyle:UITextBorderStyleNone];
    
    _addanother.backgroundColor= [UIColor colorWithRed:120.0/255.0f green:65.0/255.0f blue:99.0/255.0f alpha:1.0];
    
    
   // _txtName.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
    
//    NSData *Decode=[[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
//    UserInformation *info = [NSKeyedUnarchiver unarchiveObjectWithData:Decode];
    [UIColor colorWithRed:246.0/255.0f green:244.0/255.0f blue:245.0/255.0f alpha:1.0];
    arrtripcounts=[[NSUserDefaults standardUserDefaults]objectForKey:@"tripdetail"];
    
    
    _lblname.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"named"];
    _txtName.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"named"];
    _lbltrip.text=[NSString stringWithFormat:@"%@",[arrtripcounts valueForKey:@"total_trip"]];
    _lblcancel.text=[NSString stringWithFormat:@"%@",[arrtripcounts valueForKey:@"canceled_trip"]];
    _lblcompleted.text=[NSString stringWithFormat:@"%@",[arrtripcounts valueForKey:@"completed_trip"]];
    _txtcontact.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"phone"];
    _txtemail.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"email"];
   
    
   // arrperDetails=[[NSMutableArray alloc]initWithObjects:info.MobileNumber,info.email, nil];
    
    arrContact=[[NSMutableArray alloc]init];
    arrname=[[NSMutableArray alloc]init];
    personaldetails=[[NSMutableArray alloc]init];
    arrid=[[NSMutableArray alloc]init];
    
    
   
    
    NSString *strurl=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"imag"]];
    
    if (![strurl isEqualToString:@""])
    {
        [_imag sd_setImageWithURL:[NSURL URLWithString:strurl]
                       placeholderImage:[UIImage imageNamed:@"profilepic.png"]];
    }

    [self.revealViewController.view removeGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,myprofileinfo]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else
                               {
                                   [self parseJSONR2:data];
                               }
                           }];
}



-(void)barButtonBackPressed:(id)sender
{
    SidebarViewController *side=[self.storyboard instantiateViewControllerWithIdentifier:@"SidebarViewController"];
    [self.navigationController pushViewController:side animated:YES];
}

-(void)barButtonBackPressed2:(id)sender
{
  //  self.navigationItem.rightBarButtonItem.enabled = NO;

    if (isClicked2==YES)
    {
    popview = [[UIView alloc]init];
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
    [btn1 setTitle:@"Settings" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [footerview addSubview:btn1];
        
    isClicked2=NO;
    }
    else
    {
        [footerview removeFromSuperview];
        popview.hidden = YES;
        isClicked2=YES;
    }
    
}

- (void)hideBtnTapped
{
    _personalCancel.hidden=NO;
    _personalUpdate.hidden=NO;
    _pictureImage.hidden=NO;
    _txtcontact.userInteractionEnabled=NO;
    _txtemail.userInteractionEnabled=NO;
    _txtName.userInteractionEnabled=NO;
    
    [footerview removeFromSuperview];
    popview.hidden = YES;
    
}

- (void)hideBtnTapped1
{
    
    self.view.userInteractionEnabled=NO;
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    SettingsViewController *stvc=[self.storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
    [self.navigationController pushViewController:stvc animated:YES];

}


- (IBAction)pictureEditClicked:(id)sender
{
    _personalCancel.hidden=NO;
    _personalUpdate.hidden=NO;
    _pictureImage.hidden=NO;
    _txtcontact.userInteractionEnabled=NO;
    _txtemail.userInteractionEnabled=NO;
    _txtName.userInteractionEnabled=NO;
}

- (IBAction)PersonalCancelClicked:(id)sender
{
    _pictureImage.hidden=YES;
    _personalCancel.hidden=YES;
    _personalUpdate.hidden=YES;
    _txtcontact.userInteractionEnabled=NO;
    _txtemail.userInteractionEnabled=NO;
    _txtName.userInteractionEnabled=NO;
    self.navigationItem.rightBarButtonItem.enabled = YES;
    isClicked2=YES;
}



- (IBAction)PersonalUpdateClicked:(id)sender
{
    self.view.userInteractionEnabled=NO;
   self.navigationItem.rightBarButtonItem.enabled = YES;
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    //Set Params
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:60];
    [request setHTTPMethod:@"POST"];
    
    //Create boundary, it can be anything
    NSString *boundary = @"------VohpleBoundary4QuqLuM1cE5lMwCy";
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    //Populate a dictionary with all the regular values you would like to send.
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    
    [parameters setValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ] forKey:@"user_id"];
    
    [parameters setValue:_lblname.text forKey:@"name"];
    
    [parameters setValue:_txtemail.text forKey:@"email"];
    
    [parameters setValue:@"Image.jpg" forKey:@"image_name"];
    
   // [parameters setValue:byteArray forKey:@"image"];
    
    
    // add params (all params are strings)
    for (NSString *param in parameters)
    {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [parameters objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    NSString *FileParamConstant = @"image";
    
    NSData *imageData = UIImageJPEGRepresentation(currentSelectedImage, 1);
    
    //Assuming data is not nil we add this to the multipart form
    if (imageData)
    {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", FileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type:image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    //Close off the request with the boundary
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the request
    [request setHTTPBody:body];
    
    NSString *strRegurl=[NSString stringWithFormat:@"%@%@",BaseUrl,editprofile];
    
    // set URL
    [request setURL:[NSURL URLWithString:strRegurl]];
    

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
    {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else
                               {
                                   [self parseJSONR:data];
                               }
    }];

}

-(void)parseJSONR:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
 //   NSLog(@"***** Edit profile Update details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
        self.view.userInteractionEnabled=YES;
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        _pictureImage.hidden=YES;
        _personalCancel.hidden=YES;
        _personalUpdate.hidden=YES;
        _txtcontact.userInteractionEnabled=NO;
        _txtemail.userInteractionEnabled=NO;
        _txtName.userInteractionEnabled=NO;
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,myprofileinfo]]];
        
        request.HTTPMethod = @"POST";
        
        NSMutableString* profile = [NSMutableString string];
        
        [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
        
        request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   if (error) {
                                       // Handle error
                                       //[self handleError:error];
                                   } else
                                   {
                                       [self parseJSONR2:data];
                                   }
                               }];

        
    }
}
-(void)parseJSONR2:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
  //  NSLog(@"***** profile details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
        self.view.userInteractionEnabled=YES;
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
        self.view.userInteractionEnabled=YES;
        personaldetails=[responseJSON valueForKey:@"data"];
        _lblname.text=[personaldetails valueForKey:@"name"];
        _txtcontact.text=[personaldetails valueForKey:@"mobile_no"];
        _txtemail.text=[personaldetails valueForKey:@"email"];
        
        NSString *str=[personaldetails valueForKey:@"image"];
        [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"imag"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        arrname=[[personaldetails valueForKey:@"contacts"]valueForKey:@"name"];
        arrContact=[[personaldetails valueForKey:@"contacts"]valueForKey:@"contact_no"];
        NSMutableArray *arrcou=[[NSMutableArray alloc]init];
        arrcou=[personaldetails valueForKey:@"contacts"];
        NSString *strcoun=[NSString stringWithFormat:@"%lu",(unsigned long)arrcou.count];
        arrid=[[personaldetails valueForKey:@"contacts"]valueForKey:@"id"];
        
        NSString *strurl=[NSString stringWithFormat:@"%@",[personaldetails valueForKey:@"image"]];
        [_imag sd_setImageWithURL:[NSURL URLWithString:strurl]
                 placeholderImage:[UIImage imageNamed:@"profilepic.png"]];
        
        
       
        if ([strcoun isEqualToString:@"0"])
        {
          _contacttable.hidden=YES;
            labcon=[[UILabel alloc] initWithFrame:CGRectMake(_third.frame.size.width/2-50, _third.frame.size.height/2-20, 100, 40)];
            labcon.text=@"No Contacts";
            labcon.textColor=[UIColor purpleColor];
            [_third addSubview:labcon];
        }
        else
        {
            _contacttable.hidden=NO;
            labcon.hidden=YES;
        }
       
         [_contacttable updateConstraints];
         [_contacttable reloadData];
    }
}





- (IBAction)PictureClicked:(id)sender
{
    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:@"Photo capturing" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take a Photo",@"Select a photo from gallery", nil];
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
    imagePicker.delegate=self;
    if(buttonIndex==0)
    {
        @try {
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
            {
                UIDevice *device = [UIDevice currentDevice];
                NSString *currDevice = [device model];
                if(![currDevice isEqualToString:@"iPhone Simulator"])
                {
                    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
                    
                    UIImagePickerController *imgPickerCon = [[UIImagePickerController alloc] init];
                    imgPickerCon.sourceType = UIImagePickerControllerSourceTypeCamera;
                    imgPickerCon.delegate = self;
                    imgPickerCon.allowsEditing =  YES;
                    [self presentViewController:imgPickerCon animated:YES completion:nil];
                    
                    imgPickerCon = nil;
                }
                else
                {
                    UIAlertView *alrt=[[UIAlertView alloc] initWithTitle:@"Not Valid" message:@"Camera Not available" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [alrt show];
                }
            }
            else
            {
                UIAlertView *alrt=[[UIAlertView alloc] initWithTitle:@"Not Valid" message:@"Camera Not available" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alrt show];
            }
            
            
        }
        @catch (NSException *exception) {
            NSLog(@"Catch:%@",[exception description]);
            NSLog(@"Catch:%@",[exception reason]);
        }
        @finally {
            
        }
        
    }
    else if(buttonIndex==1)
    {
        imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    else if(buttonIndex==2)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}


#pragma mark
#pragma mark -- Reduce Image Size

-(UIImage*)imageWithReduceImage: (UIImage*)imageName scaleToSize: (CGSize)newsize
{
    UIGraphicsBeginImageContextWithOptions(newsize, NO, 12.0);
    [imageName drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    return newImage;
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)myimage editingInfo:(NSDictionary *)editingInfo
{
    _imag.image=myimage;
    currentSelectedImage=myimage;
//    currentSelectedImage = [self imageWithReduceImage:myimage
//                                                   scaleToSize:CGSizeMake(20, 20)];
//    NSData *imageData = UIImageJPEGRepresentation(currentSelectedImage, 0.5);
//    NSLog(@"Size of image = %u KB",(imageData.length/1024));
//
//    byteArray = [UIImagePNGRepresentation(currentSelectedImage) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//    NSData *data=[byteArray dataUsingEncoding:NSUTF8StringEncoding];
//    base64Encoded = [data base64EncodedStringWithOptions:0];
    
     [self dismissViewControllerAnimated:YES completion:nil];
}




- (IBAction)addanotherContactClicked:(id)sender
{
    
    popview = [[ UIView alloc]init];
    popview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    //  popview.backgroundColor = [UIColor clearColor];
    popview.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_strip1.png"]];
    
    [self.view addSubview:popview];
    
    footerview=[[UIView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height/2-10, self.view.frame.size.width-20, 130)];
    //footerview.backgroundColor=[UIColor blackColor];
    footerview.backgroundColor = [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    [popview addSubview:footerview];
    
    lab=[[UITextField alloc]initWithFrame:CGRectMake(10, 10, footerview.frame.size.width-20, 30)];
    lab.placeholder=@"Type the Name of the Contact Number";
    lab.backgroundColor=[UIColor whiteColor];
    lab.textColor=[UIColor blackColor];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font=[UIFont systemFontOfSize:13];
    [footerview addSubview:lab];
    
    lab1=[[UITextField alloc]initWithFrame:CGRectMake(10, 50, footerview.frame.size.width-20, 30)];
    lab1.placeholder=@"Type the Contact Number";
    lab1.backgroundColor=[UIColor whiteColor];
    lab1.textColor=[UIColor blackColor];
    lab1.textAlignment=NSTextAlignmentCenter;
    lab1.font=[UIFont systemFontOfSize:13];
    [footerview addSubview:lab1];
    
    UIButton *cancelbutt=[[UIButton alloc]initWithFrame:CGRectMake(5, 90, footerview.frame.size.width/2-5, 30)];
    cancelbutt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    [cancelbutt  setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelbutt addTarget:self action:@selector(cancelclicked) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:cancelbutt];
    
    UIButton *add=[[UIButton alloc]initWithFrame:CGRectMake(cancelbutt.frame.size.width+10, 90, footerview.frame.size.width/2-10, 30)];
    add.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    [add  setTitle:@"Add" forState:UIControlStateNormal];
    [add addTarget:self action:@selector(addclicked) forControlEvents:UIControlEventTouchUpInside];
    [footerview addSubview:add];
    
    
    lab.delegate=self;
    lab1.delegate=self;
}

-(void)cancelclicked
{
    [footerview removeFromSuperview];
     popview.hidden = YES;
}
-(void)addclicked
{

    if (lab.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please Enter the Name of the Contact Number" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (lab1.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please Enter Contact Number" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,addemergencycontact]]];
        
        request.HTTPMethod = @"POST";
        
        NSMutableString* profile = [NSMutableString string];
        
        [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
        [profile appendString:[NSString stringWithFormat:@"&name=%@",lab.text]];
        [profile appendString:[NSString stringWithFormat:@"&contact_no=%@",lab1.text]];
        
        request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   if (error) {
                                       // Handle error
                                       //[self handleError:error];
                                   } else
                                   {
                                       [self parseJSONR3:data];
                                   }
                               }];
        
    }
}


-(void)parseJSONR3:(NSData*)responseData
{
    NSError *err;
    
    NSMutableDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&err];
    
    NSLog(@"***** Emergency contact details ******* %@", responseJSON);
    
    NSString *status = [responseJSON valueForKey:@"status"];
    
    [DejalBezelActivityView removeView];
    
    if ([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"0"]])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[responseJSON valueForKey:@"message"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else if([[NSString stringWithFormat:@"%@",status] isEqualToString:[NSString stringWithFormat:@"1"]])
    {
//        [arrname addObject:lab.text];
//        [arrContact addObject:lab1.text];
        
        [footerview removeFromSuperview];
        popview.hidden = YES;
        _contacttable.hidden=NO;
        labcon.hidden=NO;
        
        
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,myprofileinfo]]];
        
        request.HTTPMethod = @"POST";
        
        NSMutableString* profile = [NSMutableString string];
        
        [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
        
        request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   if (error) {
                                       // Handle error
                                       //[self handleError:error];
                                   } else
                                   {
                                       [self parseJSONR2:data];
                                   }
                               }];

    }
}




-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isClicked && indexPath.row == selectedIndex){
        return 100.0;
    }
    else {
        return 50.0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrContact.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellClassName = @"Customcell2";
    
    cell = (Customcell2 *)[tableView dequeueReusableCellWithIdentifier: CellClassName];
    
    if (cell == nil)
    {
        cell = [[Customcell2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellClassName];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Customcell2"
                                                     owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
        
    }
    
    lblname1=(UITextField *)[cell viewWithTag:1];
    txtnumber=(UITextField *)[cell viewWithTag:2];
    editbutton=(UIButton *)[cell viewWithTag:3];
    cancel=(UIButton *)[cell viewWithTag:4];
    update=(UIButton *)[cell viewWithTag:5];
    deletebu=(UIButton *)[cell viewWithTag:6];
    label5=(UILabel *)[cell viewWithTag:8];
    
    label5.hidden=YES;
   
    [lblname1 setBorderStyle:UITextBorderStyleNone];
    [txtnumber setBorderStyle:UITextBorderStyleNone];
    
    cancel.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    update.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    deletebu.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    lblname1.text=[arrname objectAtIndex:indexPath.row];
    txtnumber.text=[arrContact objectAtIndex:indexPath.row];
    label5.text=[arrid objectAtIndex:indexPath.row];
    
    lblname1.userInteractionEnabled=YES;
    txtnumber.userInteractionEnabled=YES;
    
    
    
    lblname1.delegate=self;
    txtnumber.delegate=self;
    
    lblname1.tag=indexPath.row;
    txtnumber.tag=indexPath.row;
    label5.tag=indexPath.row;
    
    editbutton.tag=indexPath.row;
    cancel.tag=indexPath.row;
    update.tag=indexPath.row;
    deletebu.tag=indexPath.row;
    
    
    [editbutton addTarget:self action:@selector(editclicked:) forControlEvents:UIControlEventTouchUpInside];
    [cancel addTarget:self action:@selector(cancelCli:) forControlEvents:UIControlEventTouchUpInside];
    [update addTarget:self action:@selector(updateClick:) forControlEvents:UIControlEventTouchUpInside];
    [deletebu addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (isClicked && indexPath.row == selectedIndex)
    {
        lblname1.userInteractionEnabled=YES;
        txtnumber.userInteractionEnabled=YES;
        editbutton.hidden=YES;
        cancel.hidden=NO;
        update.hidden=NO;
        deletebu.hidden=NO;
        
    }else
    {
        lblname1.userInteractionEnabled=NO;
        txtnumber.userInteractionEnabled=NO;
        editbutton.hidden=NO;
        cancel.hidden=YES;
        update.hidden=YES;
        deletebu.hidden=YES;
    }
    
    return  cell;
}


-(void)editclicked:(id)sender
{
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero
                                           toView:self.contacttable];
    NSIndexPath *tappedIP = [self.contacttable indexPathForRowAtPoint:buttonPosition];
    
    cell1 = [self.contacttable cellForRowAtIndexPath: tappedIP];
    cell1.editbutton.tag = tappedIP.row;
    cell1.lblname1.tag=tappedIP.row;
    cell1.txtnumber.tag=tappedIP.row;
    
    
    isClicked = !isClicked;
    selectedIndex = tappedIP.row;
    
    
    
    if (isClicked)
    {
        lblname1.userInteractionEnabled=YES;
        txtnumber.userInteractionEnabled=YES;
        editbutton.hidden=YES;
        cancel.hidden=NO;
        update.hidden=NO;
        deletebu.hidden=NO;
    }
    else
    {
        lblname1.userInteractionEnabled=NO;
        txtnumber.userInteractionEnabled=NO;
        editbutton.hidden=NO;
        cancel.hidden=YES;
        update.hidden=YES;
        deletebu.hidden=YES;
    }
    
    
    [self.contacttable reloadData];
}

-(void)cancelCli:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero
                                           toView:self.contacttable];
    NSIndexPath *tappedIP = [self.contacttable indexPathForRowAtPoint:buttonPosition];
    
    cell1 = [self.contacttable cellForRowAtIndexPath: tappedIP];
    cell1.cancel.tag = tappedIP.row;
    
    isClicked = NO;
    selectedIndex = tappedIP.row;
    
    [self.contacttable reloadData];
}

-(void)updateClick:(id)sender
{
   
    CGPoint buttonPosition = [sender convertPoint:CGPointZero
                                           toView:self.contacttable];
    NSIndexPath *tappedIP = [self.contacttable indexPathForRowAtPoint:buttonPosition];
    
    cell1 = [self.contacttable cellForRowAtIndexPath: tappedIP];
    cell1.update.tag = tappedIP.row;
    
    cell1.lblname1.tag=tappedIP.row;
    cell1.txtnumber.tag=tappedIP.row;
    cell1.label5.tag=tappedIP.row;
    
//    [arrname replaceObjectAtIndex:tappedIP.row withObject:lblname1.text];
//    [arrContact replaceObjectAtIndex:tappedIP.row withObject:txtnumber.text];
    
    isClicked = NO;
    selectedIndex = tappedIP.row;
    
    
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,updateemergencycontact]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"user_id=%@", [[NSUserDefaults standardUserDefaults]objectForKey:@"rid" ]]];
    [profile appendString:[NSString stringWithFormat:@"&name=%@",lblname1.text]];
    [profile appendString:[NSString stringWithFormat:@"&contact_no=%@",txtnumber.text]];
    [profile appendString:[NSString stringWithFormat:@"&contact_id=%@",label5.text]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else
                               {
                                   [self parseJSONR:data];
                               }
                           }];

    
   // [self.contacttable reloadData];
}

-(void)deleteClick:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero
                                           toView:self.contacttable];
    NSIndexPath *tappedIP = [self.contacttable indexPathForRowAtPoint:buttonPosition];
    
    cell1 = [self.contacttable cellForRowAtIndexPath: tappedIP];
    
//    [arrname removeObjectAtIndex:tappedIP.row];
//    [arrContact removeObjectAtIndex:tappedIP.row];
 //   [_contacttable deleteRowsAtIndexPaths:[NSArray arrayWithObject:tappedIP] withRowAnimation:UITableViewRowAnimationFade];
    cell1.deletebu.tag = tappedIP.row;
    
    cell1.lblname1.tag=tappedIP.row;
    cell1.txtnumber.tag=tappedIP.row;
    cell1.label5.tag=tappedIP.row;
    
    isClicked = NO;
    selectedIndex = tappedIP.row;
    
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"please wait..."];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,deleteemergencycontacy]]];
    
    request.HTTPMethod = @"POST";
    
    NSMutableString* profile = [NSMutableString string];
    
    [profile appendString:[NSString stringWithFormat:@"contact_id=%@",label5.text]];
    
    request.HTTPBody  = [profile dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   // Handle error
                                   //[self handleError:error];
                               } else
                               {
                                   [self parseJSONR:data];
                               }
                           }];


    
    
    
 //   [self.contacttable reloadData];
}


#pragma mark
#pragma mark -- TextfieldDelegate


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
    const int movementDistance = -165; // tweak as needed
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
    
    SWRevealViewController *reveal = self.revealViewController;
    reveal.panGestureRecognizer.enabled = YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return NO;
}

-(void)viewWillAppear:(BOOL)animated
{
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










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
