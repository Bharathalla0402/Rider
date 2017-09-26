//
//  UpcomingTableViewCell.h
//  GetUsHere For Rider
//
//  Created by bharat on 18/03/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpcomingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *pickuplab;
@property (weak, nonatomic) IBOutlet UILabel *deslab;
@property (weak, nonatomic) IBOutlet UILabel *linepicklab;
@property (weak, nonatomic) IBOutlet UILabel *linedeslab;
@property (weak, nonatomic) IBOutlet UILabel *dataandtimelab;
@property (weak, nonatomic) IBOutlet UILabel *datalinelab;
@property (weak, nonatomic) IBOutlet UIButton *viewbutt;
@property (weak, nonatomic) IBOutlet UIView *pickView;


@end
