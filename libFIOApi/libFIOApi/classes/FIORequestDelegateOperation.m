//
//  FIORequestDelegateOperation.m
//  libFIOApi
//
//  Created by carl.jahn on 27.03.13.
//  Copyright (c) 2013 Carl Jahn (https://github.com/carlj). All rights reserved.
//

#import "FIORequestDelegateOperation.h"

@implementation FIORequestDelegateOperation

- (void)executeFinishedTaskWithResponse:(id)response {

  if (self.delegate && [self.delegate conformsToProtocol:@protocol(FIORequestOperationDelegate) ]) {
  
    [self.delegate operation:self finishedWithResults: response];
  }
  
}

- (void)executeFailedTaskWithError:(NSError *)error {

  if (self.delegate && [self.delegate conformsToProtocol:@protocol(FIORequestOperationDelegate) ] && [self.delegate respondsToSelector:@selector(operation:failedWithError:)]) {
    
    [self.delegate operation:self failedWithError: error];
  }
  
}

@end
