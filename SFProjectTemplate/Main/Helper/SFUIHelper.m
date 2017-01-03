//
//  SFUIHelper.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/5/11.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFUIHelper.h"
#import "SFUserModel.h"

@implementation SFUIHelper


+ (NSMutableArray *)getSettingVCItems
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    SFSettingItem *item1_1 = [[SFSettingItem alloc] initWithTitle:@"可用余额" subTitle:@"0.00"];
    SFSettingGrounp *group1 = [[SFSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:item1_1, nil];
    [items addObject:group1];
    
    SFSettingItem *item2_1 = [[SFSettingItem alloc] initWithTitle:@"理财金计划" subTitle:@"0.00" type:SFSettingItemTypeDefaultL];
    SFSettingItem *item2_2 = [[SFSettingItem alloc] initWithTitle:@"散标优品" subTitle:@"0.00" type:SFSettingItemTypeDefaultL];
    SFSettingGrounp *group2 = [[SFSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:item2_1, item2_2, nil];
    [items addObject:group2];
    
    SFSettingItem *item3_1 = [[SFSettingItem alloc] initWithTitle:@"我的特权" subTitle:@"0个" type:SFSettingItemTypeDefaultL];
    SFSettingGrounp *group3 = [[SFSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:item3_1, nil];
    [items addObject:group3];
    
    SFSettingItem *item4_1 = [[SFSettingItem alloc] initWithTitle:@"交易记录"];
    SFSettingItem *item4_2 = [[SFSettingItem alloc] initWithTitle:@"我的银行卡" subTitle:@"已绑定" type:SFSettingItemTypeDefaultL];

    SFSettingGrounp *group4 = [[SFSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:item4_1, item4_2, nil];
    [items addObject:group4];
    
    SFSettingItem *item5_1 = [[SFSettingItem alloc] initWithTitle:@"400-990-8222(9:00-22:00)" type:SFSettingItemTypeMidTitle];
    
    SFSettingGrounp *group5 = [[SFSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:item5_1, nil];
    [items addObject:group5];
    
    return items;
}

+ (NSMutableArray *)getSettingVCItemsWith:(SFMyModel *)model
{
    NSString *usableSum     = @"0.00";
    NSString *licaiSum      = @"0.00";
    NSString *sanbiaoSum    = @"0.00";
    if (model.card.count > 3) {
        licaiSum    = [NSString stringWithFormat:@"%.2f", model.card[1].total];
        sanbiaoSum  = [NSString stringWithFormat:@"%.2f", model.card[3].total];
    }
    if (model.user.usableSum > 0) {
        usableSum   = [NSString stringWithFormat:@"%.2f", model.user.usableSum];
    }

    NSMutableArray *items = [[NSMutableArray alloc] init];
    SFSettingItem *item1_1 = [[SFSettingItem alloc] initWithTitle:@"可用余额" subTitle:usableSum];
    SFSettingGrounp *group1 = [[SFSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:item1_1, nil];
    [items addObject:group1];
    
    SFSettingItem *item2_1 = [[SFSettingItem alloc] initWithTitle:@"理财金计划" subTitle:licaiSum type:SFSettingItemTypeDefaultL];
    SFSettingItem *item2_2 = [[SFSettingItem alloc] initWithTitle:@"散标优品" subTitle:sanbiaoSum type:SFSettingItemTypeDefaultL];
    SFSettingGrounp *group2 = [[SFSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:item2_1, item2_2, nil];
    [items addObject:group2];
    
    SFSettingItem *item3_1 = [[SFSettingItem alloc] initWithTitle:@"我的特权" subTitle:@"0个" type:SFSettingItemTypeDefaultL];
    SFSettingGrounp *group3 = [[SFSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:item3_1, nil];
    [items addObject:group3];
    
    SFSettingItem *item4_1 = [[SFSettingItem alloc] initWithTitle:@"交易记录"];
    SFSettingItem *item4_2 = [[SFSettingItem alloc] initWithTitle:@"我的银行卡" subTitle:@"已绑定" type:SFSettingItemTypeDefaultL];
    
    SFSettingGrounp *group4 = [[SFSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:item4_1, item4_2, nil];
    [items addObject:group4];
    
    SFSettingItem *item5_1 = [[SFSettingItem alloc] initWithTitle:@"400-990-8222(9:00-22:00)" type:SFSettingItemTypeMidTitle];
    
    SFSettingGrounp *group5 = [[SFSettingGrounp alloc] initWithHeaderTitle:nil footerTitle:nil settingItems:item5_1, nil];
    [items addObject:group5];
    
    return items;
}

@end
