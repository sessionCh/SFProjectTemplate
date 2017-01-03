//
//  SFShareManager.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/22.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFShareManager.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaSSOHandler.h"

@implementation SFShareManager


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
        [UMSocialData setAppKey:@"507fcab25270157b37000010"];
    }
    return self;
}

- (void)registerShareParameters
{
    //设置分享到QQ/Qzone的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:kSocial_QQ_ID appKey:kSocial_QQ_Secret url:kSocial_QQ_Url];
    
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:kSocial_WX_ID appSecret:kSocial_WX_Secret url:kSocial_WX_Url];
    
    //第一个参数为新浪appkey,第二个参数为新浪secret，第三个参数是新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954"
                                              secret:@"04b48b094faeb16683c32669824ebdad"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
}

/**
 *  分享
 */
- (void)shareWithType:(NSString *)type presentedController:(UIViewController *)controller successBlock:(ShareSuccessBlock)successBlock errorBlock:(ShareErrorBlock)errorBlock
{
    // 分享消息类型
    [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeDefault;
    // 分享消息类型
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
    
    // qq好友
    if ([UMShareToQQ isEqualToString:type]) {
        [UMSocialData defaultData].extConfig.qqData.title = @"QQ分享title";
        [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
    }
    // qq空间
    else if ([UMShareToQzone isEqualToString:type]) {
        
        [UMSocialData defaultData].extConfig.qzoneData.title = @"Qzone分享title";
        [UMSocialData defaultData].extConfig.qzoneData.url = @"http://baidu.com";
    }
    // 微信好友
    else if ([UMShareToWechatSession isEqualToString:type]) {
        [UMSocialData defaultData].extConfig.wechatSessionData.title = @"微信好友title";
        [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://baidu.com";
    }
    // 朋友圈
    else if ([UMShareToWechatTimeline isEqualToString:type]) {
        [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"微信朋友圈title";
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://baidu.com";
    }
    // 新浪
    else if ([UMShareToSina isEqualToString:type]) {
        [UMSocialData defaultData].extConfig.sinaData.shareText = @"新浪微博";
    }

    // 空间分享 图片必填
    UIImage *image = [UIImage imageNamed:@"Action_MyFavAdd"];
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[type] content:@"分享文字" image:image location:nil urlResource:nil presentedController:controller completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
            if (successBlock) {
                successBlock();
                return ;
            }
        }
        NSLog(@"分享失败！");
        if (errorBlock) {
            errorBlock(@"分享失败！");
        }
    }];
}

- (void)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
}

- (void)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
}

- (void)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
}

@end
