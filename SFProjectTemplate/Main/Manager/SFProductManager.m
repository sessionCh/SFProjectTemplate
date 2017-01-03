//
//  SFProductManager.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/28.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFProductManager.h"

@implementation SFProductManager

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
 *  分页获取散标
 *
 *  @param page    请求页码
 *  @param success
 *  @param failure
 *
 *  @return 返回请求对象
 */
- (SFURLSessionTask *)getMarkProductListWithPage:(NSInteger)page success:(success)success failure:(failure)failure;
{
 
    NSString *url = [SFKURL_BorrowApp stringByAppendingPathComponent:[NSString stringFromLongValue:page]];
    
    return [HYBNetworking getWithUrl:url refreshCache:YES params:nil progress:^(int64_t bytesRead, int64_t totalBytesRead) {
        
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
