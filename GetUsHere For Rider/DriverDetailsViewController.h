//
//  DriverDetailsViewController.h
//  GetUsHere For Rider
//
//  Created by bharat on 28/03/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPFloatRatingView.h"

@interface DriverDetailsViewController : UIViewController<TPFloatRatingViewDelegate>
{

    NSMutableArray *arrdriverinfo;
    NSString *strtripid;
    NSMutableArray *tripinfo;
    NSMutableArray *Driverlocationdetails;
}
@property (weak, nonatomic) IBOutlet UIView *detailview;
@property (weak, nonatomic) IBOutlet UIButton *callbutton;
@property (weak, nonatomic) IBOutlet UILabel *txtname;
@property (weak, nonatomic) IBOutlet UILabel *txtlicencename;
@property (weak, nonatomic) IBOutlet UILabel *txtEta;

@property (weak, nonatomic) IBOutlet UIButton *cancelbut;
@property (weak, nonatomic) IBOutlet UIButton *chatbutt;


@property (weak, nonatomic) IBOutlet UIButton *NavigateButton;
@property (weak, nonatomic) IBOutlet UILabel *pickuplab;
@property (weak, nonatomic) IBOutlet UILabel *deslab;

@property (weak, nonatomic) IBOutlet UILabel *bookingtime;
@property (weak, nonatomic) IBOutlet UILabel *bookingstatus;

@property BOOL isInternetConnectionAvailable;
@property (weak, nonatomic) IBOutlet UIImageView *driverprofileimage;
@property (weak, nonatomic) IBOutlet TPFloatRatingView *ratethedriver;

@end
