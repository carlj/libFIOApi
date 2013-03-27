//
//  FIOAPIClient.m
//  libFIOApi
//
//  Created by carl.jahn on 27.03.13.
//  Copyright (c) 2013 Carl Jahn (carl.jahn@nidag.com), NIDAG GmbH. All rights reserved.
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


@end
