//
//  RiderData.m
//  Jaguar Enterprises
//
//  Created by Lakshmaiah Chowdary on 2/6/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "RiderData.h"

@implementation RiderData

@synthesize UserId,UserName,LAstname,Email,Phone;

+ (id)sharedManager {
    static RiderData *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    self = [super init];
    
            return self;
}


@end
