//
//  FIORequestBlock.h
//  libFIOApi
//
//  Created by carl.jahn on 27.03.13.
//  Copyright (c) 2013 Carl Jahn (https://github.com/carlj). All rights reserved.
//

#import <Foundation/Foundation.h>

@class FIORequestBlockOperation;
typedef void(^FIORequestFinishedBlock)(FIORequestBlockOperation *request, id response);
typedef void(^FIORequestFailedBlock)(FIORequestBlockOperation *request, NSError *error);
