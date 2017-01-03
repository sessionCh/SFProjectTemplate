//
//  SFFounctionCell.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/5/11.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFFounctionCell.h"

@interface SFFounctionCell ()

@property (nonatomic, strong) NSMutableArray *imageViewsData;

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UISwitch *cSwitch;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UIImageView *mainImageView;
@property (nonatomic, strong) UIImageView *subImageView;

@end

@implementation SFFounctionCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [self addSubview:_titleLabel];
        _subTitleLabel = [[UILabel alloc] init];
        [_subTitleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [_subTitleLabel setTextColor:SFKColorGolden];
        [self addSubview:_subTitleLabel];
        _mainImageView = [[UIImageView alloc] init];
        [self addSubview:_mainImageView];
        _subImageView = [[UIImageView alloc] init];
        [self addSubview:_subImageView];
        
        _button = [[UIButton alloc] init];
        [_button.layer setMasksToBounds:YES];
        [_button.layer setCornerRadius:5.0f];
        [_button.layer setBorderWidth:0.5f];
        [_button.layer setBorderColor:DEFAULT_LINE_GRAY_COLOR.CGColor];
        [_button setBackgroundColor:[UIColor whiteColor]];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:_button];
        
        _cSwitch = [[UISwitch alloc] init];
        [self addSubview:_cSwitch];
        
        [_titleLabel setHidden:YES];
        [_subTitleLabel setHidden:YES];
        [_mainImageView setHidden:YES];
        [_subImageView setHidden:YES];
        [_button setHidden:YES];
    }
    return self;
}

- (void) layoutSubviews
{
    self.leftFreeSpace = self.width * 0.05;
    [super layoutSubviews];
    
    if (_item == nil) {
        return;
    }
    
    if (_item.type == SFSettingItemTypeSwitch || _item.type == SFSettingItemTypeButton) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    else {
        [self setSelectionStyle:UITableViewCellSelectionStyleDefault];
    }
    
    // MidTitle
    if (_item.type == SFSettingItemTypeMidTitle) {
        [_titleLabel setFrame:self.bounds];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        return;
    }
    else {
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
    }
    
    // Button
    if (_item.type == SFSettingItemTypeButton) {
        float buttonX = self.width * 0.04;
        float buttonY = self.height * 0.09;
        float buttonWidth = self.width - buttonX * 2;
        float buttonHeight = self.height - buttonY * 2;
        [_button setHidden:NO];
        [_button setFrame:CGRectMake(buttonX, 0, buttonWidth, buttonHeight)];
        return;
    }
    else {
        [_button setHidden:YES];
    }
    
    float spaceX = self.width * 0.05;
    float spaceY = self.height * 0.22;
    float height = self.height - spaceY * 2;
    spaceY -= 0.5;
    
    // 左半部分
    float x = spaceX;
    // 有主图片
    if (_item.imageName != nil && _item.imageName.length > 0) {
        [_mainImageView setFrame:CGRectMake(x, spaceY, height, height)];
        x += height + spaceX;
    }
    // 有主标题
    if (_item.title != nil && _item.title.length > 0) {
        float maxWidth = _item.type == SFSettingItemTypeLeft ? 70 : self.width * 0.45;
        float labelWidth = [_titleLabel sizeThatFits:CGSizeMake(maxWidth, MAXFLOAT)].width;
        [_titleLabel setFrame:CGRectMake(x, spaceY, labelWidth, height)];
        x += maxWidth + spaceX * 0.7;
    }
    
    // 右半部分
    float right = self.accessoryType == UITableViewCellAccessoryDisclosureIndicator ? 32 : 10;
    if (_item.type == SFSettingItemTypeAvatar) {        // 头像Cell
        float x = self.width - right * 1.1;
        float y = self.width * 0.12;
        if (_item.subImageName != nil && _item.subImageName.length > 0) {;
            float w = self.height - y * 2;
            x -= w;
            [_subImageView setFrame:CGRectMake(x, y, w, w)];
        }
    }
    else if (_item.type == SFSettingItemTypeDefaultL) {
        float x = self.width - right;
        if (_item.subTitle != nil && _item.subTitle.length > 0) {
            float maxWidth = self.width * 0.55;
            float labelWidth = [_subTitleLabel sizeThatFits:CGSizeMake(maxWidth, MAXFLOAT)].width;
            labelWidth = labelWidth < maxWidth ? labelWidth : maxWidth;
            x -= labelWidth;
            [_subTitleLabel setFrame:CGRectMake(x, spaceY, labelWidth, height)];
            x -= spaceX * 0.1;
        }
        if (_item.subImageName != nil && _item.subImageName.length > 0) {
            float y = self.height * 0.3;
            float w = self.height - y * 2;
            x -= w;
            [_subImageView setFrame:CGRectMake(x, y, w, w)];
        }
    }
    else if (_item.type == SFSettingItemTypeDefault) {
        float x = self.width - right;
        if (_item.subImageName != nil && _item.subImageName.length > 0) {
            float y = self.height * 0.13;
            float w = self.height - y * 2;
            x -= w;
            [_subImageView setFrame:CGRectMake(x, y, w, w)];
            x -= spaceX * 0.2;
        }
        if (_item.subTitle != nil && _item.subTitle.length > 0) {
            float maxWidth = self.width * 0.55;
            float labelWidth = [_subTitleLabel sizeThatFits:CGSizeMake(maxWidth, MAXFLOAT)].width;
            labelWidth = labelWidth < maxWidth ? labelWidth : maxWidth;
            x -= labelWidth;
            [_subTitleLabel setFrame:CGRectMake(x, spaceY, labelWidth, height)];
        }
    }
    else if (_item.type == SFSettingItemTypeLeft) {
        if (_item.subTitle != nil && _item.subTitle.length > 0) {
            float maxWidth = self.width * 0.45;
            [_subTitleLabel setFrame:CGRectMake(x, spaceY, maxWidth, height)];
        }
        else if (_imageViewsData && _imageViewsData.count > 0) {
            float imageWidth = self.height * 0.65;
            float width = self.width * 0.89 - x;
            float space = 0;
            NSUInteger count = width / imageWidth * 1.1;
            count = count < _imageViewsData.count ? count : _imageViewsData.count;
            for (int i = 0; i < count; i ++) {
                UIImageView *iV = [_imageViewsData objectAtIndex:i];
                [iV setFrame:CGRectMake(x + (imageWidth + space) * i, (self.height - imageWidth) / 2, imageWidth, imageWidth)];
                [iV setHidden:NO];
                space = imageWidth * 0.1;
            }
        }
    }
    else if (_item.type == SFSettingItemTypeSwitch) {
        float x = self.width - right - _cSwitch.width / 1.7;
        [_cSwitch setCenter:CGPointMake(x, self.height / 2.0)];
    }
}

