//
//  RiderData.h
//  Jaguar Enterprises
//
//  Created by Lakshmaiah Chowdary on 2/6/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RiderData : NSObject


@property(nonatomic,retain) NSString *UserId;
@property(nonatomic,retain) NSString *UserName;
@property(nonatomic,retain) NSString *LAstname;
@property(nonatomic,retain) NSString *Email;
@property(nonatomic,retain) NSString *Phone;


+ (id)sharedManager;

@end
