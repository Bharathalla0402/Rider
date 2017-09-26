//
//  Alertview.h
//  GetUsHere For Rider
//
//  Created by bharat on 05/03/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Alertview : UIAlertController


+(void)showalertwithTitle:(NSString *)Title Message:(NSString *)message cancelButton:(NSString *)cancel OkButton:(NSString *)okbutton;

@end
