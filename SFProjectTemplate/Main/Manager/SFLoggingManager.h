//
//  SFLoggingManager.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/5/24.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFBaseManager.h"

@interface SFLoggingManager : SFBaseManager

+ (instancetype)shareInstance;

/**
 *  事件统计
 */
- (void)setupLogging;

@end
