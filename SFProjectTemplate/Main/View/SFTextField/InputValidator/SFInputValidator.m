
//
//  SFInputValidator.m
//  SFProjectTemplate
//
//  Created by sessionCh on 16/4/27.
//  Copyright © 2016年 www.sunfobank.com. All rights reserved.
//

#import "SFInputValidator.h"

@implementation SFInputValidator

- (BOOL)validateInput:(UITextField *)input {
    return NO;
}

- (BOOL)validateCharacter:(NSString *)string textField:(UITextField *)textField range:(NSRange)range
{
    return YES;
}

/**
 *  显示错误提示
 *
 *  @param errorMessage
 */
- (void)showErrorMessage:(NSString *)errorMessage
{
    if (SFIsNull(errorMessage)) return ;
    
    NSDictionary *options = @{
                              kCRToastTextKey : errorMessage,
                              kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                              kCRToastBackgroundColorKey : SFKColorGolden,
                              kCRToastAnimationInTypeKey : @(CRToastAnimationTypeSpring),
                              kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeSpring),
                              kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
                              kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop)
                              };
    [CRToastManager dismissAllNotifications:NO];
    [CRToastManager showNotificationWithOptions:options
                                completionBlock:^{
                                }];

}

/**
 *  剔除卡号里的非法字符(仅保留数字)
 *
 *  @param s 需要处理的字符串
 *
 *  @return 处理后的字符串
 */
- (NSString *)getDigitsOnly:(NSString *)s
{
    NSString *digitsOnly = @"";
    char c;
    for (NSInteger i = 0; i < s.length; i++)
    {
        c = [s characterAtIndex:i];
        if (isdigit(c))
        {
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    return digitsOnly;
}

/**
 *  格式化输入框中的内容
 *
 *  @param textField 输入框
 *  @param string    当前改变的字符串
 *  @param range     改变字符串所在位置
 *  @param maxLen     格式化后字符串最大长度
 *
 *  @return 是否有效改变
 */
- (BOOL)formatTextField:(UITextField *)textField validateCharacter:(NSString *)string range:(NSRange)range maxLen:(NSInteger)maxLen
{
    NSString *text = [textField text];
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    string = [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    }
    
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    NSString *newString = @"";
    while (text.length > 0) {
        NSString *subString = [text substringToIndex:MIN(text.length, 4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 4) {
            newString = [newString stringByAppendingString:@"-"];
        }
        text = [text substringFromIndex:MIN(text.length, 4)];
    }
    
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    
    if (newString.length >= maxLen) {
        return NO;
    }
    
    [textField setText:newString];
    
    return NO;
}


@end
