//
//  UpcomingTableviewcell2.m
//  GetUsHere For Rider
//
//  Created by bharat on 31/05/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "UpcomingTableviewcell2.h"

@implementation UpcomingTableviewcell2

- (void)awakeFromNib {
    // Initialization code
    
    
    _pickuplab.textColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _deslab.textColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    //  _linepicklab.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    //  _linedeslab.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _datelan.textColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    //   _datalinelab.backgroundColor=[UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    
    _viewbutt.backgroundColor= [UIColor colorWithRed:105.0/255.0f green:43.0/255.0f blue:82.0/255.0f alpha:1.0];
    _viewbutt.layer.cornerRadius=5.0;
    _viewbutt.clipsToBounds=YES;
    
    _reviewview.backgroundColor= [UIColor colorWithRed:90.0/255.0f green:143.0/255.0f blue:63.0/255.0f alpha:1.0];
    _reviewview.layer.cornerRadius=5.0;
    _reviewview.clipsToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
