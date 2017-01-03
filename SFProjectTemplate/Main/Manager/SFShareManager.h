//
//  SFShareManager.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/22.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFBaseManager.h"

typedef void (^ShareSuccessBlock)();
typedef void (^ShareErrorBlock)(NSString *error);

@interface SFShareManager : SFBaseManager <SFOpenURLProtocol>

+ (instancetype)shareInstance;

#pragma mark - 注册分享
- (void)registerShareParameters;

/**
 *  分享
 */
- (void)shareWithType:(NSString *)type presentedController:(UIViewController *)controller successBlock:(ShareSuccessBlock)successBlock errorBlock:(ShareErrorBlock)errorBlock;

@end
