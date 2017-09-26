//
//  UserInformation.h
//  Jaguar Enterprises
//
//  Created by Mac on 10/02/16.
//  Copyright (c) 2016 bharat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInformation : NSObject<NSCoding>

@property(nonatomic,retain) NSString *Name;
@property(nonatomic,retain) NSString *totalTrips;
@property(nonatomic,retain) NSString *cancelTrips;
@property(nonatomic,retain) NSString *email;
@property(nonatomic,retain) NSString *MobileNumber;
@property(nonatomic,retain) NSString *userid;

+ (UserInformation *)sharedController;

-(void)updateuserinfo:(NSMutableDictionary *)Array;

@end
