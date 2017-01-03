//
//  SFBindBankCardViewController.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/7/4.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//


#import "SFBindBankCardViewController.h"
#import "UIView+Corner.h"
#import "SFCitysPickerView.h"

@interface SFBindBankCardViewController ()

@property (weak, nonatomic) IBOutlet UIView *view2;

@property (weak, nonatomic) IBOutlet UILabel *right_lab1;
@property (weak, nonatomic) IBOutlet UILabel *right_lab2;
@property (weak, nonatomic) IBOutlet UILabel *right_lab3;
@property (weak, nonatomic) IBOutlet UILabel *right_lab4;
@property (weak, nonatomic) IBOutlet UITextField *right_field1;
@property (weak, nonatomic) IBOutlet UITextField *right_field2;
@property (weak, nonatomic) IBOutlet UITextField *right_field3;
@property (weak, nonatomic) IBOutlet UITextField *right_field4;

- (IBAction)right_btn1Click:(UIButton *)sender;
- (IBAction)right_btn2Click:(UIButton *)sender;
- (IBAction)right_btn3Click:(UIButton *)sender;
- (IBAction)right_btn4Click:(UIButton *)sender;

@property (nonatomic, strong) NSArray<SFCityModel *> *provinces; // 所有省
@property (nonatomic, strong) NSArray<SFCityModel *> *citys; // 当前所有市
@property (nonatomic, strong) SFCityModel *currentProvince; // 当前省
@property (nonatomic, strong) SFCityModel *currentCity; // 当前市

@property (nonatomic, strong) SFCitysPickerView *cityPickerView;

@end

@implementation SFBindBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.right_field2 setEnabled:NO];
    [self.right_field3 setEnabled:NO];
    [self.view addSubview:self.cityPickerView];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    // top 圆角
    [self.view2 addRoundedCorners:UIRectCornerTopRight | UIRectCornerTopLeft withRadii:CGSizeMake(6, 6)];
    
    CGFloat pickerViewH = 160.0f;
    self.cityPickerView.frame = CGRectMake(0, HEIGHT_SCREEN - pickerViewH, WIDTH_SCREEN, pickerViewH);
}

#pragma mark - setter/getter

- (void)setCurrentProvince:(SFCityModel *)currentProvince
{
    _currentProvince = currentProvince;
    self.currentCity = nil;
    self.citys = nil;
    self.right_field2.text = self.currentProvince.areaName;
}

- (void)setCurrentCity:(SFCityModel *)currentCity
{
    _currentCity = currentCity;
    self.right_field3.text = self.currentCity.areaName;
}

- (void)setProvinces:(NSArray<SFCityModel *> *)provinces
{
    _provinces = provinces;
    
    if (provinces.count > 0 && self.currentProvince == nil) {
        self.currentProvince = provinces[0];
    }
}

- (void)setCitys:(NSArray<SFCityModel *> *)citys
{
    _citys = citys;
    if (citys.count > 0 && self.currentCity == nil) {
        self.currentCity = citys[0];
    }
}

- (SFCitysPickerView *)cityPickerView
{
    if (!_cityPickerView) {
        _cityPickerView = [SFCitysPickerView new];
        WeakSelf
        [_cityPickerView didSelectRowBlock:^(SFCityModel *model, SFCityType type) {
            if (type == SFCityTypeProvince) {
                weakSelf_SC.currentProvince = model;
                [weakSelf_SC right_btn3Click:nil];
                
            } else if (type == SFCityTypeCity) {
                weakSelf_SC.currentCity = model;
            }
        }];
    }
    return _cityPickerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)right_btn1Click:(UIButton *)sender {
}

- (IBAction)right_btn2Click:(UIButton *)sender {
    
    if (!self.provinces) {
        WeakSelf
        [[logicShareInstance getBindBankCardManager] queryCityWithParentAreaId:@"NULL" callBackBlock:^(NSArray<SFCityModel *> *citys) {
            weakSelf_SC.provinces = citys;
            weakSelf_SC.cityPickerView.type = SFCityTypeProvince;
            weakSelf_SC.cityPickerView.dataArray = weakSelf_SC.provinces;
            [weakSelf_SC.cityPickerView selectedRowInComponent:weakSelf_SC.currentProvince.row];
        }];
    } else {
        self.cityPickerView.type = SFCityTypeProvince;
        self.cityPickerView.dataArray = self.provinces;
    }
}

- (IBAction)right_btn3Click:(UIButton *)sender {
    
    if (!self.currentProvince) return;
    
    if (!self.citys) {
        WeakSelf
        [[logicShareInstance getBindBankCardManager] queryCityWithParentAreaId:[NSString stringWithFormat:@"%ld", self.currentProvince.areaId] callBackBlock:^(NSArray<SFCityModel *> *citys) {
            weakSelf_SC.citys = citys;
            weakSelf_SC.cityPickerView.type = SFCityTypeCity;
            weakSelf_SC.cityPickerView.dataArray = weakSelf_SC.citys;
            [weakSelf_SC.cityPickerView selectedRowInComponent:weakSelf_SC.currentCity.row];
        }];
    } else {
        self.cityPickerView.type = SFCityTypeCity;
        self.cityPickerView.dataArray = self.citys;
        [self.cityPickerView selectedRowInComponent:self.currentCity.row];
    }
}

- (IBAction)right_btn4Click:(UIButton *)sender {
    
    NSLog(@"--(%@ %@)--", self.currentProvince.areaName, self.currentCity.areaName);
}

@end
