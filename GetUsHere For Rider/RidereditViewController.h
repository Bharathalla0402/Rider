//
//  RidereditViewController.h
//  Jaguar Enterprises
//
//  Created by bharat on 27/01/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RiderMainPageViewController.h"


@interface RidereditViewController : UIViewController<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate>
{
    
    NSMutableArray *arrname;
    NSMutableArray *arrContact;
    
    NSMutableArray *arrperDetails;
    NSMutableArray *arrtripcounts;
    
    UIView *popview,*footerview;
    
    NSMutableArray *arrid;
    
    NSString *base64Encoded;
    
    
    NSMutableArray *personaldetails;
    
    NSString *strimagename;
}

@property (weak, nonatomic) IBOutlet UIView *first;
@property (weak, nonatomic) IBOutlet UIView *second;
@property (weak, nonatomic) IBOutlet UIView *third;
@property (weak, nonatomic) IBOutlet UIView *fourth;

@property (weak, nonatomic) IBOutlet UILabel *personalindolab;
@property (weak, nonatomic) IBOutlet UILabel *lineLab;
@property (weak, nonatomic) IBOutlet UILabel *emergencycontactlab;


@property (weak, nonatomic) IBOutlet UITableView *contacttable;
@property (weak, nonatomic) IBOutlet UILabel *linelab;


@property (weak, nonatomic) IBOutlet UITextField *txtName;

@property (weak, nonatomic) IBOutlet UILabel *lblname;
@property (weak, nonatomic) IBOutlet UILabel *lbltrip;
@property (weak, nonatomic) IBOutlet UILabel *lblcancel;
@property (weak, nonatomic) IBOutlet UILabel *lblcompleted;

@property (weak, nonatomic) IBOutlet UITextField *txtcontact;
//@property (weak, nonatomic) IBOutlet UITextField *txtemail;
@property (weak, nonatomic) IBOutlet UILabel *txtemail;


@property (weak, nonatomic) IBOutlet UIImageView *imag;

@property (weak, nonatomic) IBOutlet UIButton *pictureedit;

@property (weak, nonatomic) IBOutlet UIButton *pictureImage;
@property (weak, nonatomic) IBOutlet UIButton *personalCancel;
@property (weak, nonatomic) IBOutlet UIButton *personalUpdate;



@property (weak, nonatomic) IBOutlet UIButton *addanother;

@end
