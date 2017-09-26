//
//  SidebarViewController.h
//  Jaguar Enterprises
//
//  Created by bharat on 01/02/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"
#import "SWRevealViewController.h"

@interface SidebarViewController : UIViewController<MKMapViewDelegate,SWRevealViewControllerDelegate,UIGestureRecognizerDelegate>
{
    NSMutableArray *arrcars;
    NSMutableArray *arrid;
    NSMutableArray *arrdetails;
    
    NSMutableArray *arrcount;
}


@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIButton *pingButt;
@property BOOL isInternetConnectionAvailable;
@end
