//
//  SFPhoneNumberValidator.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/27.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFPhoneNumberValidator.h"

@implementation SFPhoneNumberValidator

- (BOOL)validateInput:(UITextField *)input {

    if (input.text.length <= 0) {
        
//        self.errorMessage = @"没有输入!";
        
    } else {
        
        // 剔除非法字符（仅保留数字）
        NSString *digitsOnly = [self getDigitsOnly:input.text];
        
        BOOL isMatch = [digitsOnly isMatch:RX(@"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$")];
        if (isMatch == NO) {
            
            [self showErrorMessage:self.errorMessage];
            self.errorMessage = @"请输入正确的手机号码!";
            
        } else {
            
            self.errorMessage = nil;
        }
    }
    
    return self.errorMessage == nil ? YES : NO;
}

- (BOOL)validateCharacter:(NSString *)string textField:(UITextField *)textField range:(NSRange)range
{
    // 监控UITextField是否已有内容
    if(range.length <= 0) {
        
        //有内容
        
    } else if(range.location == 0 && range.length != 0) {
        
        //内容被删除为空
    }
    
    // 限制输入的最大长度.
    NSInteger maxLen = 14;
    if(range.location >= maxLen) {
        //返回NO, 表示不允许替换, 即不接受输入的新字符
        return NO;
    }

    // 验证输入的内容是否为 数字组成
    if ([SFValidatorTool validatorNumbers:string]) {
        // 格式化手机号
        [self formatTextField:textField validateCharacter:string range:range maxLen:maxLen];
    }
    return NO;
}

@end
