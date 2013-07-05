//
//  FIOAPIClient.h
//  libFIOApi
//
//  Created by carl.jahn on 27.03.13.
//  Copyright (c) 2013 Carl Jahn (carl.jahn@nidag.com), NIDAG GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FIORequestOperationDelegate.h"
#import "FIORequestBlock.h"

@interface FIOAPIClient : NSObject

- (id)initWithAPIKey:(NSString *)apiKey;
+ (id)sharedAPIClient;

@property (nonatomic, strong) NSString *apiKey;


- (id)forecastOperationWithDelegate:(id<FIORequestOperationDelegate>)delegate;
- (id)forecastOperationWithFinishedBlock:(FIORequestFinishedBlock )finishedBlock failedBlock:(FIORequestFailedBlock)failedBlock;

- (id)requestWithLongitude:(NSNumber *)longitude latitude:(NSNumber *)latitude date:(NSDate *)date finished:(FIORequestFinishedBlock)finishedBlock failed:(FIORequestFailedBlock)failedBlock;


@end
