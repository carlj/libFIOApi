//
//  FIOAPIClient.m
//  libFIOApi
//
//  Created by carl.jahn on 27.03.13.
//  Copyright (c) 2013 Carl Jahn (https://github.com/carlj). All rights reserved.
//

#import "FIOAPIClient.h"

#import "FIORequestBlockOperation.h"
#import "FIORequestDelegateOperation.h"

@implementation FIOAPIClient

- (id)initWithAPIKey:(NSString *)apiKey {

  if (self) {
    _apiKey = apiKey;
  }
  
  return self;

}

+ (id)sharedAPIClient {

  static FIOAPIClient *sharedClient = nil;
  static dispatch_once_t sharedOnceToken;
  dispatch_once(&sharedOnceToken, ^{
    sharedClient = [self.class new];
  });

  return sharedClient;
}

- (id)forecastOperationWithDelegate:(id<FIORequestOperationDelegate>)delegate {
  NSAssert(_apiKey, @"no api key given");
  
  FIORequestDelegateOperation *operation = [[FIORequestDelegateOperation alloc] initWithAPIKey: _apiKey];
  operation.delegate = delegate;
  
  return operation;
}

- (id)forecastOperationWithFinishedBlock:(FIORequestFinishedBlock )finishedBlock failedBlock:(FIORequestFailedBlock)failedBlock {
  NSAssert(_apiKey, @"no api key given");

  FIORequestBlockOperation *operation = [[FIORequestBlockOperation alloc] initWithAPIKey: _apiKey];
  operation.finishedBlock = finishedBlock;
  operation.failedBlock = failedBlock;
  
  return operation;
}

- (id)requestWithLongitude:(NSNumber *)longitude latitude:(NSNumber *)latitude date:(NSDate *)date finished:(FIORequestFinishedBlock)finishedBlock failed:(FIORequestFailedBlock)failedBlock {
  NSAssert(_apiKey, @"no api key given");

  FIORequestBlockOperation *blockOperation = [self forecastOperationWithFinishedBlock: finishedBlock
                                                                          failedBlock: failedBlock
                                              ];
  
  blockOperation.longitude = latitude;
  blockOperation.latitude = longitude;
  blockOperation.date = date;
  
  [blockOperation start];

  return blockOperation;
}



@end
