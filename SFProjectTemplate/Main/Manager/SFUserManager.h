//
//  SFUserManager.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/19.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFBaseManager.h"

@interface SFUserManager : SFBaseManager

+ (instancetype)shareInstance;

/**
 *  获取用户信息
 *
 *  @param user    请求参数
 *  @param success 成功返回数据
 *  @param failure 失败返回错误信息
 *
 *  @return 返回请求对象
 */
- (SFURLSessionTask *)getUserInfo:(SFUserModel *)user success:(success)success failure:(failure)failure;

@end
