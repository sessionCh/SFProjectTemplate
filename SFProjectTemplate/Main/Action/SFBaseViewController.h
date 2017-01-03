//
//  SFBaseViewController.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/18.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "UIViewController+TAPKeyboardPop.h"

typedef NS_ENUM(NSInteger, CHANGE_VIEWCONTROLLER_TYPE) {
    PUSH,
    MODAL,
    ADPUSH//lzj add for ad push with share button
};

@class AppDelegate;

@interface SFBaseViewController : UIViewController

@property (nonatomic, retain) NSMutableArray *currentRequest;   // 当前的网络请求数组

/**
 *  全局的代理实例
 *
 *  @return
 */
- (AppDelegate *)mainDelegate;

#pragma mark - 导航

/**
 *  设置导航标题
 *
 *  @param title
 */
- (void) setNavTitle:(NSString *)title;

#pragma mark - 数据源

/**
 *  加载数据资源
 */

- (void)loadDataSources;

#pragma mark - 网络

/**
 *  取消当前页面的网络请求
 */
- (void) cancelCurrentNetWorkRequest;

#pragma mark - Queue

/**
 *  后台线程执行
 *
 *  @param block
 */
- (void) asyncBackgroundQueue:(void (^)())block;

/**
 *  主线程执行
 *
 *  @param block
 */
- (void) asyncMainQueue:(void (^)())block;

#pragma mark 显示影藏 加载小人

/**
 *  显示加载小人
 *
 */
- (void)showRuningMan;

/**
 *  影藏加载小人
 *
 */
- (void)hideRuningMan;

#pragma mark 显示影藏 页面加载失败
/**
 *  页面加载失败
 */
- (void)showLoadFail;

/**
 *  页面加载失败
 */
- (void)hideLoadFail;

/**
 *  影藏加载页和加载失败页
 */
- (void)hideLoadingAndLoadFail;

#pragma mark 加载网页

/**
 *  打开一个网页
 *
 *  @param url  URL 地址
 *  @param type 推出类型
 */
- (void) openUrlOnWebViewWithURL:(NSURL *)url type:(CHANGE_VIEWCONTROLLER_TYPE)type;

@end
