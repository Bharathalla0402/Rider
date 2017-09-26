//
//  ForgotPasswordViewController.h
//  GetUsHere For Rider
//
//  Created by bharat on 24/02/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPasswordViewController : UIViewController<UITextFieldDelegate>
{
     NSString *strCountryCodeMobile;
}
@property (weak, nonatomic) IBOutlet UITextField *txtMobilenumber;

@property (weak, nonatomic) IBOutlet UITextField *txtCountryCode;

@property (weak, nonatomic) IBOutlet UIButton *sendbutt;
@property (weak, nonatomic) IBOutlet UIButton *cancelbutt;

@property (weak, nonatomic) IBOutlet UIView *ccodeView;
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UILabel *plusLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;

@end
