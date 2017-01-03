//
//  SFPopView.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/7/8.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFPopView.h"
#import "SFPopContentView.h"

@interface SFPopView ()

@property (nonatomic, strong) UIView *darkView;
@property (nonatomic, strong) SFPopContentView *contentView;

@property (nonatomic, strong) UIWindow *backWindow;

@property (nonatomic, copy) SFPopViewBlock clickedBlock;

@end

@implementation SFPopView

+ (SFPopView *)popViewWithTitle:(NSString *)title clicked:(SFPopViewBlock)clicked
{
    SFPopView *popView = [[SFPopView alloc] initWithFrame:CGRectZero];
    popView.clickedBlock = clicked;
    return popView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.frame = [UIScreen mainScreen].bounds;
        
        // 背景部分
        _darkView = [[UIView alloc] initWithFrame:self.bounds];
        _darkView.backgroundColor = [UIColor blackColor];
        _darkView.alpha = 0.5f;
        [self addSubview:_darkView];
        [_darkView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
        
        CGFloat padding = 20.0f;
        CGFloat ratio = 0.6f;
        CGFloat width = self.width - padding * 2;
        CGFloat height = width * ratio;
        
        // 内容部分
        _contentView = [SFPopContentView popContentView];
        _contentView.frame = CGRectMake(padding, (self.height - height) / 2 + 50.0, width, height);
        _contentView.backgroundColor = [UIColor lightGrayColor];
        _contentView.layer.masksToBounds = YES;
        _contentView.layer.cornerRadius = 6.0f;
        [self addSubview:_contentView];
        
        self.contentView.cancel_btn.tag = SFPopViewBtnTypeCancel;
        self.contentView.sure_btn.tag = SFPopViewBtnTypeSure;
        [self.contentView.cancel_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [self.contentView.sure_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}

#pragma mark - event

- (void)btnClick:(UIButton *)btn
{
    WeakSelf
    if (self.clickedBlock) {
        self.clickedBlock(btn.tag, weakSelf_SC);
    }
}


#pragma mark - setter/getter

- (UIWindow *)backWindow {
    
    if (!_backWindow) {
        
        _backWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backWindow.windowLevel       = UIWindowLevelStatusBar;
        _backWindow.backgroundColor   = [UIColor clearColor];
        _backWindow.hidden = NO;
    }
    return _backWindow;
}

#pragma mark - show/dismiss

- (void)show
{
    [self.backWindow addSubview:self];
    self.backWindow.hidden = NO;
    self.contentView.transform = CGAffineTransformMakeScale(0.01, 0.01);

    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.contentView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        self.darkView.userInteractionEnabled = YES;
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.contentView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        self.backWindow.hidden = YES;
        [self removeFromSuperview];
        self.darkView.userInteractionEnabled = NO;
    }];
}

@end
