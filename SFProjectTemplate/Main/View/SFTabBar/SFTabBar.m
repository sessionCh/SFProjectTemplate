
//
//  SFTabBar.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/18.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFTabBar.h"
#import "SFTabBarButton.h"

@interface SFTabBar ()

@property (nonatomic, strong) SFTabBarButton *selectedBtn;

@end

@implementation SFTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

+ (SFTabBar *)initWithFrame:(CGRect)frame titles:(NSArray *)titles imageNames:(NSArray *)imageNames selectedImageNames:(NSArray *)selectedImageNames
{
    SFTabBar *tabBar = [[SFTabBar alloc] initWithFrame:frame];
    
    for (NSInteger i = 0; i < titles.count; i++) {
        
        SFTabBarButton *tabBarBtn = [SFTabBarButton initWithTitle:titles[i] imageName:imageNames[i] selectedImageName:selectedImageNames[i]];
        
        [tabBarBtn setTitle:titles[i] forState:UIControlStateNormal];
        [tabBarBtn setImage:[UIImage imageNamed:imageNames[i]] forState:UIControlStateNormal];
        [tabBarBtn setImage:[UIImage imageNamed:selectedImageNames[i]] forState:UIControlStateSelected];
        
        [tabBarBtn addTarget:tabBar action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [tabBar addSubview:tabBarBtn];

        if (tabBar.subviews.count == 1) {
            [tabBar clickBtn:tabBarBtn];
        }
    }
    return tabBar;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    int count = (int)self.subviews.count;
    for (int i = 0; i < count; i++) {
        SFTabBarButton *tabBarBtn = self.subviews[i];
        tabBarBtn.tag = i;
        CGFloat x = i * self.bounds.size.width / count;
        CGFloat y = 0;
        CGFloat width = self.bounds.size.width / count;
        CGFloat height = self.bounds.size.height;
        tabBarBtn.frame = CGRectMake(x, y, width, height);
    }
}

- (void)clickBtn:(SFTabBarButton *)button {
    
    self.selectedBtn.selected = NO;
    button.selected = YES;
    self.selectedBtn = button;
    
    if ([self.delegate respondsToSelector:@selector(tabBar:selectedFrom:to:)]) {
        [self.delegate tabBar:self selectedFrom:self.selectedBtn.tag to:button.tag];
    }
}

- (void)selectedBtn:(NSInteger)index
{
    self.selectedBtn.selected = NO;
    SFTabBarButton * button = self.subviews[index];
    button.selected = YES;
    self.selectedBtn = button;
}

@end

