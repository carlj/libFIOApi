//
//  ConcurrentOperation.h
//  libFIOApi
//
//  Created by carl.jahn on 27.03.13.
//  Copyright (c) 2013 Carl Jahn (carl.jahn@nidag.com), NIDAG GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConcurrentOperation : NSOperation

@property (nonatomic, assign, getter = isExecuting) BOOL executing;
@property (nonatomic, assign, getter = isFinished) BOOL finished;
@property (nonatomic, assign, getter = isCancelled) BOOL cancelled;

- (void)finish;
@end
