//
//  SFOpenURLProtocol.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/22.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//  访问第三方应用 回调

#import <Foundation/Foundation.h>

@protocol SFOpenURLProtocol <NSObject>

@required

- (void)application:(UIApplication *)application handleOpenURL:(NSURL *)url;
- (void)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
// 新Api
- (void)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options;

@end
