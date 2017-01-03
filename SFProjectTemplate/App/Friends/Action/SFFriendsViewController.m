//
//  SFFriendsViewController.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/18.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFFriendsViewController.h"
#import "SFTextField.h"

// 校验策略
#import "SFMoneyValidator.h"
#import "SFEmailValidator.h"
#import "SFPhoneNumberValidator.h"
#import "SFIDCardValidator.h"
#import "SFCardNoValidator.h"
#import "SFUserNameValidator.h"

@interface SFFriendsViewController () <UITextFieldDelegate>

/**
 *  输入金额的验证框
 */
@property (nonatomic, strong) SFTextField *moneyField;

/**
 *  输入邮箱的验证框
 */
@property (nonatomic, strong) SFTextField *emailField;

/**
 *  输入电话号码的验证框
 */
@property (nonatomic, strong) SFTextField *phoneNumberField;

/**
 *  输入身份证的验证框
 */
@property (nonatomic, strong) SFTextField *iDCardField;

/**
 *  输入银行卡号的验证框
 */
@property (nonatomic, strong) SFTextField *cardNoField;

/**
 *  输入银行卡号的验证框
 */
@property (nonatomic, strong) SFTextField *userNameField;

@end

@implementation SFFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initSFTextFields];
}

- (void)loadDataSources {}

#pragma mark - 初始化文本输入框
- (void)initSFTextFields {
    
    self.moneyField             = [[SFTextField alloc] initWithFrame:CGRectMake(30, 80, Main_Screen_Width - 60, 30)];
    self.moneyField.keyboardType = UIKeyboardTypeDecimalPad;
    self.moneyField.placeholder = @"请输入金额";
    self.moneyField.delegate    = self;
    self.moneyField.validator   = [SFMoneyValidator new];
    [self.view addSubview:self.moneyField];
    
    self.emailField             = [[SFTextField alloc] initWithFrame:CGRectMake(30, 80 + 40, Main_Screen_Width - 60, 30)];
    self.emailField.keyboardType = UIKeyboardTypeASCIICapable;
    self.emailField.placeholder = @"请输入邮箱";
    self.emailField.delegate    = self;
    self.emailField.validator   = [SFEmailValidator new];
    [self.view addSubview:self.emailField];
    
    
    self.phoneNumberField             = [[SFTextField alloc] initWithFrame:CGRectMake(30, 80 + 40 * 2, Main_Screen_Width - 60, 30)];
    self.phoneNumberField.keyboardType = UIKeyboardTypePhonePad;
    self.phoneNumberField.placeholder = @"请输入电话号码";
    self.phoneNumberField.delegate    = self;
    self.phoneNumberField.validator   = [SFPhoneNumberValidator new];
    [self.view addSubview:self.phoneNumberField];
    
    self.iDCardField             = [[SFTextField alloc] initWithFrame:CGRectMake(30, 80 + 40 * 3, Main_Screen_Width - 60, 30)];
    self.iDCardField.keyboardType = UIKeyboardTypeASCIICapable;
    self.iDCardField.placeholder = @"请输入身份证号";
    self.iDCardField.delegate    = self;
    self.iDCardField.validator   = [SFIDCardValidator new];
    [self.view addSubview:self.iDCardField];
    
    self.cardNoField             = [[SFTextField alloc] initWithFrame:CGRectMake(30, 80 + 40 * 4, Main_Screen_Width - 60, 30)];
    self.cardNoField.keyboardType = UIKeyboardTypeNumberPad;
    self.cardNoField.placeholder = @"请输入银行卡号";
    self.cardNoField.delegate    = self;
    self.cardNoField.validator   = [SFCardNoValidator new];
    [self.view addSubview:self.cardNoField];
    
    self.userNameField             = [[SFTextField alloc] initWithFrame:CGRectMake(30, 80 + 40 * 5 ,Main_Screen_Width - 60, 30)];
    self.userNameField.keyboardType = UIKeyboardTypeASCIICapable;
    self.userNameField.placeholder = @"请输入用户名";
    self.userNameField.delegate    = self;
    self.userNameField.validator   = [SFUserNameValidator new];
    [self.view addSubview:self.userNameField];

}

#pragma mark - 文本框代理
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    SFTextField *customField = (SFTextField *)textField;
    
    if ([customField validate] == NO) {
        
        NSString *title;
        
        if (customField.validator.errorMessage) {
            
            title = customField.validator.errorMessage;
        } else {
            title =  @"校验失败!";
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    SFTextField *customField = (SFTextField *)textField;
    
    return [customField validateCharacter:string range:range];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
