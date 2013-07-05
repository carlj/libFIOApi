//
//  FIORequestOperation.h
//  libFIOApi
//
//  Created by carl.jahn on 27.03.13.
//  Copyright (c) 2013 Carl Jahn (https://github.com/carlj). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestOperation.h"



@interface FIORequestOperation : RequestOperation

@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSDate *date;

@property (nonatomic, assign) BOOL useSIUnits;

- (id)initWithAPIKey:(NSString *)apiKey;


- (void)executeFinishedTaskWithResponse:(id)response;
- (void)executeFailedTaskWithError:(NSError *)error;

- (void)executeOperationInSharedQueue;

@end
