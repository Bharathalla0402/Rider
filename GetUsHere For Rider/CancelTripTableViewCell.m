//
//  CancelTripTableViewCell.m
//  GetUsHere For Rider
//
//  Created by bharat on 14/04/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "CancelTripTableViewCell.h"

@implementation CancelTripTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=[UIColor colorWithRed:228.0/255.0f green:224.0/255.0f blue:224.0/255.0f alpha:1.0];
    _viewlab.layer.masksToBounds=YES;
    _viewlab.layer.cornerRadius=5.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
