//
//  SFGuaranteeViewController.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/18.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFGuaranteeViewController.h"
#import "SFFounctionCell.h"
#import "SFAvailableBalanceCell.h"

@interface SFGuaranteeViewController ()

@end

@implementation SFGuaranteeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[SFFounctionCell class] forCellReuseIdentifier:@"FunctionCell"];
    [self.tableView registerNib:[SFAvailableBalanceCell loadNibNamed:@"SFAvailableBalanceCell"] forCellReuseIdentifier:@"AvailableBalanceCell"];

    self.dataArray = [SFUIHelper getSettingVCItemsWith:nil];
    
    [self.tableView reloadData];
}

- (void)loadDataSources
{
    SFUserModel *userModel = [[SFUserModel alloc] init];
    userModel.id = 1236;
    userModel.token = @"13dfb0c54dbf3003b2b3692b4805a10b";
    
    [self showRuningMan];
    
    WeakSelf
    // 获取用户信息
    [self.currentRequest addObject:
     
     [[logicShareInstance getUserManager] getUserInfo:userModel success:^(id json) {
        
        SFMyModel *my = [SFMyModel yy_modelWithJSON:SFDealNullData(json)];
        
        weakSelf_SC.dataArray = [SFUIHelper getSettingVCItemsWith:my];
        
        [weakSelf_SC hideLoadingAndLoadFail];
        [weakSelf_SC.tableView reloadData];

    } failure:^(NSError *error) {
        
        [weakSelf_SC showLoadFail];
    }]
     ];
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SFSettingGrounp *group = [self.dataArray objectAtIndex:section];
    return group.itemsCount;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"FotterView"];
    if (view == nil){
        view = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"FotterView"];
        [view setBackgroundView:[UIView new]];
    }
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SFSettingGrounp *group = [self.dataArray objectAtIndex:indexPath.section];
    SFSettingItem *item = [group itemAtIndex: indexPath.row];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        SFAvailableBalanceCell *balance = [tableView dequeueReusableCellWithIdentifier:@"AvailableBalanceCell"];
        [balance setTopLineStyle:CellLineStyleNone];
        [balance setBottomLineStyle:CellLineStyleNone];
        balance.usableSumLab.text = item.subTitle;
        return balance;
    }
    
    SFFounctionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FunctionCell"];
    [cell setItem:item];
    item.type == SFSettingItemTypeMidTitle ? [cell setAccessoryType:UITableViewCellAccessoryNone] : [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    indexPath.row == 0 ? [cell setTopLineStyle:CellLineStyleNone] : [cell setTopLineStyle:CellLineStyleDefault];
    indexPath.row == group.itemsCount - 1 ? [cell setBottomLineStyle:CellLineStyleNone] : [cell setBottomLineStyle:CellLineStyleDefault];
    
    if (indexPath.section == 3 && indexPath.row == 1) {
        [cell setSubTitleFontColor:SFKColorDarkGray];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SFSettingGrounp *group = [self.dataArray objectAtIndex:indexPath.section];
    SFSettingItem *item = [group itemAtIndex: indexPath.row];
    if ([item.title isEqualToString:@""]){
    }
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
