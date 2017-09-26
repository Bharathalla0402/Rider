//
//  UserInformation.m
//  Jaguar Enterprises
//
//  Created by Mac on 10/02/16.
//  Copyright (c) 2016 bharat. All rights reserved.
//

#import "UserInformation.h"

static UserInformation *sharedController;

@implementation UserInformation
@synthesize Name,totalTrips,cancelTrips,email,MobileNumber,userid;

+ (UserInformation *)sharedController
{
    if (sharedController == nil)
    {
        sharedController = [[self alloc] init];
    }
    return sharedController;
}
- (id)init
{
    if ((self = [super init]))
    {
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:Name forKey:@"Name"];
    [aCoder encodeObject:totalTrips forKey:@"totalTrips"];
    [aCoder encodeObject:cancelTrips forKey:@"cancelTrips"];
    [aCoder encodeObject:email forKey:@"email"];
    [aCoder encodeObject:MobileNumber forKey:@"MobileNumber"];
    [aCoder encodeObject:userid forKey:@"userid"];
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    Name = [aDecoder decodeObjectForKey:@"Name"];
    totalTrips = [aDecoder decodeObjectForKey:@"totalTrips"];
    cancelTrips=[aDecoder decodeObjectForKey:@"totalTrips"];
    email =[aDecoder decodeObjectForKey:@"email"];
    MobileNumber=[aDecoder decodeObjectForKey:@"MobileNumber"];
    userid=[aDecoder decodeObjectForKey:@"userid"];
    
    return self;
    
}
-(void)updateuserinfo:(NSMutableDictionary *)Array
{
    Name=[[Array objectForKey:@"data"] valueForKey:@"name"];
    totalTrips=[[Array  objectForKey:@"data"] valueForKey:@"total_trip"];
    cancelTrips=[[Array  objectForKey:@"data"] valueForKey:@"canceled_trip" ];
    email=[[Array  objectForKey:@"data"] valueForKey:@"email"];
    MobileNumber=[[Array  objectForKey:@"data"] valueForKey:@"mobile_no"];
    userid=[[Array objectForKey:@"data"]valueForKey:@"user_id"];
}

@end
