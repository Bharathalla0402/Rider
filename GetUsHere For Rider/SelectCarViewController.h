//
//  SelectCarViewController.h
//  GetUsHere For Rider
//
//  Created by bharat on 18/02/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@interface SelectCarViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
{
    NSMutableArray *arrcars;
    //NSMutableArray *arrnames;
    NSMutableArray *arrindex;
    
    NSMutableArray *arrnames;

    NSMutableArray *arrid;
    
    
    
    NSMutableArray *arrcarnames;
    NSMutableArray *arrcarrate;
    NSMutableArray *arrcarid;
}

@end
