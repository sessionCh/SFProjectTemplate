//
//  SFBaseViewController.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/18.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFBaseViewController.h"
#import "SFLoading.h"
#import "SFLoadFail.h"

@interface SFBaseViewController ()

// 页面正在加载
@property (nonatomic, strong) SFLoading *loading;
// 页面加载失败
@property (nonatomic, strong) SFLoadFail *loadFail;

@end

@implementation SFBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.currentRequest = [NSMutableArray arrayWithCapacity:1];

        // 在iOS 7中，苹果引入了一个新的属性，叫做[UIViewController setEdgesForExtendedLayout:]，它的默认值为UIRectEdgeAll。当你的容器是navigation controller时，默认的布局将从navigation bar的顶部开始。这就是为什么所有的UI元素都往上漂移了44pt。
        if(isIOS7) {
            if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
                [self setEdgesForExtendedLayout:0];
            }
        }
    }
        
    return self;
}

#pragma mark viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
//    if (self.navigationController.viewControllers.count == 1) {
//        [self addTabBarVCGestureRecognizer];
//    }
    
    if (self.navigationController.viewControllers.count > 1) {
        [self addLeftBarButton];
    }
    
    [self loadDataSources];
}

- (void)addLeftBarButton
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom]; [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    WeakSelf
    [leftBtn bk_whenTapped:^{
        [weakSelf_SC.navigationController popViewControllerAnimated:YES];
    }];
    leftBtn.frame = CGRectMake(0, 0, 60, 40);
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem  *leftItem =[[UIBarButtonItem alloc]initWithCustomView: leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    // 解决系统 右滑手势失效
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

/**
 *  加载数据资源
 */
- (void)loadDataSources
{
    // 显示 加载小人
    [self showRuningMan];
    WeakSelf
    [weakSelf_SC asyncBackgroundQueue:^{
        
        sleep(3.0f);
        
        [weakSelf_SC asyncMainQueue:^{
            
            // 影藏 加载小人
            [weakSelf_SC hideRuningMan];
        
            [weakSelf_SC showLoadFail];
        }];
    }];
}

#pragma mark 视图将要出现
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark 视图已经出现
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark 视图将要退出
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark 视图已经消失
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark 视图被销毁
- (void)dealloc
{
    // 取消网络连接
    [self cancelCurrentNetWorkRequest];

    NSString *currentClazzName = [NSString stringWithUTF8String:object_getClassName(self)];
    NSLog(@"--> (%@已销毁)", currentClazzName);
}

#pragma mark 全局AppDelegate
-(AppDelegate *)mainDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

#pragma mark - 导航设置
#pragma mark 设置标题
- (void)setNavTitle:(NSString *)title
{
    self.title = title;
}

#pragma mark 取消当前页面的网络连接
- (void)cancelCurrentNetWorkRequest
{
    if (![self.currentRequest count]) {
        return;
    }
    
    @try {
        for (SFURLSessionTask *task in self.currentRequest) {
            // 取消网络
            [task cancel];
        }
    }
    @catch (NSException *exception) {}
    @finally {
        [self.currentRequest removeAllObjects];
    };
}

#pragma mark 显示影藏 页面加载中小人

- (SFLoading *)loading
{
    if (_loading == nil) {
        _loading = [[SFLoading alloc] initWithFrame:CGRectZero];
    }
    return _loading;
}

- (SFLoadFail *)loadFail
{
    if (_loadFail == nil) {
        _loadFail = [[SFLoadFail alloc] initWithFrame:CGRectZero];
    }
    return _loadFail;
}

- (void)showRuningMan
{
    [self hideLoadFail];

    if (self.loading.superview == self.view) {
        return;
    }
    self.loading.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height);
    self.loading.backgroundColor = SFKColorGray;
    [self.view addSubview:self.loading];
    [self.loading.superview bringSubviewToFront:self.loading];
}

- (void)hideRuningMan
{
    if (_loading) {
        [_loading removeFromSuperview];
        _loading = nil;
    }
}

#pragma mark 显示影藏 页面加载失败
- (void)showLoadFail
{
    [self hideRuningMan];

    if (self.loadFail.superview == self.view) {
        return;
    }
    self.loadFail.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height);
    self.loadFail.backgroundColor = SFKColorGray;
    [self.view addSubview:self.loadFail];
    [self.view bringSubviewToFront:self.loadFail];
    
    // 刷新按钮 点击事件
    WeakSelf
    [weakSelf_SC.loadFail addRefreshBlockWithBtn:^{
        
        [weakSelf_SC loadDataSources];
    }];
}

- (void)hideLoadFail
{
    if (_loadFail) {
        [_loadFail removeFromSuperview];
        _loadFail = nil;
    }
}

- (void)hideLoadingAndLoadFail
{
    [self hideRuningMan];
    [self hideLoadFail];
}

#pragma mark 打开一个网页
- (void)openUrlOnWebViewWithURL:(NSURL *)url type:(CHANGE_VIEWCONTROLLER_TYPE)type
{

}

#pragma mark - 线程处理
#pragma mark 在后台线程处理
- (void)asyncBackgroundQueue:(void (^)())block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        block();
    });
}

#pragma mark 在主线程
- (void)asyncMainQueue:(void (^)())block
{
    dispatch_async(dispatch_get_main_queue(), ^{
        block();
    });
}

- (void)userLogoutAction{}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark didReceiveMemoryWarning
- (void)didReceiveMemoryWarning
{
    NSLog(@"[%@]->didReceiveMemoryWarning.....",NSStringFromClass([self class]));
    [super didReceiveMemoryWarning];
    
    // 是否是正在使用的视图
    if ([self.view window] == nil) {

    }
}

#pragma mark tabBarVC 切换手势
- (void)addTabBarVCGestureRecognizer
{
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedLeftButton:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
}

- (void)tappedRightButton:(id)sender
{
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    
    NSArray *aryViewController = self.tabBarController.viewControllers;
    
    if (selectedIndex < aryViewController.count - 1) {
        
        UIView *fromView = [self.tabBarController.selectedViewController view];
        
        UIView *toView = [[self.tabBarController.viewControllers objectAtIndex:selectedIndex + 1] view];
        
        [UIView transitionFromView:fromView toView:toView duration:0.5f options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
            
            if (finished) {
                
                [self.tabBarController setSelectedIndex:selectedIndex + 1];
            }
        }];
    }
}

- (void)tappedLeftButton:(id)sender
{
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    
    if (selectedIndex > 0) {
        
        UIView *fromView = [self.tabBarController.selectedViewController view];
        
        UIView *toView = [[self.tabBarController.viewControllers objectAtIndex:selectedIndex - 1] view];
        
        [UIView transitionFromView:fromView toView:toView duration:0.5f options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
            
            if (finished) {
                
                [self.tabBarController setSelectedIndex:selectedIndex - 1];
            }
        }];
    }
}

@end
