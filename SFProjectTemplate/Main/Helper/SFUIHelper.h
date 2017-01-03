//
//  SFUIHelper.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/5/11.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFSetting.h"

@interface SFUIHelper : NSObject

+ (NSMutableArray *) getSettingVCItems;

+ (NSMutableArray *)getSettingVCItemsWith:(SFMyModel *)model;
@end
