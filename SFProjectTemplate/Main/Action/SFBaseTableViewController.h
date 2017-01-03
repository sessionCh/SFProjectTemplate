//
//  SFBaseTableViewController.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/18.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFBaseViewController.h"

typedef void (^HeaderAction)();
typedef void (^FooterAction)();

typedef enum  {
    LOAD_MORE = 0,    // 加载更多
    LOAD_UPDATE,           // 刷新
} LOAD_TYPE;

@interface SFBaseTableViewController : SFBaseViewController <UITableViewDataSource, UITableViewDelegate>

/**
 *  当前的TableView
 */
@property (nonatomic, retain) UITableView *tableView;

/**
 *  当前的数据数组
 */
@property (nonatomic, retain) NSMutableArray *dataArray;

/**
 *  当前的页数
 */
@property (nonatomic, assign) NSUInteger pageNum;

/**
 *  下拉刷新与上拉加载更多 (如果为nil则取消)
 *
 *  @param headerAction 下拉
 *  @param footerAction 上拉
 *  @param autoRe       是否自动加载
 */
- (void) addRefreshBlockWithHeader:(HeaderAction)headerAction AndFooter:(FooterAction)footerAction autoRefresh:(BOOL)autoRe;

/**
 *  @brief  添加一个Footer刷新
 *
 *  @param footerAction
 */
- (void) addRefreshBlockWithFooter:(void (^)())footerAction;

/**
 *  停止刷新
 */
- (void)endRefresh;

/**
 *  @brief  向上移动
 */
- (void) scrollWillUp;

/**
 *  @brief 向下移动
 */
- (void) scrollWillDown;

/**
 *  @brief 将要移动
 */
- (void) scrollWillScroll;

@end
