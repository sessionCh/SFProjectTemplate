//
//  SFCitysPickerView.h
//  SFProjectTemplate
//
//  Created by sessionCh on 16/7/11.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SFCityType) {
    SFCityTypeProvince = 0,
    SFCityTypeCity
};

typedef void (^DidSelectRowBlock)(SFCityModel *model, SFCityType type);

@interface SFCitysPickerView : UIView

@property (nonatomic, strong) NSArray<SFCityModel *> *dataArray;
@property (nonatomic, assign) SFCityType type;

- (void)didSelectRowBlock:(DidSelectRowBlock)didSelectRowBlock;
- (void)selectedRowInComponent:(NSInteger)row;

@end
