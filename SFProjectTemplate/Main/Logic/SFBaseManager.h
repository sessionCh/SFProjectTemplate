//
//  SFBaseManager.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/18.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SFBaseProtocol.h"
#import "SFOpenURLProtocol.h"

typedef void (^success)(id json);
typedef void (^failure)(NSError *error);

typedef NSURLSessionTask SFURLSessionTask;

@interface SFBaseManager : NSObject  <SFBaseProtocol>

/**
 *  后台线程执行
 *
 *  @param block
 */
- (void) asyncBackgroundQueue:(void (^)())block;

@end
