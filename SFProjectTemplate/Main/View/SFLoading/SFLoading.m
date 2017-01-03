//
//  SFLoading.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/19.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFLoading.h"

@interface SFLoading ()

@property (strong, nonatomic)  YLImageView *imgView;
@property (strong, nonatomic)  UILabel *alertLab;

@end

@implementation SFLoading

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
    
    _imgView.size = CGSizeMake(177/2, 157/2);
    _alertLab.size = CGSizeMake(Main_Screen_Width, 30);
    _imgView.center = CGPointMake(Main_Screen_Width / 2, Main_Screen_Height / 2 - _alertLab.height / 2 - 64);
    _alertLab.center = CGPointMake(Main_Screen_Width / 2, _imgView.bottom);
}

#pragma mark - Init

- (void)initialize
{
    _imgView = [[YLImageView alloc] init];
    _imgView.image = [YLGIFImage imageNamed:@"loading_human.gif"];
    [self addSubview:_imgView];
    
    _alertLab = [[UILabel alloc] init];
    _alertLab.textColor = [UIColor darkGrayColor];
    _alertLab.textAlignment = 1;
    _alertLab.text = @"努力加载中...";
    _alertLab.font = [UIFont systemFontOfSize:15];
    [self addSubview:_alertLab];
}

@end
