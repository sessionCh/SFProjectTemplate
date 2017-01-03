//
//  SFUserManager.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/19.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFUserManager.h"

@interface SFUserManager ()

@end

@implementation SFUserManager

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

/**
 *  获取用户信息
 *
 *  @param user    请求参数
 *  @param success 成功返回数据
 *  @param failure 失败返回错误信息
 *
 *  @return 返回请求对象
 */
- (SFURLSessionTask *)getUserInfo:(SFUserModel *)user success:(success)success failure:(failure)failure
{    
    return [HYBNetworking getWithUrl:SFKURL_AppMy refreshCache:YES params: @{@"userId": @(user.id),@"token": user.token} progress:^(int64_t bytesRead, int64_t totalBytesRead) {
        
        NSLog(@"progress: %f, cur: %lld, total: %lld",
              (bytesRead * 1.0) / totalBytesRead,
              bytesRead,
              totalBytesRead);

    } success:^(id response) {
        
        if (success) {
            success(response);
        }

    } fail:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

@end