//
//  CancelledinfodetailViewController.h
//  GetUsHere For Rider
//
//  Created by bharat on 21/06/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPFloatRatingView.h"

@interface CancelledinfodetailViewController : UIViewController<TPFloatRatingViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *driverprofileimage;
@property (weak, nonatomic) IBOutlet UIView *detailview;
@property (weak, nonatomic) IBOutlet UILabel *txtname;

@property (weak, nonatomic) IBOutlet UILabel *pickuplab;
@property (weak, nonatomic) IBOutlet UILabel *deslab;

@property (weak, nonatomic) IBOutlet UILabel *bookingtime;
@property (weak, nonatomic) IBOutlet UILabel *bookingstatus;

@property (weak, nonatomic) IBOutlet UILabel *resaon;



@property(nonatomic,retain) NSString *strname;
@property(nonatomic,retain) NSString *strimageurl;
@property(nonatomic,retain) NSString *strratingnumber;

@property(nonatomic,retain) NSString *strpickup;
@property(nonatomic,retain) NSString *strDestination;

@property(nonatomic,retain) NSString *strdate;
@property(nonatomic,retain) NSString *strtime;
@property(nonatomic,retain) NSString *strstatus;

@property(nonatomic,retain) NSString *strreason;

@property(nonatomic,retain) NSString *strtripid;

@end
