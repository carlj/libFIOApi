//
//  ViewController.m
//  FIOExample
//
//  Created by carl.jahn on 27.03.13.
//  Copyright (c) 2013 Carl Jahn (https://github.com/carlj). All rights reserved.
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
  FIOAPIClient *client = [FIOAPIClient sharedAPIClient];
  client.apiKey = @"YOUR API KEY";
  
  //Delegate Example
  FIORequestDelegateOperation *delegateOperation = [client forecastOperationWithDelegate:self];
  delegateOperation.longitude = @49.9999976071047;
  delegateOperation.latitude = @49.9999976071047;
  
  //[delegateOperation start];
  
  //Block Example 1
  FIORequestBlockOperation *blockOperation = [client forecastOperationWithFinishedBlock:^(FIORequestBlockOperation *operation, id response){
    NSLog(@"%s %@", __FUNCTION__, response);
  }
                                                                               failedBlock:^(FIORequestBlockOperation *operation, NSError *error){
                                                                                 NSLog(@"%s %@", __FUNCTION__, error);
                                                                               }];
  
  blockOperation.longitude = @49.9999976071047;
  blockOperation.latitude = @49.9999976071047;
  
  //[blockOperation start];
  
  
  //Block Example 2
  [client requestWithLongitude: @49.9999976071047
                      latitude: @49.9999976071047
                          date: [NSDate date]
                      finished: ^(FIORequestBlockOperation *operation, id response){
                        NSLog(@"%s %@", __FUNCTION__, response);
                      }
                        failed: ^(FIORequestBlockOperation *operation, NSError *error){
                          NSLog(@"%s %@", __FUNCTION__, error);
                        }];
  
  //Queue Example
  
  FIORequestDelegateOperation *delegateOperationForQueue = [client forecastOperationWithDelegate:self];
  delegateOperationForQueue.longitude = @49.9999976071047;
  delegateOperationForQueue.latitude = @49.9999976071047;
  
  //[[FIORequestQueue sharedQueue] addOperation: delegateOperationForQueue];
  
  
  //Block Example for specific Time
  FIORequestBlockOperation *blockTimeOperation = [client forecastOperationWithFinishedBlock:^(FIORequestBlockOperation *operation, id response){
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
  FIORequestBlockOperation *blockSIOperation = [client forecastOperationWithFinishedBlock:^(FIORequestBlockOperation *operation, id response){
    NSLog(@"%s %@", __FUNCTION__, response);
  }
                                                                                   failedBlock:^(FIORequestBlockOperation *operation, NSError *error){
                                                                                     NSLog(@"%s %@", __FUNCTION__, error);
                                                                                   }];
  
  blockSIOperation.longitude = @49.9999976071047;
  blockSIOperation.latitude = @49.9999976071047;
  blockSIOperation.useSIUnits = YES;
  //[blockSIOperation start];
}

- (void)operation:(FIORequestDelegateOperation *)operation finishedWithResults:(NSDictionary *)results {
  NSLog(@"%s %@", __FUNCTION__, results);
}


@end
