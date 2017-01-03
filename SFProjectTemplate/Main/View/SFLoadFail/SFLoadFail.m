//
//  SFLoadFail.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/20.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFLoadFail.h"

@interface SFLoadFail ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) UILabel *tipLab;
@property (nonatomic, strong) UIButton *refreshBtn;

@end

@implementation SFLoadFail
{
    RefreshAction _refreshAction;
    CGFloat _widthHeigthRatio; // 与视图长宽比
}

- (void)dealloc
{
    NSString *currentClazzName = [NSString stringWithUTF8String:object_getClassName(self)];
    NSLog(@"--> (%@已销毁)", currentClazzName);
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}


#pragma mark - Init

- (void)initialize
{
    // 图片与视图比例
    _widthHeigthRatio = 0.4;
    
    _imageView = [UIImageView new];
    _imageView.image = [UIImage imageNamed:@"网络失联"];
    
    _contentLab = [UILabel new];
    _contentLab.textColor = [UIColor blackColor];
    _contentLab.textAlignment = NSTextAlignmentCenter;
    _contentLab.text = @"网络君失联了，肿么办？";
    _contentLab.font = [UIFont systemFontOfSize:15];
    
    _tipLab = [UILabel new];
    _tipLab.textColor = [UIColor grayColor];
    _tipLab.textAlignment = NSTextAlignmentCenter;
    _tipLab.text = @"点击刷新找回";
    _tipLab.font = [UIFont systemFontOfSize:15];
    
    _refreshBtn = [UIButton new];
    [_refreshBtn setBackgroundImage:[UIImage imageNamed:@"按钮黄色"] forState:UIControlStateNormal];
    [_refreshBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    _refreshBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [_refreshBtn setTitle:@"刷新" forState:UIControlStateNormal];
    [_refreshBtn addTarget:self action:@selector(refreshClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self sd_addSubviews:@[_imageView, _contentLab, _tipLab, _refreshBtn]];

    // 页面布局
    CGFloat _imageViewH = 122.0 / 194.0 * _widthHeigthRatio;

    _imageView.sd_layout
    .centerXEqualToView(self)
    .centerYIs(Main_Screen_Height / 2.0 - 150.0)
    .widthRatioToView(self, _widthHeigthRatio)
    .heightRatioToView(self, _imageViewH);
    
    _contentLab.sd_layout
    .centerXEqualToView(self)
    .widthIs(200.0)
    .topSpaceToView(_imageView, 10.0)
    .autoHeightRatio(0); // 此行设置label文字自适应
    
    _tipLab.sd_layout
    .centerXEqualToView(self)
    .widthIs(200.0)
    .topSpaceToView(_contentLab, 10.0)
    .autoHeightRatio(0);
    
    _refreshBtn.sd_layout
    .centerXEqualToView(self)
    .widthIs(120)
    .topSpaceToView(_tipLab, 10.0)
    .heightIs(40);
}

/**
 *  点击刷新按钮
 */
- (void)refreshClick
{
    if (_refreshAction) {
        _refreshAction();
    }
}

/**
 *  刷新按钮点击事件
 *
 *  @param refreshAction
 */
- (void) addRefreshBlockWithBtn:(RefreshAction)refreshAction
{
    _refreshAction = refreshAction;
}

@end
