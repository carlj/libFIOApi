//
//  ConcurrentOperation.m
//  libFIOApi
//
//  Created by carl.jahn on 27.03.13.
//  Copyright (c) 2013 Carl Jahn (carl.jahn@nidag.com), NIDAG GmbH. All rights reserved.
//

#import "ConcurrentOperation.h"

@implementation ConcurrentOperation

- (id)init {
  self = [super init];
  
  if (self) {

    _finished = NO;
    _executing = NO;
  }
  
  return self;
}

#pragma mark -
#pragma mark Lifecylce Methods
- (void)start {
  
  __weak ConcurrentOperation *blockOperation = self;
  PerformTaskOnMainThreadWithBlock(^{
    
    [blockOperation willChangeValueForKey:@"isExecuting"];
    blockOperation.executing = YES;
    [blockOperation didChangeValueForKey:@"isExecuting"];

  });
  
}

- (void)cancel {
  
  [super cancel];
}

- (void)finish {
  
  __weak ConcurrentOperation *blockSelf = self;
  PerformTaskOnMainThreadWithBlock(^{
    
    [blockSelf willChangeValueForKey:@"isExecuting"];
    [blockSelf willChangeValueForKey:@"isFinished"];
    
    blockSelf.executing = NO;
    blockSelf.finished = YES;
    
    [blockSelf didChangeValueForKey:@"isExecuting"];
    [blockSelf didChangeValueForKey:@"isFinished"];
    
  });
  
}

- (BOOL)isConcurrent {
  return YES;
}


@end
