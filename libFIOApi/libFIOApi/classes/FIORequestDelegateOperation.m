//
//  FIORequestDelegateOperation.m
//  libFIOApi
//
//  Created by carl.jahn on 27.03.13.
//  Copyright (c) 2013 Carl Jahn (carl.jahn@nidag.com), NIDAG GmbH. All rights reserved.
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
