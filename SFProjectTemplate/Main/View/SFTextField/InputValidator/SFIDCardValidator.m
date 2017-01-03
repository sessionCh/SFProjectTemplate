//
//  SFIDCardValidator.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/27.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFIDCardValidator.h"

@implementation SFIDCardValidator

- (BOOL)validateInput:(UITextField *)input {
    
    if (input.text.length <= 0) {
        
//        self.errorMessage = @"没有输入!";
        
    } else {
        BOOL isMatch = [input.text isMatch:RX(@"^\\d{15}|\\d{18}$")];
        
        // 求和验证
        isMatch = isMatch && [self isRealIDCode:input.text];

        if (isMatch == NO) {
            
            self.errorMessage = @"请输入正确的身份证号!";
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
        
    } else if(range.location == 0 && range.length!= 0) {
        
        //内容被删除为空
    }
    
    // 限制输入的最大长度.
    NSInteger maxLen = 18;
    if(range.location >= maxLen) {
        //返回NO, 表示不允许替换, 即不接受输入的新字符
        return NO;
    }
    
    // 验证输入的内容是否由 数字、字母组成
    return [SFValidatorTool validatorCharacters:string];
}

/**
 *  身份证校验和
 *
 *  @param realCode 输入的身份证
 *
 *  @return 是否合法
 */
- (BOOL)isRealIDCode:(NSString *)realCode {
    
    if (realCode.length < 18) {
        return false;
    }
    
    NSArray *ds = @[@7, @9, @10, @5, @8, @4, @2, @1, @6, @3, @7, @9, @10, @5, @8, @4, @2];
    NSInteger total = 0;
    
    for (NSInteger i = 0; i < 17; i++) {
        
        NSRange currentRange = NSMakeRange(i, 1);
        NSString *currentCode = [realCode substringWithRange:currentRange];
        NSInteger currentCodeInteger = [currentCode integerValue];
        
        NSInteger dsi = [ds[i] integerValue];
        total += currentCodeInteger * dsi;
    }
    
    total = total % 11;
    NSArray *ends = @[@"1", @"0", @"x", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    NSString *end = ends[total];
    
    if ([end isEqualToString:[[realCode substringWithRange:NSMakeRange(17, 1)] lowercaseString]]) {
        return YES;
    }
    
    return NO;
}

@end
