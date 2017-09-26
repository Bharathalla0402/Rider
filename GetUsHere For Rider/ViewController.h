//
//  ViewController.h
//  GetUsHere For Rider
//
//  Created by bharat on 12/02/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SidebarViewController.h"
#import <GooglePlus/GooglePlus.h>
#import <GoogleOpenSource/GoogleOpenSource.h>
#import <TwitterKit/TwitterKit.h>



@class GPPSignIn;
@class GPPSignInButton;


@interface ViewController : UIViewController<UITextFieldDelegate,GPPSignInDelegate,UIImagePickerControllerDelegate,UIGestureRecognizerDelegate>
{
    NSMutableData *Mutabledata;
    NSMutableArray *name;
    BOOL checked;
    
    NSString *str;
    NSString *strNmae;
    NSString *riderid;
    NSString *strtotaltrips;
    NSString *strcancelltrips;
    NSString *mobile;
    
    NSString *strimage;
    
    NSMutableArray *arrname;
    
    NSString *strdevicetoken;
    NSString *deviceid;
    
    GPPSignIn *signIn;
    
    UIImage *Image_Google;
    
    NSString *First_Name_Google;
    
    NSString *Last_Name_Google;
    
    NSString *Email_Google;
    
    NSString *email;
    
    NSString *strtwitterid;
    
    NSMutableArray *arrdetails;
    
    
}

@property BOOL isInternetConnectionAvailable;

@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtPwd;

@property (weak, nonatomic) IBOutlet UIButton *loginbutt;
@property (weak, nonatomic) IBOutlet UIView *emailview;
@property (weak, nonatomic) IBOutlet UIView *passwordview;

@property (strong, nonatomic)NSString *str,*strNmae;
@property(nonatomic,retain) GTMOAuth2Authentication *auth;

@property (weak, nonatomic) IBOutlet UIButton *forgotbutt;

@property (weak, nonatomic) IBOutlet UILabel *orlabel;
@property (weak, nonatomic) IBOutlet UILabel *linelabel1;
@property (weak, nonatomic) IBOutlet UILabel *linelabel2;


@end

