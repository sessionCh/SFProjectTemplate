//
//  SFRefreshHeader.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/19.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFRefreshHeader.h"

@implementation SFRefreshHeader 

#pragma mark - 重写方法
- (void)prepare
{
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=16; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Dropdown_%ld", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=16; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Dropdown_%ld", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages duration:0.4 forState:MJRefreshStateRefreshing];
}

@end
