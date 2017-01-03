
//
//  SFPersonalInfoViewController.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/20.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFPersonalInfoViewController.h"
#import "SFShareView.h"

@interface SFPersonalInfoViewController ()



@property (nonatomic, strong) UILabel *nameLab;

@end

@implementation SFPersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    
    [self loadDataSources];
}

- (void)initUI
{
    self.title = @"个人信息";

    UIView *container = self.view;

    _nameLab = [UILabel new];
    _nameLab.textColor = [UIColor blackColor];
    _nameLab.textAlignment = NSTextAlignmentCenter;
    _nameLab.text = @"姓名";
    [self.view addSubview:_nameLab];
    
    _nameLab.sd_layout
    .leftSpaceToView(container, 10)
    .rightSpaceToView(container, 10)
    .topSpaceToView(container, 200)
    .autoHeightRatio(0); // 此行设置label文字自适应
    
    // 分享
    UIButton *shareBtn = [UIButton new];
    [shareBtn setTitle:@"分享按钮" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shareBtn setBackgroundColor:[UIColor grayColor]];
    
    [shareBtn bk_whenTapped:^{
        
        // 显示分享
        [SFShareView showShareView];
    }];
    
    [self.view addSubview:shareBtn];
    
    shareBtn.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(_nameLab, 20)
    .widthIs(120)
    .heightIs(40);
    
    // 分享
    UIButton *payBtn = [UIButton new];
    [payBtn setTitle:@"微信支付" forState:UIControlStateNormal];
    [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [payBtn setBackgroundColor:[UIColor grayColor]];
    
    [payBtn bk_whenTapped:^{
        
        SFWXPayEntity* req             = [[SFWXPayEntity alloc] init];
        req.partnerId           = @"";
        req.prepayId            = @"";
        req.nonceStr            = @"";
        req.timeStamp           = [@"0" intValue];
        req.package             = @"";
        req.sign                = @"";

        [[logicShareInstance getWeChatManager] weChatPaymentWithWechatPayEntity:req WithSuccessBlock:^{
            
        } errorBlock:^(NSString *error) {
            
        }];
    }];
    
    [self.view addSubview:payBtn];
    
    payBtn.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(shareBtn, 20)
    .widthIs(120)
    .heightIs(40);
    
    UILabel *imgLab = [[UILabel alloc] initWithFrame:CGRectMake(100, 300, 300, 40)];
    [self.view addSubview:imgLab];
//    imgLab.sd_layout
//    .centerXEqualToView(self.view)
//    .topSpaceToView(payBtn, 20)
//    .widthIs(300)
//    .heightIs(40);

    
//    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"QQ"];
//    UIFont *font = [UIFont systemFontOfSize:16];
// 
//    // UIImage attachment
//    UIImage *image = [UIImage imageNamed:@"AS_QQ"];
//    NSMutableAttributedString *attachment = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
//    [text appendAttributedString:attachment];
    
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    UIFont *font = [UIFont systemFontOfSize:16];
    
    {
        NSString *title = @"This is UIImage attachment:";
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:nil]];
        
        UIImage *image = [UIImage imageNamed:@"dribbble256_imageio"];
        image = [UIImage imageWithCGImage:image.CGImage scale:2 orientation:UIImageOrientationUp];
        
        NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
        [text appendAttributedString:attachText];
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
    }

    
    imgLab.attributedText = text;

}

// 重写 加载数据源
- (void)loadDataSources
{
    SFUserModel *userModel = [[SFUserModel alloc] init];
    userModel.id = 30963;
    userModel.token = @"d5a5b2693979117158cbd4a6fa439060";
    
    [self showRuningMan];
    
    WeakSelf
    // 获取用户信息
    [self.currentRequest addObject:

    [[logicShareInstance getUserManager] getUserInfo:userModel success:^(id json) {
        
        SFUserModel *user = [SFUserModel yy_modelWithJSON:SFDealNullData(json)[@"user"]];
        
        [weakSelf_SC hideLoadingAndLoadFail];
        
        weakSelf_SC.nameLab.text = user.userName ? user.userName : @"未知";
        [weakSelf_SC.nameLab updateLayout];
        
    } failure:^(NSError *error) {
        
        [weakSelf_SC showLoadFail];
    }]
     ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
