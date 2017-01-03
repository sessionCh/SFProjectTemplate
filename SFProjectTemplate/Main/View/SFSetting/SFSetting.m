
//
//  SFSetting.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/5/11.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFSetting.h"

@implementation SFSettingItem

- (id) initWithTitle:(NSString *)title
{
    return [self initWithTitle:title subTitle:nil imageName:nil subImageName:nil type:SFSettingItemTypeDefault];
}

- (id) initWithTitle:(NSString *)title subImageName:(NSString *)subImageName
{
    return [self initWithTitle:title subTitle:nil imageName:nil subImageName:subImageName type:SFSettingItemTypeDefault];
}

- (id) initWithTitle:(NSString *)title type:(SFSettingItemType)type
{
    return [self initWithTitle:title subTitle:nil imageName:nil subImageName:nil type:type];
}

- (id) initWithTitle:(NSString *)title subImages:(NSMutableArray *)subImages
{
    _subImages = subImages;
    return [self initWithTitle:title type:SFSettingItemTypeLeft];
}

- (id) initWithTitle:(NSString *)title imageName:(NSString *)imageName
{
    return [self initWithTitle:title subTitle:nil imageName:imageName subImageName:nil type:SFSettingItemTypeDefault];
}

- (id) initWithTitle:(NSString *)title subTitle:(NSString *)subTitle
{
    return [self initWithTitle:title subTitle:subTitle imageName:nil subImageName:nil type:SFSettingItemTypeDefault];
}

- (id) initWithTitle:(NSString *)title subTitle:(NSString *)subTitle type:(SFSettingItemType)type
{
    return [self initWithTitle:title subTitle:subTitle imageName:nil subImageName:nil type:type];
}

- (id) initWithTitle:(NSString *)title subImageName:(NSString *)subImageName type:(SFSettingItemType)type
{
    return [self initWithTitle:title subTitle:nil imageName:nil subImageName:subImageName type:type];
}

- (id) initWithTitle:(NSString *)title subTitle:(NSString *)subTitle imageName:(NSString *)imageName subImageName:(NSString *)subImageName
{
    return [self initWithTitle:title subTitle:subTitle imageName:imageName subImageName:subImageName type:SFSettingItemTypeDefault];
}

- (id) initWithTitle:(NSString *)title subTitle:(NSString *)subTitle imageName:(NSString *)imageName subImageName:(NSString *)subImageName type:(SFSettingItemType)type
{
    if (self = [super init]) {
        _title = title;
        _subTitle = subTitle;
        _imageName = imageName;
        _subImageName = subImageName;
        _subImageURL = nil;
        _type = type;
    }
    return self;
}

- (id) initWithTitle:(NSString *)title subTitle:(NSString *)subTitle imageName:(NSString *)imageName subImageURL:(NSURL *)subImageURL type:(SFSettingItemType)type
{
    if (self = [super init]) {
        _title = title;
        _subTitle = subTitle;
        _imageName = imageName;
        _subImageName = nil;
        _subImageURL = subImageURL;
        _type = type;
    }
    return self;
}

@end


@implementation SFSettingGrounp

- (id) initWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle settingItems:(SFSettingItem *)firstObj, ...
{
    if (self = [super init]) {
        _headerTitle = headerTitle;
        _footerTitle = footerTitle;
        _items = [[NSMutableArray alloc] init];
        va_list argList;
        if (firstObj) {
            [_items addObject:firstObj];
            va_start(argList, firstObj);
            id arg;
            while ((arg = va_arg(argList, id))) {
                [_items addObject:arg];
            }
            va_end(argList);
        }
    }
    return self;
}

- (SFSettingItem *) itemAtIndex:(NSUInteger)index
{
    return [_items objectAtIndex:index];
}

- (NSUInteger) itemsCount
{
    return _itemsCount = _items.count;
}

@end