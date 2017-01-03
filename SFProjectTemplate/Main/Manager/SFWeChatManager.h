//
//  SFWeChatManager.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/22.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFBaseManager.h"
#import "SFWXPayEntity.h"

typedef void (^ShareSuccessBlock)();
typedef void (^ShareErrorBlock)(NSString *error);

typedef void (^PaySuccessBlock)();
typedef void (^PayErrorBlock)(NSString *error);


@interface SFWeChatManager : SFBaseManager <SFOpenURLProtocol>

+ (instancetype)shareInstance;

#pragma mark - 初始化信息
- (void)setWXAppId:(NSString *)appId appSecret:(NSString *)appSecret url:(NSString *)url;

/**
 *  分享到微信
 */
- (void)shareWithType:(NSString *)type presentedController:(UIViewController *)controller successBlock:(ShareSuccessBlock)successBlock errorBlock:(ShareErrorBlock)errorBlock;

/**
 *  微信支付
 *
 *  @param wxpayment    支付实体
 *  @param successBlock 成功回调
 *  @param errorBlock   失败回调
 */
- (void) weChatPaymentWithWechatPayEntity:(SFWXPayEntity *)wxpayment
                         WithSuccessBlock:(PaySuccessBlock)successBlock
                               errorBlock:(PayErrorBlock)errorBlock;


@end
