//
//  SFLogicManager.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/18.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFBaseManager.h"

#import "SFReachabilityManager.h"

// 业务部分
#import "SFUserManager.h"
#import "SFProductManager.h"
#import "SFBindBankCardManager.h"

// 分享部分 由 SFShareManager 统一管理
#import "SFWeChatManager.h"
#import "SFQQManager.h"
#import "SFShareManager.h"
#import "SFTimerManager.h"

// 事件统计
#import "SFLoggingManager.h"

// 卡顿检测
#import "SFLagMonitorManager.h"

// 视图控制器拦截器
#import "SFViewControllerIntercepter.h"

// 获取 SFLogicManager单例 宏定义
#define logicShareInstance   [SFLogicManager shareInstance]

@interface SFLogicManager : SFBaseManager

+ (instancetype)shareInstance;

- (SFReachabilityManager *)getReachabilityManager;
- (SFWeChatManager *)getWeChatManager;
- (SFQQManager *)getQQManager;
- (SFShareManager *)getShareManager;
- (SFTimerManager *)getTimerManager;

- (SFUserManager *)getUserManager;
- (SFProductManager *)getProductManager;
- (SFBindBankCardManager *)getBindBankCardManager;

- (SFViewControllerIntercepter *)getViewControllerIntercepter;

- (SFLoggingManager *)getLoggingManager;

- (SFLagMonitorManager *)getLagMonitorManager;

@end
