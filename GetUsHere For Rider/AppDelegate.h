//
//  AppDelegate.h
//  GetUsHere For Rider
//
//  Created by bharat on 12/02/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "SidebarViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>
{
    NSString *devicetokenString;
    ViewController *vc;
    SidebarViewController *side;
    CLLocationManager *locationManager;
}

@property (strong, nonatomic) UIWindow *window;

@end

