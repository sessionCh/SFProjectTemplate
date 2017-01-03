//
//  SFLoadFail.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/20.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^RefreshAction)();

@interface SFLoadFail : UIView

/**
 *  刷新按钮点击事件
 *
 *  @param refreshAction
 */
- (void) addRefreshBlockWithBtn:(RefreshAction)refreshAction;

@end
