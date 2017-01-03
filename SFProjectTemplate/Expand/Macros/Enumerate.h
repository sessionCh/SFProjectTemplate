//
//  Enumerate.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/5/11.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#ifndef Enumerate_h
#define Enumerate_h

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SFSettingItemType) {
    SFSettingItemTypeDefault,       // image, title, rightTitle, rightImage
    SFSettingItemTypeDefaultL,      // image, title, leftImage, rightTitle
    SFSettingItemTypeLeft,          // image, title, leftTitle, leftImage
    SFSettingItemTypeButton,        // button
    SFSettingItemTypeAvatar,        // title, avatar
    SFSettingItemTypeMidTitle,      // title
    SFSettingItemTypeSwitch,        // title， Switch
};

#endif /* Enumerate_h */
