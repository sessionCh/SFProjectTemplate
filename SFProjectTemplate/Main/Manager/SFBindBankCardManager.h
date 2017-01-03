//
//  SFBindBankCardManager.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/7/11.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFBaseManager.h"
#import "SFCityModel.h"

typedef void (^QueryCityBlock)(NSArray<SFCityModel *> *citys);

@interface SFBindBankCardManager : SFBaseManager

+ (instancetype)shareInstance;

- (void)queryCityWithParentAreaId:(NSString *)parentAreaId callBackBlock:(QueryCityBlock)callBackBlock;

@end
