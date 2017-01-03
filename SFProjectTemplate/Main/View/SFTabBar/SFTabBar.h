//
//  SFTabBar.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/18.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SFTabBar;

@protocol SFTabBarDelegate <NSObject>

- (void) tabBar:(SFTabBar *)tabBar selectedFrom:(NSInteger) from to:(NSInteger)to;

@end

@interface SFTabBar : UIView

@property(nonatomic,weak) id<SFTabBarDelegate> delegate;

+ (SFTabBar *)initWithFrame:(CGRect)frame titles:(NSArray *)titles imageNames:(NSArray *)imageNames selectedImageNames:(NSArray *)selectedImageNames;

- (void)selectedBtn:(NSInteger)index;

@end