- (void) setItem:(SFSettingItem *)item
{
    _item = item;
    // 主图片
    if (item.imageName != nil && item.imageName.length > 0) {
        [_mainImageView setImage:[UIImage imageNamed:item.imageName]];
        [_mainImageView setHidden:NO];
    }
    else {
        [_mainImageView setHidden:YES];
    }
    // 主标题
    if (item.title != nil && item.title.length > 0) {
        [_titleLabel setText:item.title];
        [_titleLabel setHidden:NO];
    }
    else {
        [_titleLabel setHidden:YES];
    }
    // 副图片
    if (item.subImageName != nil && item.subImageName.length > 0) {
        [_subImageView setImage:[UIImage imageNamed:item.subImageName]];
        [_subImageView setHidden:NO];
        if (_item.type == SFSettingItemTypeAvatar) {
            [_subImageView.layer setMasksToBounds:YES];
            [_subImageView.layer setCornerRadius:5.0f];
        }
        else {
            [_subImageView.layer setMasksToBounds:NO];
        }
    }
    else {
        [_subImageView setHidden:YES];
    }
    // 副标题
    if (item.subTitle != nil && item.subTitle.length > 0) {
        [_subTitleLabel setText:item.subTitle];
        [_subTitleLabel setHidden:NO];
    }
    else {
        [_subTitleLabel setHidden:YES];
    }
    // 图册
    if (_imageViewsData != nil) {
        for (UIImageView *iV in _imageViewsData) {
            [iV removeFromSuperview];
        }
        [_imageViewsData removeAllObjects];
    }
    if (item.subImages != nil && item.subImages.count > 0) {
        if (_imageViewsData == nil) {
            _imageViewsData = [[NSMutableArray alloc] init];
        }
        for (NSString *imageName in item.subImages) {
            UIImageView *iV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
            [_imageViewsData addObject:iV];
            [self addSubview:iV];
        }
    }
    
    // buttonType
    if (_item.type == SFSettingItemTypeButton && _item.title != nil && _item.title.length > 0) {
        [_button setTitle:_item.title forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setTopLineStyle:CellLineStyleNone];
        [self setBottomLineStyle:CellLineStyleNone];
    }
    else {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setSelectionStyle:UITableViewCellSelectionStyleDefault];
    }
    
    // switchType
    if (_item.type == SFSettingItemTypeSwitch) {
        [_cSwitch setHidden:NO];
    }
    else {
        [_cSwitch setHidden:YES];
    }
    
    [self sizeToFit];
}

- (void) setTitleFontSize:(CGFloat)titleFontSize
{
    [_titleLabel setFont:[UIFont systemFontOfSize:titleFontSize]];
}

- (void) setSubTitleFontSize:(CGFloat)subTitleFontSize
{
    [_subTitleLabel setFont:[UIFont systemFontOfSize:subTitleFontSize]];
}

- (void) setSubTitleFontColor:(UIColor *)subTitleFontColor
{
    [_subTitleLabel setTextColor:subTitleFontColor];
}

- (void) setButtonTitleColor:(UIColor *)buttonTitleColor
{
    [_button setTitleColor:buttonTitleColor forState:UIControlStateNormal];
}

- (void) setButtonBackgroundGColor:(UIColor *)buttonBackgroundGColor
{
    [_button setBackgroundColor:buttonBackgroundGColor];
}

- (void)addTarget:(nullable id)target action:(SEL)action
{
    [_button addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    [_cSwitch addTarget:target action:action forControlEvents:UIControlEventEditingChanged];
}


@end