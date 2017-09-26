//
//  Api.h
//  OneVan
//
//  Created by Anil Reddy on 3/29/16.
//  Copyright © 2016 Anil. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
     RequestTypeLogin=0,
    RequestTypeChat=1,
     RequestTypeLocation=2,
     RequestTypeItems=3,
} RequestType;
@protocol ApiClassDelegate <NSObject>
- (void)responce:(id)responce withRequestType :(RequestType)requestType;
@end

@interface Api : NSObject

@property BOOL isInternetConnectionAvailable;

@property (strong, nonatomic) id <ApiClassDelegate>delegate;

-(void)checkNetworkStatus;


@end
