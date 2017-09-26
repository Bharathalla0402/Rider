//
//  RiderMainPageViewController.h
//  Jaguar Enterprises
//
//  Created by bharat on 25/01/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Customcell1.h"
#import "RiderMainPageViewController.h"
#import "FacebookViewController.h"


@interface RiderMainPageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{

    NSMutableArray *arrimage;
    NSMutableArray *arrtitle;
    NSMutableData *mdata;
    
    NSMutableArray *arr;
    NSString *str;
    
    NSString *strtotal;
    NSString *strcancelled;
    
    
    NSMutableArray *arrcars;
    NSMutableArray *arrid;
    
    NSMutableArray *arrdetails;
    
    Customcell1 *cell;
    
    NSMutableArray *arrcount;
    
}
@property BOOL isInternetConnectionAvailable;
@property (weak, nonatomic) IBOutlet UILabel *txtname;
@property (weak, nonatomic) IBOutlet UILabel *txtTrips;
@property (weak, nonatomic) IBOutlet UILabel *txtCancell;

@property (weak, nonatomic) IBOutlet UIImageView *profiimage;
@property (weak, nonatomic) IBOutlet UIView *profileView;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end
