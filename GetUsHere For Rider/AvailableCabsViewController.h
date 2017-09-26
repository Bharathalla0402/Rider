//
//  AvailableCabsViewController.h
//  GetUsHere For Rider
//
//  Created by bharat on 23/02/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AvailableCabsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
{

    NSMutableArray *arrnames;
    IBOutlet UIButton *bookbtn;
    
    NSString *strid;
    NSMutableArray *arrdriverdetails;
    NSString *strtripid;
    
    NSString *strpic;
    NSString *strdes;
    
    NSMutableArray *arrdriverinfo;
    NSMutableArray *arrtripinfo;
    
    NSString *strcartype;
    
    NSString *str;
    NSString *strfareest;

    int countlabel;
}

@property BOOL isInternetConnectionAvailable;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *pickuplab;
@property (weak, nonatomic) IBOutlet UILabel *pickupline;
@property (weak, nonatomic) IBOutlet UILabel *deslab;
@property (weak, nonatomic) IBOutlet UILabel *deslinelab;

@property (weak, nonatomic) IBOutlet UILabel *farelabel;
@property (weak, nonatomic) IBOutlet UILabel *pickuplabel;
@property (weak, nonatomic) IBOutlet UILabel *deslabel;


@property (weak, nonatomic) IBOutlet UITableView *tabl;

@property(nonatomic,retain)NSString *TitleString;
@end
