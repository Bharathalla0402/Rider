//
//  AboutUsViewController.h
//  GetUsHere For Rider
//
//  Created by bharat on 11/03/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutUsViewController : UIViewController<UIWebViewDelegate,UIGestureRecognizerDelegate>
{
    NSString *str;
    NSString *str1;
    NSString *str2;
    NSString *str3;
    
    NSMutableArray *arrdetails;
}
@property (weak, nonatomic) IBOutlet UILabel *txtlbl;
@property (weak, nonatomic) IBOutlet UILabel *txtstring;
@property (weak, nonatomic) IBOutlet UITextView *txtstr;
@property (weak, nonatomic) IBOutlet UIButton *feedbtn;
@property (weak, nonatomic) IBOutlet UIButton *chatbtn;
@property (weak, nonatomic) IBOutlet UIButton *ratebtn;
@property (weak, nonatomic) IBOutlet UIButton *mapbtn;

@property (weak, nonatomic) IBOutlet UIWebView *ContentView;

@end
