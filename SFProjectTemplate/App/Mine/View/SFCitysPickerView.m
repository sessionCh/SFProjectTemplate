//
//  SFCitysPickerView.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/7/11.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFCitysPickerView.h"

@interface SFCitysPickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, copy) DidSelectRowBlock didSelectRowBlock;

@end

@implementation SFCitysPickerView

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    
    [self.pickerView reloadAllComponents];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.pickerView.frame = self.bounds;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _pickerView = [[UIPickerView alloc] initWithFrame:self.bounds];
        _pickerView.delegate = self;
        [self addSubview:_pickerView];
    }
    return self;
}

//- (void)setType:(SFCityType)type
//{
//    if (_type != type) {
//        [self selectedRowInComponent:0];
//    }
//    _type = type;
//}

- (void)selectedRowInComponent:(NSInteger)row
{
    if (row < self.dataArray.count) {
        [self.pickerView selectedRowInComponent:row];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    SFCityModel *model = self.dataArray[row];
    return model.areaName;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    SFCityModel *model = self.dataArray[row];
    model.row = row;
    WeakSelf
    if (self.didSelectRowBlock) {
        _didSelectRowBlock(model, weakSelf_SC.type);
    }
}

- (void)didSelectRowBlock:(DidSelectRowBlock)didSelectRowBlock
{
    self.didSelectRowBlock = didSelectRowBlock;
}

@end
