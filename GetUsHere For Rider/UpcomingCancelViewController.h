//
//  UpcomingCancelViewController.h
//  GetUsHere For Rider
//
//  Created by bharat on 21/03/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpcomingCancelViewController : UIViewController
{

     UILabel *lblname;
    NSString *str;

}
@property (strong, nonatomic) IBOutlet UIButton *btn;
- (IBAction)btnclicked:(UIButton*)sender;

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;

@property (weak, nonatomic) IBOutlet UIButton *doneClick;
@property (weak, nonatomic) IBOutlet UIButton *backClick;

@end
