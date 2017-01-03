//
//  SFCityModel.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/7/11.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFBaseModel.h"

@interface SFCityModel : SFBaseModel

@property (nonatomic, assign) NSInteger areaId;
@property (nonatomic, copy) NSString *areaName;
@property (nonatomic, assign) NSInteger parentAreaId;

@property (nonatomic, assign) NSInteger row;

@end
