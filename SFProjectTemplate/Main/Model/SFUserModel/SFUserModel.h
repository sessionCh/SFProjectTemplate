//
//  SFUserModel.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/19.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFBaseModel.h"

@interface SFUserModel : SFBaseModel

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *headImg;
@property (nonatomic, assign) double usableSum;
@property (nonatomic, copy) NSString *userName;

@end

@interface SFCardModel : SFBaseModel

@property (nonatomic, assign) double sum;
@property (nonatomic, assign) double total;
@property (nonatomic, assign) NSInteger type;

@end

@interface SFMyModel : SFBaseModel

@property (nonatomic, strong) NSArray<SFCardModel *> *card;
@property (nonatomic, assign) BOOL isbank;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) double privilege;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) SFUserModel *user;

@end
