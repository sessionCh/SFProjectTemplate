//
//  SFTabBarController.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/18.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFTabBarController.h"

#import "SFTabBar.h"
#import "SFTabBarButton.h"

#import "SFFinanceViewController.h"
#import "SFGuaranteeViewController.h"
#import "SFFriendsViewController.h"
#import "SFMineViewController.h"

@interface SFTabBarController () <SFTabBarDelegate, UITabBarControllerDelegate>

@property (nonatomic, weak) SFTabBar * myTabBar;

@property (nonatomic, weak) UIButton *selectedBtn;

@end

@implementation SFTabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
        
    [self setupAllChildViewController];
    
    [self setupTabBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    for (UIView * child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

- (void)setupTabBar
{
    NSArray * titles = @[@"理财",@"保障",@"好友",@"我"];
    NSArray * images = @[@"home",@"guarantee",@"friends",@"mine"];
    NSArray * selectedImages = @[@"home_selcted",@"guarantee_selcted",@"friends_selcted",@"mine_selcted"];

    SFTabBar *myTabBar = [SFTabBar initWithFrame:self.tabBar.bounds titles:titles imageNames:images selectedImageNames:selectedImages];
    myTabBar.delegate = self;
    self.myTabBar = myTabBar;
    [self.tabBar addSubview:myTabBar];
}

- (void)setupAllChildViewController
{
    SFFinanceViewController * finance = [[SFFinanceViewController alloc] init];
    [self setChildViewController:finance title:@"理财"];
    
    SFGuaranteeViewController * guarantee = [[SFGuaranteeViewController alloc] init];
    [self setChildViewController:guarantee title:@"保障"];
    
    SFFriendsViewController * friends = [[SFFriendsViewController alloc] init];
    [self setChildViewController:friends title:@"好友"];
    
    SFMineViewController * mine = [[SFMineViewController alloc] init];
    [self setChildViewController:mine title:@"我"];
}

- (void)setChildViewController:(UIViewController *)childController title:(NSString *)title
{
    childController.title = title;
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.text = title;
    [childController.navigationItem setTitleView:titleLabel];
    SFNavigationController * childNav = [[SFNavigationController alloc] initWithRootViewController:childController];
    [self addChildViewController:childNav];
}

- (void)tabBar:(SFTabBar *)tabBar selectedFrom:(NSInteger)from to:(NSInteger)to {
    self.selectedIndex = to;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    [self.myTabBar selectedBtn:selectedIndex];
}

@end
