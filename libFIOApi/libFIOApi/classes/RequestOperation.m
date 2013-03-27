//
//  RequestOperation.m
//  libFIOApi
//
//  Created by carl.jahn on 27.03.13.
//  Copyright (c) 2013 Carl Jahn (carl.jahn@nidag.com), NIDAG GmbH. All rights reserved.
//

#import "RequestOperation.h"
#import "AFNetworking.h"

@interface RequestOperation ()


@end

@implementation RequestOperation
@synthesize httpRequest = _httpRequest;

- (id)initWithRequest:(NSURLRequest *)request {
  
  self = [super init];
  
  if (self) {
    _request = request;
  }
  
  return self;
}


#pragma mark -
#pragma mark HTTP Methods
- (AFJSONRequestOperation *)httpRequest {
  
  if (!_httpRequest) {
    
    __block RequestOperation *blockSelf = self;
    _httpRequest = [AFJSONRequestOperation JSONRequestOperationWithRequest: self.request
                                                                   success: ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                     [blockSelf requestFinishedWithJSON: JSON];
                                                                   }
                                                                   failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                     [blockSelf requestFailedWithError: error];
                                                                   }
                    ];
    
  }
  return _httpRequest;
}

- (void)requestFinishedWithJSON:(id)JSON {
  [self finish];
}


- (void)requestFailedWithError:(NSError *)error {
  [self finish];
}


- (void)cancelHTTPRequest {
  if (_httpRequest) {
    [self.httpRequest cancel];
  }
}

#pragma mark -
#pragma mark Lifecylce Methods
- (void)start {
  
  [super start];
  
  __block RequestOperation * blockSelf = self;
  PerformTaskOnMainThreadWithBlock(^{
    [blockSelf.httpRequest start];
  });
  
}

- (void)cancel {
  
  [self cancelHTTPRequest];
  [super cancel];
}

- (void)finish {
  [super finish];
  
  [self cancelHTTPRequest];
}

@end
