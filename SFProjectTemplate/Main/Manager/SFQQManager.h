//
//  SFQQManager.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/22.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFBaseManager.h"

typedef void (^ShareSuccessBlock)();
typedef void (^ShareErrorBlock)(NSString *error);

@interface SFQQManager : SFBaseManager <SFOpenURLProtocol>

+ (instancetype)shareInstance;

#pragma mark - 初始化信息
- (void)setQQWithAppId:(NSString *)appId appKey:(NSString *)appKey url:(NSString *)url;

/**
 *  分享到QQ
 */
- (void)shareWithType:(NSString *)type presentedController:(UIViewController *)controller successBlock:(ShareSuccessBlock)successBlock errorBlock:(ShareErrorBlock)errorBlock;

@end
