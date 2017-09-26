//
//  StripeVcViewController.h
//  GetUsHere For Rider
//
//  Created by bharat on 27/05/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Stripe/Stripe.h>

@interface StripeVcViewController : UIViewController<STPPaymentCardTextFieldDelegate,UIAlertViewDelegate,UITextFieldDelegate>
{
    
    NSString *stramount,*strammount2;
    NSString *tripamount;
}

@property (weak, nonatomic) IBOutlet UILabel *amountlabel;
@property BOOL isInternetConnectionAvailable;

@property (weak, nonatomic) IBOutlet UITextField *txtCardNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtCvvNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtmonth;
@property (weak, nonatomic) IBOutlet UITextField *txtyear;

@property (weak, nonatomic) IBOutlet UIButton *paynowbutt;

@property (strong, nonatomic) STPCardParams* param;
@property(nonatomic) STPPaymentCardTextField *paymentTextField;
@property NSString *amountStr,*invoice;


@end
