//
//  RequestOperation.h
//  libFIOApi
//
//  Created by carl.jahn on 27.03.13.
//  Copyright (c) 2013 Carl Jahn (https://github.com/carlj). All rights reserved.
//

#import "ConcurrentOperation.h"

@class AFJSONRequestOperation;
@interface RequestOperation : ConcurrentOperation

@property (nonatomic, readonly) NSURLRequest *request;
@property (nonatomic, readonly) AFJSONRequestOperation *httpRequest;

- (void)requestFinishedWithJSON:(id)JSON;
- (void)requestFailedWithError:(NSError *)error;

@end
