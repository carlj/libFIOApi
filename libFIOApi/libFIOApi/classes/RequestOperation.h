//
//  RequestOperation.h
//  libFIOApi
//
//  Created by carl.jahn on 27.03.13.
//  Copyright (c) 2013 Carl Jahn (https://github.com/carlj). All rights reserved.
//

#import "ConcurrentOperation.h"

@class AFHTTPRequestOperation;
@interface RequestOperation : ConcurrentOperation

@property (nonatomic, strong, readonly) NSURLRequest *request;
@property (nonatomic, strong, readonly) AFHTTPRequestOperation *httpRequest;

- (void)requestFinishedWithJSON:(id)json;
- (void)requestFailedWithError:(NSError *)error;

@end
