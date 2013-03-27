//
//  FIORequestBlockOperation.h
//  libFIOApi
//
//  Created by carl.jahn on 27.03.13.
//  Copyright (c) 2013 Carl Jahn (carl.jahn@nidag.com), NIDAG GmbH. All rights reserved.
//

#import "FIORequestOperation.h"
#import "FIORequestBlock.h"

@interface FIORequestBlockOperation : FIORequestOperation

@property (nonatomic, copy) FIORequestFinishedBlock finishedBlock;
@property (nonatomic, copy) FIORequestFailedBlock failedBlock;

@end
