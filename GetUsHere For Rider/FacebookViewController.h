//
//  FacebookViewController.h
//  GetUsHere For Rider
//
//  Created by bharat on 17/02/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RiderViewController.h"

@interface FacebookViewController : UIViewController<UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    BOOL checked;
    IBOutlet UIButton *checkboxbutton1;
    
    NSString *strCountryCodeMobile;

}
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtMobileNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtEmailid;


@property (weak, nonatomic) IBOutlet UITextField *txtCountryCode;

@property (weak, nonatomic) IBOutlet UIView *fullView;
@property (weak, nonatomic) IBOutlet UIView *cccodeview;
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UIView *emailView;
@property (weak, nonatomic) IBOutlet UIButton *registerbutt;

@property (weak, nonatomic) IBOutlet UILabel *termLabel;
@property (weak, nonatomic) IBOutlet UILabel *plusLabel;

@end
