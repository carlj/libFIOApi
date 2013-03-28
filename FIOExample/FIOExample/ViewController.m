//
//  ViewController.m
//  FIOExample
//
//  Created by carl.jahn on 27.03.13.
//  Copyright (c) 2013 Carl Jahn (carl.jahn@nidag.com), NIDAG GmbH. All rights reserved.
//

#import "ViewController.h"

#import "libFIOApi.h"

@interface ViewController ()<FIORequestOperationDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  NSLog(@"%s", __FUNCTION__);
  FIOAPIClient *client = [[FIOAPIClient alloc] initWithAPIKey: @"3edb9d81b1eee3c01f1eeb5cf918ed43" ];
  
  //Delegate Example
  FIORequestDelegateOperation *delegateOperation = [client forecastOperationWithDelegate:self];
  delegateOperation.longitude = @49.9999976071047;
  delegateOperation.latitude = @49.9999976071047;
  
  //[delegateOperation start];
  
  //Block Example
  FIORequestDelegateOperation *blockOperation = [client forecastOperationWithFinishedBlock:^(FIORequestBlockOperation *operation, id response){
    NSLog(@"%s %@", __FUNCTION__, response);
  }
                                                                               failedBlock:^(FIORequestBlockOperation *operation, NSError *error){
                                                                                 NSLog(@"%s %@", __FUNCTION__, error);
                                                                               }];
  
  blockOperation.longitude = @49.9999976071047;
  blockOperation.latitude = @49.9999976071047;
  
  //[blockOperation start];
  
  
  
  
  //Queue Example
  
  FIORequestDelegateOperation *delegateOperationForQueue = [client forecastOperationWithDelegate:self];
  delegateOperationForQueue.longitude = @49.9999976071047;
  delegateOperationForQueue.latitude = @49.9999976071047;
  
  //[[FIORequestQueue sharedQueue] addOperation: delegateOperationForQueue];
  
  
  //Block Example for specific Time
  FIORequestDelegateOperation *blockTimeOperation = [client forecastOperationWithFinishedBlock:^(FIORequestBlockOperation *operation, id response){
    NSLog(@"%s %@", __FUNCTION__, response);
  }
                                                                               failedBlock:^(FIORequestBlockOperation *operation, NSError *error){
                                                                                 NSLog(@"%s %@", __FUNCTION__, error);
                                                                               }];
  
  blockTimeOperation.longitude = @49.9999976071047;
  blockTimeOperation.latitude = @49.9999976071047;
  blockTimeOperation.date = [NSDate date]; //automaticly convert the NSDate to GMT
  //[blockTimeOperation start];
  
  //Block Example with SI Units
  FIORequestDelegateOperation *blockSIOperation = [client forecastOperationWithFinishedBlock:^(FIORequestBlockOperation *operation, id response){
    NSLog(@"%s %@", __FUNCTION__, response);
  }
                                                                                   failedBlock:^(FIORequestBlockOperation *operation, NSError *error){
                                                                                     NSLog(@"%s %@", __FUNCTION__, error);
                                                                                   }];
  
  blockSIOperation.longitude = @49.9999976071047;
  blockSIOperation.latitude = @49.9999976071047;
  blockSIOperation.useSIUnits = YES;
  [blockSIOperation start];
}

- (void)operation:(FIORequestDelegateOperation *)operation finishedWithResults:(NSDictionary *)results {
  NSLog(@"%s %@", __FUNCTION__, results);
}


@end
