//
//  SelectPaymentViewController.h
//  GetUsHere For Rider
//
//  Created by bharat on 27/05/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectPaymentViewController : UIViewController
@property BOOL isInternetConnectionAvailable;
@property(nonatomic, strong, readwrite) NSString *resultText;
@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, assign, readwrite) BOOL acceptCreditCards;
@end
