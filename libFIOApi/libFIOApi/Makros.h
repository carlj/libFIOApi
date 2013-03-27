//
//  Makros.h
//  libFIOApi
//
//  Created by carl.jahn on 27.03.13.
//  Copyright (c) 2013 Carl Jahn (carl.jahn@nidag.com), NIDAG GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PerformTaskOnMainThreadWithBlock(Block) dispatch_async(dispatch_get_main_queue(), Block);
