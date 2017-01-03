//
//  SFQQManager.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/22.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFQQManager.h"
#import "UMSocialQQHandler.h"

@implementation SFQQManager

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

- (void)setQQWithAppId:(NSString *)appId appKey:(NSString *)appKey url:(NSString *)url
{
    //设置分享到QQ/Qzone的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:appId appKey:appKey url:url];
}

/**
 *  分享到QQ
 */
- (void)shareWithType:(NSString *)type presentedController:(UIViewController *)controller successBlock:(ShareSuccessBlock)successBlock errorBlock:(ShareErrorBlock)errorBlock
{
    // 分享消息类型
    [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeDefault;
    
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
