//
//  RiderConformViewController.h
//  Jaguar Enterprises
//
//  Created by bharat on 22/01/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RiderViewController.h"

@interface RiderConformViewController : UIViewController<NSURLConnectionDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    NSMutableData *mdata;
    
    NSString *str;
    NSString *strNmae;
    NSString *riderid;
    NSString *strtotaltrips;
    NSString *strcancelltrips;
    NSString *mobile;
    
    NSString *strimage;
    NSString *deviceid;
}
@property (weak, nonatomic) IBOutlet UIView *verifyCodeview;
@property (weak, nonatomic) IBOutlet UIButton *nextbutt;
@property (weak, nonatomic) IBOutlet UIButton *clickherebutt;

@property (weak, nonatomic) IBOutlet UILabel *resendlab;

@property (weak, nonatomic) IBOutlet UITextField *txtmobile;
@property (weak, nonatomic) IBOutlet UITextField *txtverifycode;
@property(nonatomic,retain) NSString *userid;
@property (weak, nonatomic) IBOutlet UILabel *txtnumber;
@end
