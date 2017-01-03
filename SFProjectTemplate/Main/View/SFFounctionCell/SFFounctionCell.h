//
//  SFFounctionCell.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/5/11.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFTableViewCell.h"
#import "SFSetting.h"

@interface SFFounctionCell : SFTableViewCell

// 一般Type
@property (nonatomic, strong) SFSettingItem *item;
@property (nonatomic, assign) CGFloat titleFontSize;
@property (nonatomic, assign) CGFloat subTitleFontSize;
@property (nonatomic, assign) UIColor *subTitleFontColor;

// buttonType 用
@property (nonatomic, assign) UIColor *buttonTitleColor;
@property (nonatomic, assign) UIColor *buttonBackgroundGColor;

- (void) addTarget:(id)target action:(SEL)action;

@end
