//
//  SettingsViewController.h
//  GetUsHere For Rider
//
//  Created by bharat on 26/02/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate>
{
    NSString *str;
    NSString *strid;
    UIView *popview,*footerview;
    UIBarButtonItem *backButton2;
    NSString *stremailid;
}
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtCurrentpass;
@property (weak, nonatomic) IBOutlet UITextField *txtnewpass;
@property (weak, nonatomic) IBOutlet UITextField *txtcomformnewpass;
@property (weak, nonatomic) IBOutlet UILabel *txtlab;
@property (weak, nonatomic) IBOutlet UISwitch *SwichCheck;

@property (weak, nonatomic) IBOutlet UIButton *DoneClick;
@property (weak, nonatomic) IBOutlet UIButton *CancelClick;

@property (weak, nonatomic) IBOutlet UILabel *emaillab;
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UILabel *firstLab;

@property (weak, nonatomic) IBOutlet UILabel *passwordlab;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UILabel *secondlab1;
@property (weak, nonatomic) IBOutlet UILabel *secondlab2;
@property (weak, nonatomic) IBOutlet UILabel *secondlab3;

@property (weak, nonatomic) IBOutlet UIView *thirdView;
@property (weak, nonatomic) IBOutlet UILabel *notificationlab;
@property (weak, nonatomic) IBOutlet UILabel *bottomlab;
@property (weak, nonatomic) IBOutlet UILabel *notifylab4;

@end
