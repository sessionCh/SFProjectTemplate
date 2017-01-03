//
//  SFProductManager.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/28.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFBaseManager.h"

@interface SFProductManager : SFBaseManager

+ (instancetype)shareInstance;

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

@end
