
//
//  SFShareView.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/21.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFShareView.h"
#import "SFWeChatManager.h"
#import "UIView+ViewController.h"

@interface SFShareView ()

@property (nonatomic, strong) UIWindow *backWindow;

@end

@implementation SFShareView
{
    /** 暗黑色的view */
    UIView *_darkView;
    /** 所有按钮的底部view */
    UIView *_bottomView;
    NSMutableArray *_buttons;
}

- (void)dealloc
{
    NSString *currentClazzName = [NSString stringWithUTF8String:object_getClassName(self)];
    NSLog(@"--> (%@已销毁)", currentClazzName);
}

+ (void)showShareView
{
    NSArray *shareArr = @[@{@"image":@"shareView_wx",
                            @"title":@"微信好友"},
                          @{@"image":@"shareView_friend",
                            @"title":@"朋友圈"},
                          @{@"image":@"shareView_qq",
                            @"title":@"微博"},
                          @{@"image":@"shareView_qzone",
                            @"title":@"QQ好友"},
                          @{@"image":@"shareView_wb",
                            @"title":@"QQ空间"},
                          @{@"image":@"shareView_rr",
                            @"title":@"保存到手机"}];
    
    SFShareView *shareView = [SFShareView shareWithSnsNames:shareArr];
    [shareView show];
}

+ (instancetype)shareWithSnsNames:(NSArray *)snsNames
{
    return [[self alloc] initWithSnsNames:snsNames];
}

- (instancetype)initWithSnsNames:(NSArray *)snsNames
{
    if (self = [super init]) {
        
        [self setUpWith:snsNames];
    }
    return self;
}

- (UIView *)ittemWithFrame:(CGRect)frame dic:(NSDictionary *)dic index:(NSInteger)index {
    
    NSString *image = dic[@"image"];
    NSString *highlightedImage = dic[@"highlightedImage"];
    NSString *title = [dic[@"title"] length] > 0 ? dic[@"title"] : @"";
    
    UIImage *icoImage = [UIImage imageNamed:image];
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((view.frame.size.width-icoImage.size.width)/2, 0, icoImage.size.width, icoImage.size.height);
    button.titleLabel.font = [UIFont systemFontOfSize:_titleSize];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    if (image.length > 0) {
        [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    if (highlightedImage.length > 0) {
        [button setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    }
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = index;
    [view addSubview:button];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, button.frame.origin.y +button.frame.size.height+ _lastlySpace, view.frame.size.width, _titleSize)];
    label.textColor = _titleColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:_titleSize];
    label.text = title;
    [view addSubview:label];
    
    return view;
}

- (void)setUpWith:(NSArray *)snsNames
{
    _originX = HXOriginX;
    _originY = HXOriginY;
    _icoWidth = HXIcoWidth;
    _icoAndTitleSpace = HXIcoAndTitleSpace;
    _titleSize = HXTitleSize;
    _titleColor = HXTitleColor;
    _lastlySpace = HXLastlySpace;
    _horizontalSpace = HXHorizontalSpace;
    
    // 暗黑色的view
    UIView *darkView = [UIView new];
    darkView.alpha = 0;
    darkView.userInteractionEnabled = NO;
    darkView.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height);
    darkView.backgroundColor = RGB(46, 49, 50);
    [self addSubview:darkView];
    _darkView = darkView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [darkView addGestureRecognizer:tap];
                        
    // 所有按钮的底部view
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = RGB(233, 233, 238);
    [self addSubview:bottomView];
    _bottomView = bottomView;

    UILabel *titleLab = [UILabel new];
    titleLab.frame = CGRectMake(0, 0, Main_Screen_Width, 44);
    titleLab.backgroundColor = [UIColor whiteColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = [UIColor blackColor];
    titleLab.font = [UIFont systemFontOfSize:16];
    titleLab.text = @"分享到";
    [bottomView addSubview:titleLab];
    
    UIScrollView *scrollView = [UIScrollView new];
    
    for (NSDictionary *shareDic in snsNames) {
        NSUInteger i = [snsNames indexOfObject:shareDic];
        CGRect frame = CGRectMake(_originX+i*(_icoWidth+_horizontalSpace), _originY, _icoWidth, _icoWidth+_icoAndTitleSpace+_titleSize);;
        UIView *view = [self ittemWithFrame:frame dic:shareDic index:i];
        [scrollView addSubview:view];
    }
    
    scrollView.frame = CGRectMake(0, titleLab.bottom + 1, Main_Screen_Width, [SFShareView getShareScrollViewHeight]);
    scrollView.contentSize = CGSizeMake((_icoWidth + _icoAndTitleSpace) * snsNames.count + _icoWidth, [SFShareView getShareScrollViewHeight]);
    scrollView.backgroundColor = [UIColor whiteColor];
    [bottomView addSubview:scrollView];
   

    UIButton *cancelBtn = [UIButton new];
    cancelBtn.frame = CGRectMake(0, scrollView.bottom + 1, Main_Screen_Width, 44);
    cancelBtn.backgroundColor = [UIColor whiteColor];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    WeakSelf
    [cancelBtn bk_whenTapped:^{
        [weakSelf_SC hide];
    }];
    [bottomView addSubview:cancelBtn];
    
    bottomView.frame = CGRectMake(0, Main_Screen_Height, Main_Screen_Width, 90 + [SFShareView getShareScrollViewHeight]);
    self.frame = CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height);
    
    [self.backWindow addSubview:self];
}

- (void)show
{
    _backWindow.hidden = NO;
    
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         [_darkView setAlpha:0.4f];
                         [_darkView setUserInteractionEnabled:YES];
                         
                         CGRect frame = _bottomView.frame;
                         frame.origin.y -= frame.size.height;
                         [_bottomView setFrame:frame];
                     }
                     completion:nil];
}

- (void)hide
{
    _backWindow.hidden = NO;
    
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         
                         [_darkView setAlpha:0];
                         [_darkView setUserInteractionEnabled:NO];
                         
                         CGRect frame = _bottomView.frame;
                         frame.origin.y += frame.size.height;
                         [_bottomView setFrame:frame];
;
                     }
                     completion:^(BOOL finished) {
                         
                         _backWindow.hidden = YES;
                         
                         [self removeFromSuperview];
                     }];
}

- (UIWindow *)backWindow
{    
    if (_backWindow == nil) {
        
        _backWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backWindow.windowLevel       = UIWindowLevelStatusBar;
        _backWindow.backgroundColor   = [UIColor clearColor];
        _backWindow.hidden = NO;
    }
    return _backWindow;
}

+ (float)getShareScrollViewHeight {
    float height = HXOriginY+HXIcoWidth+HXIcoAndTitleSpace+HXTitleSize+HXLastlySpace;
    return height;
}

/**
 *  分享按钮点击事件
 *
 *  @param sender
 */
- (void)buttonAction:(UIButton *)sender {

    NSString *typeName;
    switch (sender.tag) {
        case 0:
            typeName = UMShareToWechatSession; // 微信好友
            break;
        case 1:
            typeName = UMShareToWechatTimeline; // 微信朋友圈
            break;
        case 2:
            typeName = UMShareToQQ; // qq好友
            break;
        case 3:
            typeName = UMShareToQzone; // qq空间
            break;
        case 4:
            typeName = UMShareToSina; // qq空间
            break;

        default:
            break;
    }
    
    // 获取当前视图
    UIViewController *currentVC = self.viewController;
    
    [[logicShareInstance getShareManager] shareWithType:typeName presentedController:currentVC successBlock:^{
        
    } errorBlock:^(NSString *error) {
        
    }];
}

@end
