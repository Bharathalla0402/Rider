//
//  FinalpayconformViewController.h
//  GetUsHere For Rider
//
//  Created by bharat on 30/05/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinalpayconformViewController : UIViewController<UIGestureRecognizerDelegate>
{
    UIView *popview,*footerview;

}

@property (weak, nonatomic) IBOutlet UIView *navigatebar;
@property (weak, nonatomic) IBOutlet UILabel *titlelable;
@property (weak, nonatomic) IBOutlet UIButton *backbtn;

@end
