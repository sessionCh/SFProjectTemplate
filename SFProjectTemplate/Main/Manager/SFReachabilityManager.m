//
//  SFReachabilityManager.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/18.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFReachabilityManager.h"
#import "AFNetworking.h"

@interface SFReachabilityManager ()

@end

@implementation SFReachabilityManager

+ (instancetype)shareInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}

- (void)startNotifier
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStateChange) name:kReachabilityChangedNotification object:nil];
    Reachability * reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
}

- (void)networkStateChange
{
    NSString * reachableVia = @"当前网络不可用，请检查网络连接!";
    
    // 检测wifi状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    
    // 检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    
    // 判断网络状态
    if ([wifi currentReachabilityStatus] != NotReachable) { // 有wifi
        
        reachableVia = @"WIFI已连接";
        
    } else if ([conn currentReachabilityStatus] != NotReachable) { // 没有使用wifi, 使用手机自带网络进行上网
        switch ([conn currentReachabilityStatus]) {
            case ReachableVia2G:
                reachableVia = @"切换至2G网络";
                break;
            case ReachableVia3G:
                reachableVia = @"切换至3G网络";
                break;
            case ReachableVia4G:
                reachableVia = @"切换至4G网络";
                break;
            default:
                reachableVia = @"切换至手机网络";
                break;
        }
    }
    NSDictionary *options = @{
                              kCRToastTextKey : reachableVia,
                              kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                              kCRToastBackgroundColorKey : SFKColorGolden,
                              kCRToastAnimationInTypeKey : @(CRToastAnimationTypeSpring),
                              kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeSpring),
                              kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
                              kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop)
                              };
    [CRToastManager showNotificationWithOptions:options
                                completionBlock:^{
                                }];

}

@end
