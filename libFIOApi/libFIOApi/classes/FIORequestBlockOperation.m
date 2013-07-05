//
//  FIORequestBlockOperation.m
//  libFIOApi
//
//  Created by carl.jahn on 27.03.13.
//  Copyright (c) 2013 Carl Jahn (https://github.com/carlj). All rights reserved.
//

#import "FIORequestBlockOperation.h"

@implementation FIORequestBlockOperation

- (void)executeFinishedTaskWithResponse:(id)response {
  
  if (_finishedBlock) {
    
    __weak FIORequestBlockOperation *blockOperation = self;
    __weak NSDictionary *blockResponse = response;
    
    _finishedBlock(blockOperation, blockResponse);
  }
  
}

- (void)executeFailedTaskWithError:(NSError *)error {
  
  
  if (_failedBlock) {
    
    __weak FIORequestBlockOperation *blockOperation = self;
    __weak NSError *blockError = error;
    
    _failedBlock(blockOperation, blockError);
  }
  
}

@end
