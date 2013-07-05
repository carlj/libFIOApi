//
//  FIORequestDelegateOperation.h
//  libFIOApi
//
//  Created by carl.jahn on 27.03.13.
//  Copyright (c) 2013 Carl Jahn (https://github.com/carlj). All rights reserved.
//

#import "FIORequestOperation.h"
#import "FIORequestOperationDelegate.h"

@interface FIORequestDelegateOperation : FIORequestOperation

@property (nonatomic, assign) id<FIORequestOperationDelegate> delegate;

@end
