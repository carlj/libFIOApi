//
//  FIORequestQueue.m
//  libFIOApi
//
//  Created by carl.jahn on 27.03.13.
//  Copyright (c) 2013 Carl Jahn (carl.jahn@nidag.com), NIDAG GmbH. All rights reserved.
//

#import "FIORequestQueue.h"

NSString *const kFIORequestQueueStartedNotificatioName = @"kFIORequestQueueStartedNotificatioName";
NSString *const kFIORequestQueueFinishedNotificatioName = @"kFIORequestQueueFinishedNotificatioName";
NSString *const kFIORequestQueueCanceledNotificatioName = @"kFIORequestQueueCanceledNotificatioName";


@implementation FIORequestQueue

- (id)init {

  self = [super init];
  
  if (self) {
    self.maxConcurrentOperationCount = kFIORequestMAXCurrentOperationsCount;
  }

  return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
  
  
  if (object == self) {

    if (!self.operationCount) {
      
      [self queuFinished];
    }
    
  }
  
}

- (void)performNotificationOnMainThread:(NSString *)notificationName {

  __weak FIORequestQueue *blockQueue = self;
  __weak NSString *blockNotificationName = notificationName;
  PerformTaskOnMainThreadWithBlock (^{
    [[NSNotificationCenter defaultCenter] postNotificationName: blockNotificationName object: blockQueue];
  });
}

- (void)queueStarted {
  if (!self.operationCount) {
    [self performNotificationOnMainThread: kFIORequestQueueFinishedNotificatioName];
  }
}

- (void)queuFinished {
  [self performNotificationOnMainThread: kFIORequestQueueFinishedNotificatioName];
}

- (void)queuCanceled {
  [self performNotificationOnMainThread: kFIORequestQueueCanceledNotificatioName];
}


- (void)addOperations:(NSArray *)ops waitUntilFinished:(BOOL)wait {

  [self queueStarted];
  [super addOperations:ops waitUntilFinished:wait];
}

- (void)addOperation:(NSOperation *)op {

  [self queueStarted];
  [super addOperation:op];
}

- (void)cancelAllOperations {
  
  [self setSuspended: YES];
  [super cancelAllOperations];
  
  [self queuCanceled];
}

+ (id)sharedQueue {
  
  static dispatch_once_t sharedQueueOnceToken;
  static FIORequestQueue *sharedQueue = nil;
  dispatch_once(&sharedQueueOnceToken, ^{
    sharedQueue = [FIORequestQueue new];
  });
  
  return sharedQueue;
}

@end
