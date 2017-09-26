//
//  ConnectionManager.h
//  GetUsHere For Rider
//
//  Created by bharat on 12/04/16.
//  Copyright © 2016 bharat. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    TASK_GET_CARSLIST

} CURRENT_TASK;


@protocol ConnectionmangerDelegate <NSObject>

@optional
-(void)didRecieveResponse;
-(void)didFailWithError;

@end

@interface ConnectionManager : NSObject


{
    CURRENT_TASK currentTask;
}

@property (nonatomic, assign) id<ConnectionmangerDelegate> delegate;
@property (nonatomic, assign) CURRENT_TASK currentTask;
@property (nonatomic, assign) NSInteger tagValue;

@property (nonatomic, retain) NSMutableDictionary *responseDictionary;
@property (nonatomic, retain) NSError *responseError;
@property(nonatomic,retain) NSData *responsedata;

-(BOOL)getDataForFunction:(NSString *)functionName withCurrentTask:(CURRENT_TASK)task andDelegate:(id)_delegate withDict:(NSMutableString*)diPcaram;

@end
