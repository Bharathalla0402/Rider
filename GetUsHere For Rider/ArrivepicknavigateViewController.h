//
//  ArrivepicknavigateViewController.h
//  GetUsHere For Rider
//
//  Created by bharat on 20/06/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPFloatRatingView.h"

@interface ArrivepicknavigateViewController : UIViewController<TPFloatRatingViewDelegate>
{
    
    NSMutableArray *arrdriverinfo;
    NSString *strtripid;
    NSMutableArray *tripinfo;
    NSMutableArray *Driverlocationdetails;
}
@property (weak, nonatomic) IBOutlet UIView *detailview;
@property (weak, nonatomic) IBOutlet UIButton *callbutton;
@property (weak, nonatomic) IBOutlet UILabel *txtname;

@property (weak, nonatomic) IBOutlet UIButton *NavigateButton;

@property (weak, nonatomic) IBOutlet UILabel *pickuplab;
@property (weak, nonatomic) IBOutlet UILabel *deslab;
@property BOOL isInternetConnectionAvailable;

@property (weak, nonatomic) IBOutlet UIImageView *driverprofileimage;

@property (weak, nonatomic) IBOutlet UIView *estimateView;
@property (weak, nonatomic) IBOutlet UIView *distanceView;

@property (weak, nonatomic) IBOutlet UILabel *estimatedtime;
@property (weak, nonatomic) IBOutlet UILabel *distancelab;

@end
