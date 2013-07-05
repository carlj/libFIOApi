//
//  FIORequestOperation.m
//  libFIOApi
//
//  Created by carl.jahn on 27.03.13.
//  Copyright (c) 2013 Carl Jahn (https://github.com/carlj). All rights reserved.
//

#import "FIORequestOperation.h"
#import "AFJSONRequestOperation.h"
#import "FIORequestQueue.h"
@interface FIORequestOperation (){
  NSString *_apiKey;
}

@end

@implementation FIORequestOperation
@synthesize request = _request;

- (id)initWithAPIKey:(NSString *)apiKey {

  self = [super init];
  
  if (self) {
    _apiKey = apiKey;
  }
  
  return self;
  
}

- (void)setDate:(NSDate *)date {
  
  NSDate *nonGMT = date;
  
  NSTimeInterval timeZoneOffset = [[NSTimeZone defaultTimeZone] secondsFromGMT];
  NSTimeInterval gmtTimeInterval = [nonGMT timeIntervalSinceReferenceDate] - timeZoneOffset;
  NSDate *gmtDate = [NSDate dateWithTimeIntervalSinceReferenceDate:gmtTimeInterval];

  _date = gmtDate;
}

- (NSURLRequest *)request {
  NSAssert(_longitude, @"Longitude is missing");
  NSAssert(_latitude, @"Latitude is missing");
  NSAssert(_apiKey, @"API Key is missing");

  //https://api.forecast.io/forecast/APIKEY/LATITUDE,LONGITUDE(,TIME,SI)
  if (!_request) {
    
    NSString *baseURL = [kFIOApiEndPoint stringByAppendingPathComponent: _apiKey];
    NSArray *paramters = @[_latitude, _longitude];
    
    if (_date) {
      paramters = [paramters arrayByAddingObject: [NSNumber numberWithLong: [_date timeIntervalSince1970] ] ];
    }
 
    
    NSString *urlString = [baseURL stringByAppendingPathComponent: [paramters componentsJoinedByString:@","] ];
    
    if (_useSIUnits) {
      urlString = [urlString stringByAppendingString: @"?SI" ];
    }
    
    
    _request = [NSURLRequest requestWithURL: [NSURL URLWithString:urlString] ];
  }
  
  return _request;
}

- (void)requestFinishedWithJSON:(id)JSON {

  if (![NSThread isMainThread]) {
    [self performSelectorOnMainThread:@selector(requestFinishedWithJSON:) withObject:JSON waitUntilDone:NO];
    return;
  }
  
  if ([JSON isKindOfClass: [NSDictionary class]]) {
    NSDictionary *jsonDic = (NSDictionary *)JSON;
    
    NSString *errorValue = [jsonDic valueForKey:@"error"];
    if (errorValue) {

      NSDictionary *errorDetail = @{ NSLocalizedDescriptionKey : errorValue, NSURLErrorKey : _request.URL, @"code" : [jsonDic valueForKey:@"code"] };

      NSError *error = [NSError errorWithDomain:kFIOApiEndPoint code: NSExecutableLoadError userInfo: errorDetail];
      [self requestFailedWithError: error];
      return;
    }
  }

  
  [self executeFinishedTaskWithResponse: JSON];
  
  //finish the task
  [super requestFinishedWithJSON:JSON];
}


- (void)requestFailedWithError:(NSError *)error {

  if (![NSThread isMainThread]) {
    [self performSelectorOnMainThread:@selector(requestFailedWithError:) withObject:error waitUntilDone:NO];
    return;
  }

  [self executeFailedTaskWithError: error];
  
  //finish the task
  [super requestFailedWithError:error];
}



- (void)executeFinishedTaskWithResponse:(id)response {
  return;
}

- (void)executeFailedTaskWithError:(NSError *)error {
  return;
}


- (void)executeOperationInSharedQueue {

  [[FIORequestQueue sharedQueue] addOperation: self];
}


@end
