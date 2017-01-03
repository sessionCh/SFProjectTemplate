//
//  SFUserModel.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/19.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFUserModel.h"

@implementation SFUserModel

@end

@implementation SFCardModel

@end

@implementation SFMyModel

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"card" : [SFCardModel class]};
}

@end
