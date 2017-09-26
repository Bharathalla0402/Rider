//
//  CancelledViewController.h
//  GetUsHere For Rider
//
//  Created by bharat on 18/03/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CancelledViewController : UIViewController<UIGestureRecognizerDelegate>
{

IBOutlet UITableView *tab;
IBOutlet UIButton *butt;


    NSMutableArray *arrdetails;
    NSMutableDictionary *arrpages;
    NSString *strpage;
    NSString *strpagepre;
}

@property (weak, nonatomic) IBOutlet UIButton *smallPrevious;
@property (weak, nonatomic) IBOutlet UIButton *smallnext;
@property (weak, nonatomic) IBOutlet UIButton *next;
@property (weak, nonatomic) IBOutlet UIButton *previous;

@end
