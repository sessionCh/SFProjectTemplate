//
//  SFLagMonitorManager.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/6/1.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//  卡顿检测

#import "SFBaseManager.h"

@interface SFLagMonitorManager : SFBaseManager

+ (instancetype)shareInstance;

- (void)beginMonitor; //开始监视卡顿
- (void)endMonitor;   //停止监视卡顿

@end
