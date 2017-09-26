//
//  UpcomingRidesViewController.h
//  GetUsHere For Rider
//
//  Created by bharat on 18/03/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpcomingRidesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
{
    IBOutlet UITableView *tab;
    
    IBOutlet UIButton *butt;
    IBOutlet UIButton *butt1;
    
    NSString *strtripidof;
    
    NSMutableArray *arrdetails;
    NSMutableArray *arrupcomingdetails;
    NSMutableArray *arrcompleteddetails;
    
    NSMutableArray *arrdriverinfo;
    NSMutableArray *arrtripinfo;
    
    NSMutableArray *arrinvoicedetails;
    
    NSMutableDictionary *arrpages;
    
    NSString *strpage;
     NSString *strpagepre;
    
    BOOL isClicked;
    NSInteger selectedIndex;
    
   
}

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentchang;


@property (weak, nonatomic) IBOutlet UIButton *smallPrevious;
@property (weak, nonatomic) IBOutlet UIButton *smallnext;
@property (weak, nonatomic) IBOutlet UIButton *next;
@property (weak, nonatomic) IBOutlet UIButton *previous;


@end
