//
//  ConcurrentOperation.m
//  libFIOApi
//
//  Created by carl.jahn on 27.03.13.
//  Copyright (c) 2013 Carl Jahn (https://github.com/carlj). All rights reserved.
//

#import "ConcurrentOperation.h"

@implementation ConcurrentOperation
@synthesize finished = _finished;
@synthesize executing = _executing;


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
  
    if (self.isCancelled) {
        [self finish];
        return;
    }
    
  PerformTaskOnMainThreadWithBlock(^{
    
    [self willChangeValueForKey:@"isExecuting"];
    _executing = YES;
    [self didChangeValueForKey:@"isExecuting"];

  });
  
}

- (void)cancel {
  [super cancel];
  
  PerformTaskOnMainThreadWithBlock(^{

    [self willChangeValueForKey:@"isExecuting"];
  
    _executing = NO;
  
    [self didChangeValueForKey:@"isExecuting"];
    
  });
}

- (void)finish {
  
  PerformTaskOnMainThreadWithBlock(^{
    
    [self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
    
    _executing = NO;
    _finished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
    
  });
  
}

- (BOOL)isConcurrent {
  return YES;
}


@end
