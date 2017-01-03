//
//  SFUserNameValidator.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/5/6.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFUserNameValidator.h"

@implementation SFUserNameValidator

- (BOOL)validateInput:(UITextField *)input {
    
    if (input.text.length <= 0) {
        
        //        self.errorMessage = @"没有输入!";
        
    } else {
        
//        BOOL isMatch = [input.text isMatch:RX(@"^[a-zA-Z]\\w{5,15}$")];
        BOOL isMatch = [input.text isValidWithMinLenth:6 maxLenth:16 containChinese:NO firstCannotBeDigtal:YES];
        if (isMatch == NO) {
            
            self.errorMessage = @"请输入正确的用户名!";
            
            [self showErrorMessage:self.errorMessage];
            
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
    if(range.location + range.length > textField.text.length) {
        //返回NO, 表示不允许替换, 即不接受输入的新字符
        return NO;
    }
    NSInteger maxLen = 16;
    NSInteger newLen = textField.text.length + string.length - range.length;
    if (newLen > maxLen) {
        self.errorMessage = @"输入的用户名不能超过16个字符哦!";
        [self showErrorMessage:self.errorMessage];
        return NO;
    }
    
    // 验证输入的内容是否为 字母数字组成
    return [SFValidatorTool validatorCharacters:string];
}

@end
