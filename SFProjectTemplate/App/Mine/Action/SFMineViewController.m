//
//  SFMineViewController.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/18.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFMineViewController.h"
#import "SFBindBankCardViewController.h"

@interface SFMineViewController ()

@end

@implementation SFMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

// 重写 加载数据源
- (void)loadDataSources {}

- (void)initUI
{
    // 个人信息
    UIButton *btn1 = [UIButton new];
    [btn1 setTitle:@"个人信息" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor grayColor]];
    
    WeakSelf
    [btn1 bk_whenTapped:^{
        
        SFPersonalInfoViewController *vc = [[SFPersonalInfoViewController alloc] init];
        [weakSelf_SC.navigationController pushViewController:vc animated:YES];
    }];
    
    [self.view addSubview:btn1];
    
    btn1.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view, 150)
    .widthIs(120)
    .heightIs(40);
    
    // 绑卡
    UIButton *btn2 = [UIButton new];
    [btn2 setTitle:@"绑定银行卡" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 setBackgroundColor:[UIColor grayColor]];
    
    [btn2 bk_whenTapped:^{
        SFBindBankCardViewController *vc = [[SFBindBankCardViewController alloc] init];
        [weakSelf_SC.navigationController pushViewController:vc animated:YES];
    }];
    [self.view addSubview:btn2];
    btn2.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(btn1, 20)
    .widthIs(120)
    .heightIs(40);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
