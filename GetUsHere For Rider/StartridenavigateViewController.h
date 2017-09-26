//
//  StartridenavigateViewController.h
//  GetUsHere For Rider
//
//  Created by bharat on 20/06/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPFloatRatingView.h"

@interface StartridenavigateViewController : UIViewController<TPFloatRatingViewDelegate>
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
@property (weak, nonatomic) IBOutlet UIButton *chatbutt;

@property (weak, nonatomic) IBOutlet UIImageView *driverprofileimage;

@property (weak, nonatomic) IBOutlet UIView *estimateView;
@property (weak, nonatomic) IBOutlet UIView *distanceView;

@property (weak, nonatomic) IBOutlet UILabel *estimatedtime;
@property (weak, nonatomic) IBOutlet UILabel *distancelab;

@property BOOL isInternetConnectionAvailable;
@end
