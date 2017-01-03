
//
//  SFWeChatManager.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/22.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFWeChatManager.h"
#import "UMSocialWechatHandler.h"

@interface SFWeChatManager ()

@property (nonatomic, copy)PaySuccessBlock paySuccessBlock;
@property (nonatomic, copy)PayErrorBlock payErrorBlock;

@end

@implementation SFWeChatManager

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
    if (self = [super init]){
    }
    return self;
}

- (void)setWXAppId:(NSString *)appId appSecret:(NSString *)appSecret url:(NSString *)url
{
    // 设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:appId appSecret:appSecret url:url];
}

#pragma mark 微信分享

/**
 *  分享到微信
 */
- (void)shareWithType:(NSString *)type presentedController:(UIViewController *)controller successBlock:(ShareSuccessBlock)successBlock errorBlock:(ShareErrorBlock)errorBlock
{
    // 分享消息类型
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
    
    // 微信好友
    if ([UMShareToWechatSession isEqualToString:type]){
        [UMSocialData defaultData].extConfig.wechatSessionData.title = @"微信好友title";
        [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://baidu.com";
    }
    // 朋友圈
    else if ([UMShareToWechatTimeline isEqualToString:type]){
        [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"微信朋友圈title";
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://baidu.com";
    }

    // 使用UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite分别代表微信好友、微信朋友圈、微信收藏
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[type] content:@"分享内嵌文字" image:nil location:nil urlResource:nil presentedController:controller completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess){
            NSLog(@"分享成功！");
            if (successBlock){
                successBlock();
                return ;
            }
        }
        NSLog(@"分享失败！");
        if (errorBlock){
            errorBlock(@"分享失败！");
        }
    }];
}

#pragma mark 微信支付

/**
 *  微信支付
 *
 *  @param wxpayment    支付实体
 *  @param successBlock 成功回调
 *  @param errorBlock   失败回调
 */
- (void)weChatPaymentWithWechatPayEntity:(SFWXPayEntity *)wxpayment
                         WithSuccessBlock:(PaySuccessBlock)successBlock
                               errorBlock:(PayErrorBlock)errorBlock{
    _paySuccessBlock = successBlock;
    _payErrorBlock = errorBlock;
    
    if (wxpayment){
        [WXApi sendReq:wxpayment];
    } else {
        errorBlock(@"请求微信失败,请重试!");
    }
}

#pragma mark Resp

- (void)onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[PayResp class]]){
        
        switch (resp.errCode){
            case WXSuccess:
                if (_paySuccessBlock){
                    _paySuccessBlock(@"支付成功!");
                }
                NSLog(@"微信支付支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;
                
            default:
                if (_payErrorBlock){
                    _payErrorBlock(resp.errStr);
                }
                NSLog(@"微信支付错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
    }
}



- (void)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE){
        //调用其他SDK，例如支付宝SDK等
    }
}

- (void)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE){
        //调用其他SDK，例如支付宝SDK等
    }
}

- (void)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE){
        //调用其他SDK，例如支付宝SDK等
    }
}

@end
