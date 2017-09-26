//
//  ChatVController.h
//  GetUsHere For Rider
//
//  Created by bharat on 05/05/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatVController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSString *userid;
    NSString *driverid;
    
    NSMutableArray *tripdriverinfo;
    
    NSMutableArray *arrmessage;
    
    NSMutableArray *arrids;
    
    NSMutableArray *arrimage;
}

@property (weak, nonatomic) IBOutlet UIView *messageView;

@property (weak, nonatomic) IBOutlet UITextField *TextMessage;

@property (weak, nonatomic) IBOutlet UITableView *ChatTable;

@property BOOL isInternetConnectionAvailable;

@end
