//
//  SFNumberPickerView.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/7/14.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFNumberPickerView.h"

@interface SFNumberPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation SFNumberPickerView

+ (SFNumberPickerView *)numberPickerView
{
    CGFloat Width = 200.0;
    CGFloat Height = 60.0;
    return [[SFNumberPickerView alloc] initWithFrame:CGRectMake((WIDTH_SCREEN - Width) / 2, (HEIGHT_SCREEN - Height) / 2 - 60, Width, Height)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.pickerView];
    }
    return self;
}

- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[@0, @1, @2, @3, @4, @5, @6, @7, @8, @9];
    }
    return _dataArray;
}

- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:self.bounds];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
    }
    return _pickerView;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.dataArray.count * 1000;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%@", self.dataArray[row % 10]];
}

@end
