
//
//  SFBindBankCardManager.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/7/11.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFBindBankCardManager.h"

@interface SFBindBankCardManager ()

// 持久化部分
@property (nonatomic, strong) LKDBHelper *globalHelper;

@end

@implementation SFBindBankCardManager

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
        _globalHelper = [SFCityModel getUsingLKDBHelper];
        NSString *dbPath = [[NSBundle mainBundle] pathForResource:@"ddy" ofType:@"sqlite"];
        [_globalHelper setDBPath:dbPath];
    }
    return self;
}

- (void)queryCityWithParentAreaId:(NSString *)parentAreaId callBackBlock:(QueryCityBlock)callBackBlock
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];

    [_globalHelper executeForTransaction:^BOOL(LKDBHelper *helper) {
        __block BOOL success = YES;
        
        NSString *searchWhere;
        if (parentAreaId) {
            searchWhere = [NSString stringWithFormat:@"parentAreaId is %@", parentAreaId];
        } else {
            searchWhere = @"parentAreaId is null";
        }
        
        NSArray *citys = [SFCityModel searchWithWhere:searchWhere orderBy:nil offset:0 count:NSIntegerMax];
        
        callBackBlock(citys);
        [SVProgressHUD dismiss];
        return success;
    }];
}

@end
