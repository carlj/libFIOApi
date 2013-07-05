//
//  FIORequestOperationDelegate.h
//  libFIOApi
//
//  Created by carl.jahn on 27.03.13.
//  Copyright (c) 2013 Carl Jahn (https://github.com/carlj). All rights reserved.
//

#import <Foundation/Foundation.h>

@class FIORequestDelegateOperation;
@protocol FIORequestOperationDelegate <NSObject>

@required
- (void)operation:(FIORequestDelegateOperation *)operation finishedWithResults:(NSDictionary *)results;

@optional
- (void)operation:(FIORequestDelegateOperation *)operation failedWithError:(NSError *)error;

@end
