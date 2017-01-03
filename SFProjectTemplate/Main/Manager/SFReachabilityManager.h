//
//  SFReachabilityManager.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/18.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFBaseManager.h"

@interface SFReachabilityManager : SFBaseManager

+ (instancetype)shareInstance;

/**
 *  启用网络检测
 */
- (void) startNotifier;

@end
