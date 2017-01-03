//
//  SFFinanceViewController.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/18.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFFinanceViewController.h"
#import "SFMarkProductModel.h"
#import "SFMarkProductCell.h"
#import "SFMarkProductModelAdapter.h"

#import "SFNumberPickerView.h"

#import "SFPopView.h"

#import "SFDropDownHeaderView.h"
#import "SFDropDownView.h"
#import "DropDownMacros.h"

#import "SFCalendarView.h"

#define SFKCellIdentifier @"SFMarkProductCell"

@interface SFFinanceViewController ()

@property (nonatomic, strong) SFDropDownHeaderView *dropDownHeaderView;
@property (nonatomic, strong) SFDropDownView *dropDownView;
@property (nonatomic, strong) SFCalendarView *calendarView;

@property (nonatomic, strong) NSMutableArray *dataOne;
@property (nonatomic, strong) NSMutableArray *dataTwo;
@end

@implementation SFFinanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        [self.tableView registerNib:[SFMarkProductCell loadNibNamed:@"SFMarkProductCell"] forCellReuseIdentifier:SFKCellIdentifier];
    
        [self setupRefresh];
    
        WeakSelf
        [[logicShareInstance getTimerManager] callBackWithSMSCodeTimerAction:^(NSTimeInterval timeValue, SFTimerType type) {
    
            if (weakSelf_SC.dataArray.count > 0 && timeValue > 100) {
                SFMarkProductModel *newModel = [weakSelf_SC.dataArray lastObject];
                [weakSelf_SC.dataArray insertObject:newModel atIndex:0];
                [weakSelf_SC.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
            } else if (weakSelf_SC.dataArray.count > 0 && timeValue < 100) {
                [weakSelf_SC.dataArray removeObjectAtIndex:0];
                [weakSelf_SC.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
            }
        }];
    
    //    [[logicShareInstance getTimerManager] startTimer:SFTimerTypeSMSCode];
    
    //    SFNumberPickerView *npv = [SFNumberPickerView numberPickerView];
    //    [self.view addSubview:npv];
    //    [[logicShareInstance getTimerManager] callBackWithSMSCodeTimerAction:^(NSTimeInterval timeValue, SFTimerType type) {
    //
    //        if (timeValue < 60) {
    //            [npv.pickerView selectRow:timeValue inComponent:0 animated:YES];
    //        }
    //        if (timeValue < 71) {
    //            [npv.pickerView selectRow:timeValue inComponent:1 animated:YES];
    //        }
    //        if (timeValue < 82) {
    //            [npv.pickerView selectRow:timeValue inComponent:2 animated:YES];
    //        }
    //        if (timeValue > 100) {
    //            [[logicShareInstance getTimerManager] stopTimer:SFTimerTypeSMSCode];
    //        }
    //    }];
    //    [[logicShareInstance getTimerManager] startTimer:SFTimerTypeSMSCode];
    
    _dataOne = @[@"全部分类",
                 @"手机数码",
                 @"电脑办公",
                 @"家用电器",
                 @"化妆个护",
                 @"钟表首饰",
                 @"食品安全",
                 @"运动健身",
                 @"其他商品",
                 @"限购专区"
                 ].mutableCopy;
    
    _dataTwo = @[@"即将揭晓",
                 @"人气",
                 @"最新",
                 @"价值（由高到低）"
                 ].mutableCopy;

    
    [self.view addSubview:self.dropDownView];
    [self.view addSubview:self.dropDownHeaderView];
    [self.view addSubview:self.calendarView];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

- (SFDropDownHeaderView *)dropDownHeaderView
{
    if (!_dropDownHeaderView) {
        _dropDownHeaderView = [[SFDropDownHeaderView alloc] init];
        _dropDownHeaderView.frame = CGRectMake(0, 0, self.view.width, 44.0f);
        _dropDownHeaderView.dataArray = @[@"全部分类",
                                          @"即将揭晓"].mutableCopy;
        WeakSelf
        [_dropDownHeaderView didSelectItemBlock:^(NSIndexPath *indexPath, NSString *title) {
            
            if (weakSelf_SC.dropDownHeaderView.selectIndex == indexPath.row &&
                [weakSelf_SC.dropDownView getIsShow]) {
                [weakSelf_SC.dropDownView dismiss];
                return ;
            }
            
            weakSelf_SC.dropDownHeaderView.selectIndex = indexPath.row; // 设置当前选中的菜单
            weakSelf_SC.dropDownView.selectIndex = indexPath.section; // 设置弹出菜单默认选择索引
            if (indexPath.row == 0) { // 左侧菜单
                weakSelf_SC.dropDownView.dataArray = weakSelf_SC.dataOne;
                [weakSelf_SC.dropDownView setRow:3]; // 设置多行显示
                [weakSelf_SC.dropDownView setStyle:SFDropDownCellStyleDefault];
            } else if (indexPath.row == 1) { // 右侧菜单
                weakSelf_SC.dropDownView.dataArray = weakSelf_SC.dataTwo;
                [weakSelf_SC.dropDownView setRow:1]; // 设置单行显示
                [weakSelf_SC.dropDownView setStyle:SFDropDownCellStyleSingle];
            }
            [weakSelf_SC.dropDownView show];
        }];
    }
    return _dropDownHeaderView;
}

- (SFDropDownView *)dropDownView
{
    if (!_dropDownView) {
        _dropDownView = [[SFDropDownView alloc] init];
        [_dropDownView setCollectionFrame:CGRectMake(0, self.dropDownHeaderView.bottom + 60, self.view.width, 44.0f)];
        _dropDownView.style = SFDropDownCellStyleSingle;
        WeakSelf
        [_dropDownView didSelectItemBlock:^(NSIndexPath *indexPath, NSString *title) {
            
            [weakSelf_SC.dropDownHeaderView updateUI:[NSIndexPath indexPathForRow:weakSelf_SC.dropDownHeaderView.selectIndex inSection:indexPath.row] title:title];
            [weakSelf_SC.dropDownView dismiss];
        }];
        
        [_dropDownView dismissCompletionBlock:^{
            [weakSelf_SC.dropDownHeaderView changeSelectedColor:KDefaultColor];
        }];
    }
    return _dropDownView;
}

- (SFCalendarView *)calendarView
{
    if (!_calendarView) {
        
        _calendarView = [[[NSBundle mainBundle] loadNibNamed:@"SFCalendarView" owner:nil options:nil] firstObject];
        _calendarView.frame = CGRectMake(0, 100.f, self.view.width, 350.f);
    }
    
    return _calendarView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// 子类 重写该方法
#pragma mark 首次加载,显示加载小人
- (void)loadDataSources {
    
    return ;
    
    self.pageNum = 1;
    [self showRuningMan];
    WeakSelf
    // 获取散标信息
    [self.currentRequest addObject:
     [[logicShareInstance getProductManager] getMarkProductListWithPage:self.pageNum success:^(id json) {
        
        [weakSelf_SC asyncBackgroundQueue:^{
            
            // 移除数据
            [weakSelf_SC.dataArray removeAllObjects];
            
            NSArray *jsonArr = SFDealNullData(json)[@"borrowsPage"][@"page"];
            
            [weakSelf_SC.dataArray addObjectsFromArray:[NSArray yy_modelArrayWithClass:[SFMarkProductModel class] json:jsonArr]];
            
            [weakSelf_SC asyncMainQueue:^{
                [weakSelf_SC hideLoadingAndLoadFail];
                [weakSelf_SC.tableView reloadData];
            }];
        }];
    } failure:^(NSError *error) {
        
        [weakSelf_SC showLoadFail];
    }]
     ];
}

#pragma mark 上拉加载，下拉刷新
- (void)setupRefresh
{
    WeakSelf
    [weakSelf_SC addRefreshBlockWithHeader:^{
        // 取消当前所有网络请求
        [weakSelf_SC cancelCurrentNetWorkRequest];
        
        [weakSelf_SC loadNewData];
        
    } AndFooter:^{
        // 取消当前所有网络请求
        [weakSelf_SC cancelCurrentNetWorkRequest];
        
        [weakSelf_SC loadMoreData];
        
    } autoRefresh:NO];
}

#pragma mark - 数据处理相关
#pragma mark 下拉刷新数据
- (void)loadNewData
{
    self.pageNum = 1;
    WeakSelf
    // 获取散标信息
    [self.currentRequest addObject:
     
     [[logicShareInstance getProductManager] getMarkProductListWithPage:self.pageNum success:^(id json) {
        
        [weakSelf_SC asyncBackgroundQueue:^{
            
            // 移除数据
            [weakSelf_SC.dataArray removeAllObjects];
            NSArray *jsonArr = SFDealNullData(json)[@"borrowsPage"][@"page"];
            [weakSelf_SC.dataArray addObjectsFromArray:[NSArray yy_modelArrayWithClass:[SFMarkProductModel class] json:jsonArr]];
            
            [weakSelf_SC asyncMainQueue:^{
                [weakSelf_SC hideLoadingAndLoadFail];
                [weakSelf_SC.tableView reloadData];
            }];
        }];
    } failure:^(NSError *error) {
        
        [weakSelf_SC showLoadFail];
    }]
     ];
}

#pragma mark 上拉加载更多数据
- (void)loadMoreData
{
    if (self.dataArray.count > 30) {
        // 没有更多数据的状态
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return ;
    }
    WeakSelf
    // 获取散标信息
    [self.currentRequest addObject:
     
     [[logicShareInstance getProductManager] getMarkProductListWithPage:++self.pageNum success:^(id json) {
        
        [weakSelf_SC asyncBackgroundQueue:^{
            
            NSArray *jsonArr = SFDealNullData(json)[@"borrowsPage"][@"page"];
            [weakSelf_SC.dataArray addObjectsFromArray:[NSArray yy_modelArrayWithClass:[SFMarkProductModel class] json:jsonArr]];
            
            [weakSelf_SC asyncMainQueue:^{
                [weakSelf_SC hideLoadingAndLoadFail];
                [weakSelf_SC.tableView reloadData];
            }];
        }];
        
    } failure:^(NSError *error) {
        
        [weakSelf_SC showLoadFail];
    }]
     ];
}


#pragma mark TableView 相关
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SFMarkProductCell *cell = [tableView dequeueReusableCellWithIdentifier:SFKCellIdentifier];
    SFMarkProductModel *model = self.dataArray[indexPath.row];
    SFMarkProductModelAdapter *adapter = [[SFMarkProductModelAdapter alloc] initWithData:model];
    [cell loadData:adapter];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
