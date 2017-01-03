//
//  SFLogicManager.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/18.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFLogicManager.h"

@interface SFLogicManager ()

@property (nonatomic, strong) IQKeyboardManager *keyboardManager;
@property (nonatomic, strong) SFReachabilityManager *reachabilityManager;
@property (nonatomic, strong) SFUserManager *userManager;
@property (nonatomic, strong) SFWeChatManager *weChatManager;
@property (nonatomic, strong) SFQQManager *qQManager;
@property (nonatomic, strong) SFShareManager *shareManager;
@property (nonatomic, strong) SFTimerManager *timerManager;

@property (nonatomic, strong) SFProductManager *productManager;
@property (nonatomic, strong) SFBindBankCardManager *bindBankCardManager;

@property (nonatomic, strong) SFLoggingManager *loggingManager;
@property (nonatomic, strong) SFLagMonitorManager *lagMonitorManager;

@property (nonatomic, strong) SFViewControllerIntercepter *viewControllerIntercepter;

@end

@implementation SFLogicManager

+ (instancetype)shareInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)init
{
    if (self = [super init]) {
        
        // 日志收集
        [Bugly startWithAppId:@""];
        // 键盘管理
        _keyboardManager = [IQKeyboardManager sharedManager];
        // 网络监听
        _reachabilityManager = [SFReachabilityManager shareInstance];
        
        // 基础网络配置
        [HYBNetworking updateBaseUrl:SFKBaseURL];
        [HYBNetworking enableInterfaceDebug:YES];
        // 设置GET、POST请求都缓存
        [HYBNetworking cacheGetRequest:YES shoulCachePost:YES];
        
        // 微信相关
        _weChatManager = [SFWeChatManager shareInstance];
        // qq相关
        _qQManager = [SFQQManager shareInstance];
        // 分享相关
        _shareManager = [SFShareManager shareInstance];
        // 定时器
        _timerManager = [SFTimerManager shareInstance];
        
        // 用户管理
        _userManager = [SFUserManager shareInstance];
        // 产品管理
        _productManager = [SFProductManager shareInstance];
        // 绑卡
        _bindBankCardManager = [SFBindBankCardManager shareInstance];
        
        // 视图控制器拦截器
        _viewControllerIntercepter = [SFViewControllerIntercepter shareInstance];
        
        // 事件统计
        _loggingManager = [SFLoggingManager shareInstance];
        
        // 卡顿检测
        _lagMonitorManager = [SFLagMonitorManager shareInstance];
    }
    return self;
}

#pragma mark logic层统一管理协议方法

- (void)load
{
    // 开启键盘管理
    _keyboardManager.enable = YES;
    _keyboardManager.shouldResignOnTouchOutside = YES;
    _keyboardManager.shouldToolbarUsesTextFieldTintColor = YES;
    _keyboardManager.enableAutoToolbar = YES;
    
    // 开启网络监听
    [_reachabilityManager startNotifier];
    
    // 分享 注册先关信息
    [_shareManager registerShareParameters];
    
    // 注册事件统计
    [_loggingManager setupLogging];
    
    // 开启卡顿检测
//    [_lagMonitorManager beginMonitor];
}

- (SFReachabilityManager *)getReachabilityManager
{
    return _reachabilityManager;
}

- (SFWeChatManager *)getWeChatManager
{
    return _weChatManager;
}

- (SFQQManager *)getQQManager
{
    return _qQManager;
}

- (SFShareManager *)getShareManager
{
    return _shareManager;
}

- (SFTimerManager *)getTimerManager
{
    return _timerManager;
}

- (SFUserManager *)getUserManager
{
    return _userManager;
}

- (SFProductManager *)getProductManager
{
    return _productManager;
}

- (SFBindBankCardManager *)getBindBankCardManager
{
    return _bindBankCardManager;
}

-(SFViewControllerIntercepter *)getViewControllerIntercepter
{
    return _viewControllerIntercepter;
}

- (SFLoggingManager *)getLoggingManager
{
    return _loggingManager;
}

- (SFLagMonitorManager *)getLagMonitorManager
{
    return _lagMonitorManager;
}

@end
