//
//  FarecarselectViewController.h
//  GetUsHere For Rider
//
//  Created by bharat on 01/03/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FarecarselectViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
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
- (IBAction)sidebarButton:(id)sender;
@end
