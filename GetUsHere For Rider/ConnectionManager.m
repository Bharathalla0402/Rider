//
//  ConnectionManager.m
//  GetUsHere For Rider
//
//  Created by bharat on 12/04/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import "ConnectionManager.h"
#import "GetUsHere.pch"


static ConnectionManager *conectionManger = nil;

@implementation ConnectionManager

@synthesize delegate;
@synthesize responseDictionary;
@synthesize responseError;
@synthesize currentTask;
@synthesize tagValue;
@synthesize responsedata;


-(BOOL)getDataForFunction:(NSString *)functionName withCurrentTask:(CURRENT_TASK)task andDelegate:(id)_delegate withDict:(NSMutableString*)diPcaram
{
    conectionManger.currentTask = task;
    conectionManger.delegate = _delegate;
    
    self.delegate = _delegate;
    currentTask = task;
    NSString *urlString = [NSString stringWithFormat:@"%@%@",BaseUrl,functionName];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    request.HTTPMethod = @"POST";
    
    request.HTTPBody  = [diPcaram dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error) {
                                   responsedata = data;
                                   
                        [self.delegate performSelector:@selector(didFailWithError) withObject:self];
                               } else {
                                   
                        [self.delegate performSelector:@selector(didRecieveResponse) withObject:self];
                                   
                               }
                           }];
    
    
    return YES;
}

-(void)didRecieveResponse
{
    
}
-(void)didFailWithError
{
    
}

@end
