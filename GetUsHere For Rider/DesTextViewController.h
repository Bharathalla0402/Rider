//
//  DesTextViewController.h
//  GetUsHere For Rider
//
//  Created by bharat on 14/09/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVPlaceSearchTextField.h"

@interface DesTextViewController : UIViewController<PlaceSearchTextFieldDelegate>

@property (weak, nonatomic) IBOutlet MVPlaceSearchTextField *searchDropAddRef;
@end
