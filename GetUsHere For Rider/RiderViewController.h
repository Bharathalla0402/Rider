//
//  RiderViewController.h
//  Jaguar Enterprises
//
//  Created by bharat on 22/01/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RiderConformViewController.h"
#import "FacebookViewController.h"
#import <GooglePlus/GooglePlus.h>
#import <GoogleOpenSource/GoogleOpenSource.h>


@class GPPSignIn;
@class GPPSignInButton;

@interface RiderViewController : UIViewController<UIAlertViewDelegate,NSURLConnectionDelegate,UITextFieldDelegate,GPPSignInDelegate,UIGestureRecognizerDelegate>
{
    NSMutableData *mdata;
    BOOL checked;
    IBOutlet UIButton *checkboxbutton1;
    IBOutlet UIScrollView *scrollView;
    
    NSString *strtwitterid;
    NSString *strtwername;
    
    NSString *strCountryCodeMobile;
    
    NSString *stremailid;
}
@property BOOL isInternetConnectionAvailable;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtReenter;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property(nonatomic,retain) GTMOAuth2Authentication *auth;
@property (weak, nonatomic) IBOutlet UITextField *txtgender;

@property (weak, nonatomic) IBOutlet UITextField *txtCountryCode;

@property (weak, nonatomic) IBOutlet UILabel *orlabel;
@property (weak, nonatomic) IBOutlet UILabel *linelabel1;
@property (weak, nonatomic) IBOutlet UILabel *linelabel2;

@property (weak, nonatomic) IBOutlet UIButton *registerbutt;

@property (weak, nonatomic) IBOutlet UIView *nameView;
@property (weak, nonatomic) IBOutlet UIView *passwordView;
@property (weak, nonatomic) IBOutlet UIView *reenterView;
@property (weak, nonatomic) IBOutlet UIView *genderView;
@property (weak, nonatomic) IBOutlet UIView *ccView;
@property (weak, nonatomic) IBOutlet UIView *numberView;
@property (weak, nonatomic) IBOutlet UIView *emailView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewlend;

@property (weak, nonatomic) IBOutlet UILabel *plusLabel;
@property (weak, nonatomic) IBOutlet UILabel *termLabel;


@end
