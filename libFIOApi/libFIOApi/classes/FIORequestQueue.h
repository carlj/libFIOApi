//
//  FIORequestQueue.h
//  libFIOApi
//
//  Created by carl.jahn on 27.03.13.
//  Copyright (c) 2013 Carl Jahn (https://github.com/carlj). All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kFIORequestQueueStartedNotificatioName;
extern NSString *const kFIORequestQueueFinishedNotificatioName;
extern NSString *const kFIORequestQueueCanceledNotificatioName;

@interface FIORequestQueue : NSOperationQueue

+ (id)sharedQueue;


@end
