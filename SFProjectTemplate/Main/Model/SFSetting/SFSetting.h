//
//  SFSetting.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/5/11.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFTableViewCell.h"

@interface SFSettingItem : NSObject

@property (nonatomic, assign) SFSettingItemType type;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, strong) NSString *subImageName;
@property (nonatomic, strong) NSMutableArray *subImages;
@property (nonatomic, strong) NSURL *subImageURL;

- (id) initWithTitle:(NSString *)title;
- (id) initWithTitle:(NSString *)title subImageName:(NSString *)subImageName;
- (id) initWithTitle:(NSString *)title subImages:(NSMutableArray *)subImages;
- (id) initWithTitle:(NSString *)title type:(SFSettingItemType)type;
- (id) initWithTitle:(NSString *)title imageName:(NSString *)imageName;
- (id) initWithTitle:(NSString *)title subTitle:(NSString *)subTitle;
- (id) initWithTitle:(NSString *)title subTitle:(NSString *)subTitle type:(SFSettingItemType)type;
- (id) initWithTitle:(NSString *)title subImageName:(NSString *)subImageName type:(SFSettingItemType)type;

- (id) initWithTitle:(NSString *)title subTitle:(NSString *)subTitle imageName:(NSString *)imageName subImageName:(NSString *)subImageName;
- (id) initWithTitle:(NSString *)title subTitle:(NSString *)subTitle imageName:(NSString *)imageName subImageName:(NSString *)subImageName type:(SFSettingItemType)type;
- (id) initWithTitle:(NSString *)title subTitle:(NSString *)subTitle imageName:(NSString *)imageName subImageURL:(NSURL *)subImageURL type:(SFSettingItemType)type;

@end

@interface SFSettingGrounp : NSObject

@property (nonatomic, strong) NSString *headerTitle;
@property (nonatomic, strong) NSString *footerTitle;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, assign) NSUInteger itemsCount;

- (id) initWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle settingItems:(SFSettingItem *)firstObj, ...;

- (SFSettingItem *) itemAtIndex:(NSUInteger)index;

@end
