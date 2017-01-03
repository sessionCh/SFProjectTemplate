//
//  SFNumberPickerView.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/7/14.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFNumberPickerView : UIView

@property (nonatomic, strong) UIPickerView *pickerView;

+ (SFNumberPickerView *)numberPickerView;

@end
