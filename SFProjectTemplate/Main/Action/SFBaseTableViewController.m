//
//  SFBaseTableViewController.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/18.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFBaseTableViewController.h"
#import "SFRefreshHeader.h"
#import "SFRefreshFooter.h"

#define SFKCellIdentifier @"TableViewCell"

@interface SFBaseTableViewController () <UIScrollViewDelegate, UIGestureRecognizerDelegate>{
    HeaderAction _headerAction;
    FooterAction _footerAction;
    BOOL autoRefresh;
    CGFloat _oldPanOffsetY;
}

@end

@implementation SFBaseTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        autoRefresh = YES;
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
        self.pageNum = 1;
    }
    return self;
}

- (void)initControllerData{};

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initTableView];
    
    [self loadDataSources];
}

// 重写 加载数据源
- (void)loadDataSources
{
    [self showRuningMan];
    
    WeakSelf
    [weakSelf_SC asyncBackgroundQueue:^{
        
        // 填充数据
        for (NSInteger i = 0; i < 5; i++) {
            
            [weakSelf_SC.dataArray addObject:SFRandomData];
        }
        
        // 延迟加载
        sleep(3.0f);
        
        [weakSelf_SC asyncMainQueue:^{
            
            [weakSelf_SC hideRuningMan];
            
            [weakSelf_SC.tableView reloadData];
        }];
    }];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)initTableView
{
    self.view.backgroundColor = DEFAULT_BACKGROUND_COLOR;

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    
    // 消除多余的 cell 横线
    [self setExtraCellLineHidden:self.tableView];

    [self.view addSubview:self.tableView];
}

- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark 显示影藏加载小人
- (void)showRuningMan
{
    [super showRuningMan];
    
    [self.tableView setHidden:YES];
}

- (void)hideRuningMan
{
    [super hideRuningMan];
    
    [self.tableView setHidden:NO];
}

#pragma mark 显示影藏 页面加载失败
- (void)showLoadFail
{
    [super showLoadFail];
    [self endRefresh];
    [self.tableView setHidden:YES];
}

- (void)hideLoadFail
{
    [super hideLoadFail];
    [self endRefresh];
    [self.tableView setHidden:NO];
}

- (void)hideLoadingAndLoadFail
{
    [super hideLoadingAndLoadFail];
    [self endRefresh];
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
    return 100.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SFKCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SFKCellIdentifier];
        cell.textLabel.text = SFRandomData;
        cell.backgroundColor = COLOR_RANDOM;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

#pragma mark 自动加载更多
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row + 4 == [self.dataArray count] && [self.dataArray count] >= 20) {
        if (!self.tableView.mj_footer.isRefreshing) {
            [self.tableView.mj_footer beginRefreshing];
        }
    }
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark 上拉加载，下拉刷新

- (void)addRefreshBlockWithHeader:(HeaderAction)headerAction AndFooter:(FooterAction)footerAction autoRefresh:(BOOL)autoRe
{
    _headerAction = headerAction;
    _footerAction = footerAction;
    autoRefresh = autoRe;
    
    WeakSelf
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    if (_headerAction) {
        SFRefreshHeader *header = [SFRefreshHeader headerWithRefreshingBlock:^{

            [weakSelf_SC headerRereshing];
        }];
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        header.automaticallyChangeAlpha = YES;
        // 隐藏时间
        header.lastUpdatedTimeLabel.hidden = YES;
        // 隐藏状态
        header.stateLabel.hidden = YES;

        self.tableView.mj_header = header;
    }

    // 是否自动加载
    if (autoRefresh && _headerAction) {
        [self.tableView.mj_header beginRefreshing];
    }
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    if (_footerAction) {
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            [weakSelf_SC footerRereshing];
        }];
     }
}

- (void)addRefreshBlockWithFooter:(void (^)())footerAction
{
    _footerAction = footerAction;
    
    WeakSelf
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    if (_footerAction) {
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            [weakSelf_SC footerRereshing];
        }];
    }
}

- (void)headerRereshing
{
    // 重置上拉刷新控件的状态
    if (self.tableView.mj_footer) {
        [self.tableView.mj_footer resetNoMoreData];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endRefresh) name:SFKNetWorkTaskFinish object:nil];
    if (_headerAction) {
        _headerAction();
    }
}

- (void)footerRereshing
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endRefresh) name:SFKNetWorkTaskFinish object:nil];
    if(_footerAction){
        _footerAction();
    };
}

- (void)endRefresh
{
    if (self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header endRefreshing];
    }
    
    if (self.tableView.mj_footer.isRefreshing) {
        [self.tableView.mj_footer endRefreshing];
    }
}

#pragma mark ScrollView Delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self scrollWillScroll];
    _oldPanOffsetY = [scrollView.panGestureRecognizer translationInView:scrollView.superview].y;
}



- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    _oldPanOffsetY = 0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentSize.height <= CGRectGetHeight(scrollView.bounds)-50) {
        [self scrollWillDown];
        return;
    }else if (scrollView.panGestureRecognizer.state == UIGestureRecognizerStateChanged){
        CGFloat nowPanOffsetY = [scrollView.panGestureRecognizer translationInView:scrollView.superview].y;
        CGFloat diffPanOffsetY = nowPanOffsetY - _oldPanOffsetY;
        //        CGFloat contentOffsetY = scrollView.contentOffset.y;
        if (diffPanOffsetY > 0.f) {
            [self scrollWillDown];
        }else if (ABS(diffPanOffsetY) > 50.f) {
            [self scrollWillUp];
            _oldPanOffsetY = nowPanOffsetY;
        }
    }
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}

- (void) scrollWillDown{}
- (void) scrollWillUp{}
- (void) scrollWillScroll{}

@end
