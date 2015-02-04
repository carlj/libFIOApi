//
//  RequestOperation.m
//  libFIOApi
//
//  Created by carl.jahn on 27.03.13.
//  Copyright (c) 2013 Carl Jahn (https://github.com/carlj). All rights reserved.
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
- (AFHTTPRequestOperation *)httpRequest {
    
    if (!_httpRequest) {
        
        __block RequestOperation *blockSelf = self;
        _httpRequest = [[AFHTTPRequestOperation alloc] initWithRequest:self.request];
        _httpRequest.responseSerializer = [AFJSONResponseSerializer new];
        [_httpRequest setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            [blockSelf requestFinishedWithJSON: operation.responseObject];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [blockSelf requestFailedWithError: error];
            
        }];
        
        
    }
    
    return _httpRequest;
}

- (void)requestFinishedWithJSON:(id)object {
    
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
