//
//  SFMarkProductModel.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/28.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFBaseModel.h"

@interface SFMarkProductModel : SFBaseModel

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *awardRateDescr;

@property (nonatomic, copy) NSString *awardRateDescrUrl;

@property (nonatomic, copy) NSString *remainAmount;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *securityMode;

@property (nonatomic, copy) NSString *schedules;

@property (nonatomic, copy) NSString *imgPath;

@property (nonatomic, assign) long long tenderTime;

@property (nonatomic, copy) NSString *borrowAmount;

@property (nonatomic, assign) long long publishTime;

@property (nonatomic, copy) NSString *credit;

@property (nonatomic, assign) NSInteger tenderNum;

@property (nonatomic, assign) NSInteger isLate;

@property (nonatomic, assign) NSInteger isDayThe;

@property (nonatomic, assign) long long fullTenderTime;

@property (nonatomic, assign) NSInteger hasPWD;

@property (nonatomic, assign) NSInteger raiseTerm;

@property (nonatomic, assign) NSInteger schedule;

@property (nonatomic, assign) NSInteger activityType;

@property (nonatomic, copy) NSString *borrowWayClass;

@property (nonatomic, assign) NSInteger excitationType;

@property (nonatomic, assign) NSInteger borrowWay;

@property (nonatomic, assign) NSInteger remainTime;

@property (nonatomic, assign) NSInteger borrowStatus;

@property (nonatomic, assign) NSInteger creditrating;

@property (nonatomic, assign) NSInteger vipStatus;

@property (nonatomic, assign) NSInteger annualRate;

@property (nonatomic, copy) NSString *detailUrl;

@property (nonatomic, copy) NSString *logoUrl;

@property (nonatomic, copy) NSString *auditTime;

@property (nonatomic, assign) NSInteger awardAnnualRate;

@property (nonatomic, assign) NSInteger purpose;

@property (nonatomic, copy) NSString *canTurn;

@property (nonatomic, assign) NSInteger paymentMode;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *borrowTitle;

@property (nonatomic, assign) NSInteger vip;

@property (nonatomic, copy) NSString *activityPicUrl;

@property (nonatomic, assign) NSInteger deadline;

@property (nonatomic, assign) NSInteger amount;

@end
